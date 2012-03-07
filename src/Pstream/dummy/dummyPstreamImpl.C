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

#include "dummyPstreamImpl.H"
#include <OpenFOAM/addToRunTimeSelectionTable.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{

defineTypeNameAndDebug(dummyPstreamImpl, 0);
addToRunTimeSelectionTable(PstreamImpl, dummyPstreamImpl, dictionary);

}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

void Foam::dummyPstreamImpl::addValidParOptions(HashTable<string>& validParOptions)
{}


bool Foam::dummyPstreamImpl::init(int& argc, char**& argv, int& myProcNo, List<int>& procIDs, bool& isParallel)
{
    FatalErrorIn("dummyPstreamImpl::init(int& argc, char**& argv)")
        << "Trying to use the dummy dummyPstreamImpl library." << nl
        << "This dummy library cannot be used in parallel mode"
        << Foam::exit(FatalError);

    return false;
}


void Foam::dummyPstreamImpl::exit(int errnum)
{
    notImplemented("dummyPstreamImpl::exit(int errnum)");
}


void Foam::dummyPstreamImpl::abort()
{
    notImplemented("dummyPstreamImpl::abort()");
}


void Foam::dummyPstreamImpl::reduce(scalar&, const sumOp<scalar>&)
{}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// ************************ vim: set sw=4 sts=4 et: ************************ //
