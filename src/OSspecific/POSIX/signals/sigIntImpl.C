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
#include "sigIntImpl.H"
#include <OpenFOAM/JobInfo.H>
#include <OpenFOAM/IOstreams.H>

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

struct sigaction Foam::sigIntImpl::oldAction_;

// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

void Foam::sigIntImpl::sigIntHandler(int)
{
    // Reset old handling
    if (sigaction(SIGINT, &oldAction_, NULL) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigIntImpl::sigIntHandler()"
        )   << "Cannot reset SIGINT trapping"
            << abort(FatalError);    
    }

    // Update jobInfo file
    jobInfo.signalEnd();

    // Throw signal (to old handler)
    raise(SIGINT);
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sigIntImpl::sigIntImpl()
{
    oldAction_.sa_handler = NULL;
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::sigIntImpl::~sigIntImpl()
{
    // Reset old handling
    if (sigaction(SIGINT, &oldAction_, NULL) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigIntImpl::~sigIntImpl()"
        )   << "Cannot reset SIGINT trapping"
            << abort(FatalError);    
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void Foam::sigIntImpl::set(const bool verbose)
{
    if (oldAction_.sa_handler)
    {
        FatalErrorIn
        (
            "Foam::sigIntImpl::set()"
        )   << "Cannot call sigIntImpl::set() more than once"
            << abort(FatalError);
    }

    struct sigaction newAction;
    newAction.sa_handler = sigIntHandler;
    newAction.sa_flags = SA_NODEFER;
    sigemptyset(&newAction.sa_mask);
    if (sigaction(SIGINT, &newAction, &oldAction_) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigIntImpl::set()"
        )   << "Cannot set SIGINT trapping"
            << abort(FatalError);    
    }
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
