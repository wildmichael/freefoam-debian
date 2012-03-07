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
    Foam::clockTimeImpl

Description
    Starts timing (using rtc) and returns elapsed time from start.
    Better resolution (2uSec instead of ~20mSec) than cpuTime.

    This is the platform specific opaque implementation for class clockTime.

SourceFiles
    clockTimeImpl.C

\*---------------------------------------------------------------------------*/

#ifndef clockTimeImpl_H
#define clockTimeImpl_H

#include <sys/types.h>
#ifdef darwin
#include <sys/time.h>
#endif

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class clockTime Declaration
\*---------------------------------------------------------------------------*/

class clockTimeImpl
{
    // Private data

        struct timeval startTime_;
        mutable struct timeval lastTime_;
        mutable struct timeval newTime_;

        static void getTime(struct timeval& t);

        static double timeDifference
        (
            const struct timeval& start,
            const struct timeval& end
        );


public:

    // Constructors

        //- Construct from components
        clockTimeImpl();


    // Member Functions

        // Access

            //- Returns CPU time from start of run
            double elapsedTime() const;

            //- Returns CPU time from last call of clockTimeIncrement()
            double timeIncrement() const;
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
