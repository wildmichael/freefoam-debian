/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 1991-2010 OpenCFD Ltd.
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/error.H>
#include "sigSegvImpl.H"
#include <OpenFOAM/JobInfo.H>
#include <OpenFOAM/IOstreams.H>

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

struct sigaction Foam::sigSegvImpl::oldAction_;

// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

void Foam::sigSegvImpl::sigSegvHandler(int)
{
    // Reset old handling
    if (sigaction(SIGSEGV, &oldAction_, NULL) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigSegvImpl::sigSegvHandler()"
        )   << "Cannot reset SIGSEGV trapping"
            << abort(FatalError);
    }

    // Update jobInfo file
    jobInfo.signalEnd();

    Perr << "\n"
            "************************************************************\n"
            "* FreeFOAM  crashed. See  below  for a  backtrace to  help *\n"
            "* locating the problem.                                    *\n"
            "************************************************************\n";
    error::printStack(Perr);
    Perr << "************************************************************\n"
            "\n";

    // Throw signal (to old handler)
    raise(SIGSEGV);
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sigSegvImpl::sigSegvImpl()
{
    oldAction_.sa_handler = NULL;
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::sigSegvImpl::~sigSegvImpl()
{
    // Reset old handling
    if (sigaction(SIGSEGV, &oldAction_, NULL) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigSegvImpl::~sigSegvImpl()"
        )   << "Cannot reset SIGSEGV trapping"
            << abort(FatalError);
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void Foam::sigSegvImpl::set(const bool verbose)
{
    if (oldAction_.sa_handler)
    {
        FatalErrorIn
        (
            "Foam::sigSegvImpl::set()"
        )   << "Cannot call sigSegvImpl::set() more than once"
            << abort(FatalError);
    }

    struct sigaction newAction;
    newAction.sa_handler = sigSegvHandler;
    newAction.sa_flags = SA_NODEFER;
    sigemptyset(&newAction.sa_mask);
    if (sigaction(SIGSEGV, &newAction, &oldAction_) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigSegvImpl::set()"
        )   << "Cannot set SIGSEGV trapping"
            << abort(FatalError);
    }
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
