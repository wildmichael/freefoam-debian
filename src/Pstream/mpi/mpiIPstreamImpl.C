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
    Read token and binary block from mpiIPstreamImpl

\*---------------------------------------------------------------------------*/

#include "mpi.h"

#include "mpiIPstreamImpl.H"
#include "mpiPstreamGlobals.H"

#include <OpenFOAM/addToRunTimeSelectionTable.H>
#include <OpenFOAM/Pstream.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{

defineTypeNameAndDebug(mpiIPstreamImpl, 0);
addToRunTimeSelectionTable(IPstreamImpl, mpiIPstreamImpl, dictionary);

}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void Foam::mpiIPstreamImpl::init
(
    const PstreamImpl::commsTypes commsType,
    const label bufSize,
    int& fromProcNo,
    label& messageSize,
    List<char>& buf
)
{
    MPI_Status status;

    // If the buffer size is not specified, probe the incoming message
    // and set it
    if (!bufSize)
    {
        MPI_Probe(Pstream::procID(fromProcNo), Pstream::msgType(), MPI_COMM_WORLD, &status);
        MPI_Get_count(&status, MPI_BYTE, &messageSize);

        buf.setSize(messageSize);
    }

    messageSize = read(commsType, fromProcNo, buf.begin(), buf.size());

    if (!messageSize)
    {
        FatalErrorIn
        (
            "mpiIPstreamImpl::mpiIPstreamImpl(const commsTypes commsType, const label bufSize, "
            "const int fromProcNo, label& messageSize, List<char>& buf)"
        )   << "read failed"
            << Foam::abort(FatalError);
    }
}


Foam::label Foam::mpiIPstreamImpl::read
(
    const PstreamImpl::commsTypes commsType,
    const int fromProcNo,
    char* buf,
    const std::streamsize bufSize
)
{
    if (commsType == PstreamImpl::blocking || commsType == PstreamImpl::scheduled)
    {
        MPI_Status status;

        if
        (
            MPI_Recv
            (
                buf,
                bufSize,
                MPI_PACKED,
                Pstream::procID(fromProcNo),
                Pstream::msgType(),
                MPI_COMM_WORLD,
                &status
            )
        )
        {
            FatalErrorIn
            (
                "mpiIPstreamImpl::read"
                "(const int fromProcNo, char* buf, std::streamsize bufSize)"
            )   << "MPI_Recv cannot receive incoming message"
                << Foam::abort(FatalError);

            return 0;
        }


        // Check size of message read

        label messageSize;
        MPI_Get_count(&status, MPI_BYTE, &messageSize);

        if (messageSize > bufSize)
        {
            FatalErrorIn
            (
                "mpiIPstreamImpl::read"
                "(const int fromProcNo, char* buf, std::streamsize bufSize)"
            )   << "buffer (" << label(bufSize)
                << ") not large enough for incoming message ("
                << messageSize << ')'
                << Foam::abort(FatalError);
        }

        return messageSize;
    }
    else if (commsType == PstreamImpl::nonBlocking)
    {
        MPI_Request request;

        if
        (
            MPI_Irecv
            (
                buf,
                bufSize,
                MPI_PACKED,
                Pstream::procID(fromProcNo),
                Pstream::msgType(),
                MPI_COMM_WORLD,
                &request
            )
        )
        {
            FatalErrorIn
            (
                "mpiIPstreamImpl::read"
                "(const int fromProcNo, char* buf, std::streamsize bufSize)"
            )   << "MPI_Recv cannot start non-blocking receive"
                << Foam::abort(FatalError);

            return 0;
        }

        PstreamGlobals::IPstream_outstandingRequests_.append(request);

        return 1;
    }
    else
    {
        FatalErrorIn
        (
            "mpiIPstreamImpl::read"
            "(const int fromProcNo, char* buf, std::streamsize bufSize)"
        )   << "Unsupported communications type " << commsType
            << Foam::abort(FatalError);

        return 0;
    }
}


void Foam::mpiIPstreamImpl::waitRequests()
{
    if (PstreamGlobals::IPstream_outstandingRequests_.size())
    {
        if
        (
            MPI_Waitall
            (
                PstreamGlobals::IPstream_outstandingRequests_.size(),
                PstreamGlobals::IPstream_outstandingRequests_.begin(),
                MPI_STATUSES_IGNORE
            )
        )
        {
            FatalErrorIn
            (
                "mpiIPstreamImpl::waitRequests()"
            )   << "MPI_Waitall returned with error" << endl;
        }

        PstreamGlobals::IPstream_outstandingRequests_.clear();
    }
}


bool Foam::mpiIPstreamImpl::finishedRequest(const label i)
{
    if (i >= PstreamGlobals::IPstream_outstandingRequests_.size())
    {
        FatalErrorIn
        (
            "mpiIPstreamImpl::finishedRequest(const label)"
        )   << "There are "
            << PstreamGlobals::IPstream_outstandingRequests_.size()
            << " outstanding send requests and you are asking for i=" << i
            << nl
            << "Maybe you are mixing blocking/non-blocking comms?"
            << Foam::abort(FatalError);
    }

    int flag;
    MPI_Test
    (
        &PstreamGlobals::IPstream_outstandingRequests_[i],
        &flag,
        MPI_STATUS_IGNORE
    );

    return flag != 0;
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// ************************ vim: set sw=4 sts=4 et: ************************ //
