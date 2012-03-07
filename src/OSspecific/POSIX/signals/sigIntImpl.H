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

Class
    Foam::sigIntImpl

Description
    Signal handler for INT interupt.

    The standard interupt handler is overridden to ensure that the
    runningJob file is removed.

    This is the platform specific opaque implementation for class sigInt.

See Also
    Foam::JobInfo

SourceFiles
    sigIntImpl.C

\*---------------------------------------------------------------------------*/

#ifndef sigIntImpl_H
#define sigIntImpl_H

#include <OpenFOAM/OSspecific.H>
#include <signal.h>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class sigIntImpl Declaration
\*---------------------------------------------------------------------------*/

class sigIntImpl
{
    // Private data

        //- Saved old signal trapping setting
        static struct sigaction oldAction_;


    // Private Member Functions

        static void sigIntHandler(int);


public:

    // Constructors

        sigIntImpl();


    // Destructor

        ~sigIntImpl();


    // Member functions

        void set(const bool verbose);
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
