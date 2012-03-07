/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2009-2010 OpenCFD Ltd.
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
    Starts timing CPU usage and return elapsed time from start.

\*---------------------------------------------------------------------------*/

#include <OSspecific/cpuTime.H>
#include "cpuTimeImpl.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

cpuTime::cpuTime()
    : impl_( new cpuTimeImpl() )
{
}

// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

cpuTime::~cpuTime()
{
    delete impl_;
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

double cpuTime::elapsedCpuTime() const
{
    return impl_->elapsedCpuTime();
}


double cpuTime::cpuTimeIncrement() const
{
    return impl_->cpuTimeIncrement();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
