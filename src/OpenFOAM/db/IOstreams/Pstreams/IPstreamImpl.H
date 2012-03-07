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
    Foam::IPstreamImpl

Description
    Abstract base class for IPstream operations that depend on the parallel
    library used. Foam::IPstreamImpl::New will lookup the entry
    "PstreamImplementation" in the global controlDict file (i.e. the one
    found by Foam::dotFoam) and tries to first load a library named
    lib\<PstreamImplementation\>Pstream.so, and then instantiate the class
    \<PstreamImplementation\>IPstreamImpl.

SourceFiles
    IPstreamImpl.C


\*----------------------------------------------------------------------------*/

#ifndef IPstreamImpl_H
#define IPstreamImpl_H

#include <OpenFOAM/PstreamImpl.H>
#include <OpenFOAM/autoPtr.H>
#include <OpenFOAM/typeInfo.H>
#include <OpenFOAM/runTimeSelectionTables.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class IPstreamImpl Declaration
\*---------------------------------------------------------------------------*/

class IPstreamImpl
{
    // Private data

        //- The singleton instance
        static autoPtr<IPstreamImpl> instance_;

    // Private Member Functions

        //- Disallow default bitwise copy construct
        IPstreamImpl(const IPstreamImpl&);

        //- Disallow default bitwise assignment
        void operator=(const IPstreamImpl&);

public:

    // Declare name of the class and its debug switch
    TypeName("IPstreamImpl");

    // Declare run-time constructor selection table

        declareRunTimeSelectionTable
        (
            autoPtr,
            IPstreamImpl,
            dictionary,
            (),
            ()
        );

    // Constructors

        //- Construct null
        IPstreamImpl(){}

    // Destructor

        virtual ~IPstreamImpl() {}

    // Selectors

        //- Return a reference to the selected IPstreamImpl implementation
        static autoPtr<IPstreamImpl> New();

    // Member Functions

        //- Initialization
        virtual void init
        (
            const PstreamImpl::commsTypes commsType,
            const label bufSize,
            int& fromProcNo,
            label& messageSize,
            List<char>& buf
        ) = 0;

        //- Read into given buffer from given processor and return the
        //  message size
        virtual label read
        (
            const PstreamImpl::commsTypes commsType,
            const int fromProcNo,
            char* buf,
            const std::streamsize bufSize
        ) = 0;

        //- Non-blocking receives: wait until all have finished.
        virtual void waitRequests() = 0;

        //- Non-blocking receives: has request i finished?
        virtual bool finishedRequest(const label i) = 0;

};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
