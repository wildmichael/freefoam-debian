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
    Write primitive and binary block from mpiOPstreamImpl

\*---------------------------------------------------------------------------*/

#include "mpi.h"

#include "mpiOPstreamImpl.H"
#include "mpiPstreamGlobals.H"
#include <OpenFOAM/addToRunTimeSelectionTable.H>
#include <OpenFOAM/Pstream.H>

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{

defineTypeNameAndDebug(mpiOPstreamImpl, 0);
addToRunTimeSelectionTable(OPstreamImpl, mpiOPstreamImpl, dictionary);

}

// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

void Foam::mpiOPstreamImpl::flush
(
    const PstreamImpl::commsTypes commsType,
    const int toProcNo,
    const char* buf,
    const int bufPosition
)
{
    if
    (
       !write
        (
            commsType,
            toProcNo,
            buf,
            bufPosition
        )
    )
    {
        FatalErrorIn("mpiOPstreamImpl::flush(const PstreamImpl::commsTypes, "
                     "const int, const char*, const int)")
            << "MPI_Bsend cannot send outgoing message"
            << Foam::abort(FatalError);
    }
}

// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

bool Foam::mpiOPstreamImpl::write
(
    const PstreamImpl::commsTypes commsType,
    const int toProcNo,
    const char* buf,
    const std::streamsize bufSize
)
{
    bool transferFailed = true;

    if (commsType == PstreamImpl::blocking)
    {
        transferFailed = MPI_Bsend
        (
            const_cast<char*>(buf),
            bufSize,
            MPI_PACKED,
            Pstream::procID(toProcNo),
            Pstream::msgType(),
            MPI_COMM_WORLD
        );
    }
    else if (commsType == PstreamImpl::scheduled)
    {
        transferFailed = MPI_Send
        (
            const_cast<char*>(buf),
            bufSize,
            MPI_PACKED,
            Pstream::procID(toProcNo),
            Pstream::msgType(),
            MPI_COMM_WORLD
        );
    }
    else if (commsType == PstreamImpl::nonBlocking)
    {
        MPI_Request request;

        transferFailed = MPI_Isend
        (
            const_cast<char*>(buf),
            bufSize,
            MPI_PACKED,
            Pstream::procID(toProcNo),
            Pstream::msgType(),
            MPI_COMM_WORLD,
            &request
        );

        PstreamGlobals::OPstream_outstandingRequests_.append(request);
    }
    else
    {
        FatalErrorIn
        (
            "mpiOPstreamImpl::write"
            "(const int fromProcNo, char* buf, std::streamsize bufSize)"
        )   << "Unsupported communications type " << commsType
            << Foam::abort(FatalError);
    }

    return !transferFailed;
}


void Foam::mpiOPstreamImpl::waitRequests()
{
    if (PstreamGlobals::OPstream_outstandingRequests_.size())
    {
        if
        (
            MPI_Waitall
            (
                PstreamGlobals::OPstream_outstandingRequests_.size(),
                PstreamGlobals::OPstream_outstandingRequests_.begin(),
                MPI_STATUSES_IGNORE
            )
        )
        {
            FatalErrorIn
            (
                "mpiOPstreamImpl::waitRequests()"
            )   << "MPI_Waitall returned with error" << Foam::endl;
        }

        PstreamGlobals::OPstream_outstandingRequests_.clear();
    }
}


bool Foam::mpiOPstreamImpl::finishedRequest(const label i)
{
    if (i >= PstreamGlobals::OPstream_outstandingRequests_.size())
    {
        FatalErrorIn
        (
            "OPstream::finishedRequest(const label)"
            "mpiOPstreamImpl::finishedRequest(const label)"
        )   << "There are "
            << PstreamGlobals::OPstream_outstandingRequests_.size()
            << " outstanding send requests and you are asking for i=" << i
            << nl
            << "Maybe you are mixing blocking/non-blocking comms?"
            << Foam::abort(FatalError);
    }

    int flag;
    MPI_Test
    (
        &PstreamGlobals::OPstream_outstandingRequests_[i],
        &flag,
        MPI_STATUS_IGNORE
    );

    return flag != 0;
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// ************************ vim: set sw=4 sts=4 et: ************************ //
