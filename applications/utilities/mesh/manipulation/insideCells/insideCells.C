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

Application
    insideCells

Description
    Picks up cells with cell centre 'inside' of surface.

    Requires surface to be closed and singly connected.

Usage

    - insideCells [OPTIONS] \<Foam surface file\> \<cellSet name\>

    @param \<Foam surface file\> \n
    @todo Detailed description of argument.

    @param \<cellSet name\> \n
    @todo Detailed description of argument.

    @param -case \<dir\>\n
    Case directory.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/argList.H>
#include <OpenFOAM/Time.H>
#include <OpenFOAM/polyMesh.H>
#include <triSurface/triSurface.H>
#include <meshTools/triSurfaceSearch.H>
#include <meshTools/cellSet.H>

using namespace Foam;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Main program:

int main(int argc, char *argv[])
{
    Foam::argList::noParallel();
    Foam::argList::validArgs.append("surface file");
    Foam::argList::validArgs.append("destination cellSet");

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>
#   include <OpenFOAM/createPolyMesh.H>

    fileName surfName(args.additionalArgs()[0]);

    fileName setName(args.additionalArgs()[1]);


    // Read surface
    Info<< "Reading surface from " << surfName << endl;
    triSurface surf(surfName);

    // Destination cellSet.
    cellSet insideCells(mesh, setName, IOobject::NO_READ);


    // Construct search engine on surface
    triSurfaceSearch querySurf(surf);

    boolList inside(querySurf.calcInside(mesh.cellCentres()));

    forAll(inside, cellI)
    {
        if (inside[cellI])
        {
            insideCells.insert(cellI);
        }
    }


    Info<< "Selected " << insideCells.size()
        << " cells out of " << mesh.nCells() << endl
        << endl
        << "Writing selected cells to cellSet " << insideCells.name()
        << endl << endl
        << "Use this cellSet e.g. with subsetMesh : " << endl << endl
        << "    subsetMesh <root> <case> " << insideCells.name()
        << endl << endl;

    insideCells.write();

    Info << "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
