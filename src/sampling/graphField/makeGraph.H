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

Global
    makeGraph

Description
    Write a graph file for a field given the data point locations field,
    the field of interest and the name of the field to be used for the
    graph file name.

SourceFiles
    makeGraph.C

\*---------------------------------------------------------------------------*/

#ifndef makeGraph_H
#define makeGraph_H

#include <OpenFOAM/primitiveFieldsFwd.H>
#include <finiteVolume/volFieldsFwd.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

class fileName;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

//- Write a graph file
void makeGraph
(
    const scalarField& x,
    const volScalarField& vsf,
    const word& graphFormat
);


//- Write a graph file
void makeGraph
(
    const scalarField& x,
    const volScalarField& vsf,
    const word& name,
    const word& graphFormat
);


//- Write a graph file
void makeGraph
(
    const scalarField& x,
    const scalarField& sf,
    const word& name,
    const fileName& path,
    const word& graphFormat
);


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
