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

Description
    Read token and binary block from dummyIPstreamImpl

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/error.H>
#include "dummyIPstreamImpl.H"
#include <OpenFOAM/Pstream.H>
#include <OpenFOAM/addToRunTimeSelectionTable.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{

defineTypeNameAndDebug(dummyIPstreamImpl, 0);
addToRunTimeSelectionTable(IPstreamImpl, dummyIPstreamImpl, dictionary);

}

// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void Foam::dummyIPstreamImpl::init
(
    const PstreamImpl::commsTypes commsType,
    const label bufSize,
    int& fromProcNo,
    label& messageSize,
    List<char>& buf
)
{
     notImplemented
     (
         "dummyIPsreamImpl::init"
         "("
             "const commsTypes commsType,"
             "const label bufSize,"
             "const int fromProcNo,"
             "label& messageSize,"
             "List<char>& buf"
         ")"
     );
}


int Foam::dummyIPstreamImpl::read
(
    const PstreamImpl::commsTypes commsType,
    const int fromProcNo,
    char* buf,
    const std::streamsize bufSize
)
{
    notImplemented
    (
        "dummyIPstreamImpl::read"
        "("
            "const commsTypes,"
            "const int fromProcNo,"
            "char* buf,"
            "const label bufSize"
        ")"
     );

     return 0;
}


void Foam::dummyIPstreamImpl::waitRequests()
{}


bool Foam::dummyIPstreamImpl::finishedRequest(const label)
{
    notImplemented("dummyIPstreamImpl::finishedRequest()");
    return false;
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// ************************ vim: set sw=4 sts=4 et: ************************ //
