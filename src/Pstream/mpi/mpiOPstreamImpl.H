/*----------------------------------------------------------------------------*\
                ______                _     ____          __  __
               |  ____|             _| |_  / __ \   /\   |  \/  |
               | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
               |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
               | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
               |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|

                    FreeFOAM: The Cross-Platform CFD Toolkit

  Copyright (C) 2008-2012 Michael Wild <themiwi@users.sf.net>
                          Gerber van der Graaf <gerber_graaf@users.sf.net>
--------------------------------------------------------------------------------
License
    This file is part of FreeFOAM.

    FreeFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.

Class
    Foam::mpiOPstreamImpl

Description
    MPI implementation of the OPstreamImpl abstract base class.

SourceFiles
    mpiOPstreamImpl.C

\*----------------------------------------------------------------------------*/

#ifndef mpiOPstreamImpl_H
#define mpiOPstreamImpl_H

#include <OpenFOAM/OPstreamImpl.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class mpiOPstreamImpl Declaration
\*---------------------------------------------------------------------------*/

class mpiOPstreamImpl
:
    public OPstreamImpl
{
    // Private Member Functions

        //- Disallow default bitwise copy construct
        mpiOPstreamImpl(const mpiOPstreamImpl&);

        //- Disallow default bitwise assignment
        void operator=(const mpiOPstreamImpl&);

public:

    // Declare name of the class and its debug switch
    TypeName("mpiOPstreamImpl");

    // Constructors

        //- Construct null
        mpiOPstreamImpl(){}

    // Member Functions

        //- Flush the buffer (used in OPstream::~OPstream())
        virtual void flush
        (
            const PstreamImpl::commsTypes commsType,
            const int toProcNo,
            const char* buf,
            const int bufPosition
        );

        //- Write given buffer to given processor
        virtual bool write
        (
            const PstreamImpl::commsTypes commsType,
            const int toProcNo,
            const char* buf,
            const std::streamsize bufSize
        );

        //- Non-blocking writes: wait until all have finished.
        virtual void waitRequests();

        //- Non-blocking writes: has request i finished?
        virtual bool finishedRequest(const label i);

};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
