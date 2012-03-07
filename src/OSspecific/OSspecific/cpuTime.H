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
    Foam::cpuTime

Description
    Starts timing CPU usage and return elapsed time from start.

SeeAlso
    clockTime

SourceFiles
    cpuTime.C

\*---------------------------------------------------------------------------*/

#ifndef cpuTime_H
#define cpuTime_H

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class cpuTime Declaration
\*---------------------------------------------------------------------------*/

//- Forward declaration of the OS specific implementation
class cpuTimeImpl;


class cpuTime
{
    // Private data

        //- The actual implementation (opaque pointer): PIMPL
        cpuTimeImpl* impl_;

public:

    // Constructors

        //- Construct from components
        cpuTime();

    // Destructor

        ~cpuTime();


    // Member Functions

        // Access

            //- Returns CPU time from start of run
            double elapsedCpuTime() const;

            //- Returns CPU time from last call of cpuTimeIncrement()
            double cpuTimeIncrement() const;
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
