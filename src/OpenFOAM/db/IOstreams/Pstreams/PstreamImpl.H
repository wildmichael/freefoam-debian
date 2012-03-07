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
    Foam::PstreamImpl

Description
    Abstract base class for Pstream operations that depend on the parallel
    library used. Foam::PstreamImpl::New will lookup the entry
    "PstreamImplementation" in the global controlDict file (i.e. the one
    found by Foam::dotFoam) and tries to first load a library named
    lib\<PstreamImplementation\>Pstream.so, and then instantiate the class
    \<PstreamImplementation\>PstreamImpl.

SourceFiles
    PstreamImplI.H
    PstreamImpl.C


\*----------------------------------------------------------------------------*/

#ifndef PstreamImpl_H
#define PstreamImpl_H

#include <OpenFOAM/autoPtr.H>
#include <OpenFOAM/typeInfo.H>
#include <OpenFOAM/runTimeSelectionTables.H>
#include <OpenFOAM/ops.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

namespace helper_
{
//- Helper class
struct PstreamBase
{
    //- Types of communications
    enum commsTypes
    {
        blocking,
        scheduled,
        nonBlocking
    };
};
} // namespace helper_

/*---------------------------------------------------------------------------*\
                           Class PstreamImpl Declaration
\*---------------------------------------------------------------------------*/

class PstreamImpl
: public helper_::PstreamBase
{
    // Private data

        //- The singleton instance
        static autoPtr<PstreamImpl> instance_;

    // Private Member Functions

        //- Disallow default bitwise copy construct
        PstreamImpl(const PstreamImpl&);

        //- Disallow default bitwise assignment
        void operator=(const PstreamImpl&);

protected:

    // Protected Member Functions

        //- Set data for parallel running
        static void setParRun(bool& isParallel);

        //- Initialize all communication schedules. Callback from
        //  PstreamImpl::init()
        static void initCommunicationSchedule();

public:

    //- Types of communications
    using helper_::PstreamBase::commsTypes;

    // Declare name of the class and its debug switch
    TypeName("PstreamImpl");

    // Declare run-time constructor selection table

        declareRunTimeSelectionTable
        (
            autoPtr,
            PstreamImpl,
            dictionary,
            (),
            ()
        );

    // Constructors

        //- Construct null
        PstreamImpl(){}

    // Destructor

        virtual ~PstreamImpl() {}

    // Selectors

        //- Return a reference to the selected PstreamImpl implementation
        static autoPtr<PstreamImpl> New();

    // Member Functions

        //- Add the valid option this type of communications library
        //  adds/requires on the command line
        virtual void addValidParOptions(HashTable<string>& validParOptions) = 0;

        //- Initialisation function called from main
        //  Spawns slave processes and initialises inter-communication
        virtual bool init(int& argc, char**& argv, int& myProcNo, List<int>& procIDs, bool& isParallel) = 0;

        //- Exit program
        virtual void exit(int errnum) = 0;

        //- Abort program
        virtual void abort() = 0;

        //- Reduce implementation for scalars (@sa PstreamReduceOps.H)
        virtual void reduce(scalar& Value, const sumOp<scalar>& bop) = 0;

        //- Loads the Pstream implementation library
        static void loadPstreamLibrary();

        //- Loads the given type from the Pstream implementation library
        template<class T, class CTable>
        static autoPtr<T> loadPstreamInstance
        (
            const word& dictEntry,
            const word& envName,
            CTable* ctable
        );


    // Friends

        friend class Pstream;

};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#include <OpenFOAM/PstreamImplI.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
