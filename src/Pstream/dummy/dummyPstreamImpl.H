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
    Foam::dummyPstreamImpl

Description
    Dummy implementation of the PstreamImpl abstract base class.

SourceFiles
    dummyPstreamImpl.C

\*----------------------------------------------------------------------------*/

#ifndef dummyPstreamImpl_H
#define dummyPstreamImpl_H

#include <OpenFOAM/PstreamImpl.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class dummyPstreamImpl Declaration
\*---------------------------------------------------------------------------*/

class dummyPstreamImpl
:
    public PstreamImpl
{
    // Private Member Functions

        //- Disallow default bitwise copy construct
        dummyPstreamImpl(const dummyPstreamImpl&);

        //- Disallow default bitwise assignment
        void operator=(const dummyPstreamImpl&);

public:

    // Declare name of the class and its debug switch
    TypeName("dummyPstreamImpl");

    // Constructors

        //- Construct null
        dummyPstreamImpl(){}

    // Member Functions

        //- Add the valid option this type of communications library
        //  adds/requires on the command line
        virtual void addValidParOptions(HashTable<string>& validParOptions);

        //- Initialisation function called from main
        //  Spawns slave processes and initialises inter-communication
        virtual bool init
        (
            int& argc,
            char**& argv,
            int& myProcNo_,
            List<int>& procIDs_,
            bool& isParallel
        );

        //- Exit program
        virtual void exit(int errnum);

        //- Abort program
        virtual void abort();

        //- Reduce implementation for scalars (@sa PstreamReduceOps.H)
        void reduce(scalar& Value, const sumOp<scalar>& bop);
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
