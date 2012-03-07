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
    Foam::OPstreamImpl

Description
    Abstract base class for OPstream operations that depend on the parallel
    library used. Foam::OPstreamImpl::New will lookup the entry
    "PstreamImplementation" in the global controlDict file (i.e. the one
    found by Foam::dotFoam) and tries to first load a library named
    lib\<PstreamImplementation\>Pstream.so, and then instantiate the class
    \<PstreamImplementation\>OPstreamImpl.

SourceFiles
    OPstreamImpl.C


\*----------------------------------------------------------------------------*/

#ifndef OPstreamImpl_H
#define OPstreamImpl_H

#include <OpenFOAM/PstreamImpl.H>
#include <OpenFOAM/autoPtr.H>
#include <OpenFOAM/typeInfo.H>
#include <OpenFOAM/runTimeSelectionTables.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class OPstreamImpl Declaration
\*---------------------------------------------------------------------------*/

class OPstreamImpl
{
    // Private data

        //- The singleton instance
        static autoPtr<OPstreamImpl> instance_;

    // Private Member Functions

        //- Disallow default bitwise copy construct
        OPstreamImpl(const OPstreamImpl&);

        //- Disallow default bitwise assignment
        void operator=(const OPstreamImpl&);

public:

    // Declare name of the class and its debug switch
    TypeName("OPstreamImpl");

    // Declare run-time constructor selection table

        declareRunTimeSelectionTable
        (
            autoPtr,
            OPstreamImpl,
            dictionary,
            (),
            ()
        );

    // Constructors

        //- Construct null
        OPstreamImpl(){}

    // Selectors

        //- Return a reference to the selected OPstreamImpl implementation
        static autoPtr<OPstreamImpl> New();

    // Member Functions

        //- Write given buffer to given processor
        virtual bool write
        (
            const PstreamImpl::commsTypes commsType,
            const int toProcNo,
            const char* buf,
            const std::streamsize bufSize
        ) = 0;

        //- Non-blocking writes: wait until all have finished.
        virtual void waitRequests() = 0;

        //- Non-blocking writes: has request i finished?
        virtual bool finishedRequest(const label i) = 0;

        //- Flush the buffer (used in OPstream::~OPstream())
        virtual void flush
        (
            const PstreamImpl::commsTypes commsType,
            const int toProcNo,
            const char* buf,
            const int bufPosition
        ) = 0;


};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
