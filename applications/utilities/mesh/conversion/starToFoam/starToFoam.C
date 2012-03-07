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
    starToFoam

Description
    Converts a STAR-CD PROSTAR mesh into FOAM format.

Usage

    - starToFoam [OPTIONS] \<STAR mesh file prefix\>

    @param \<STAR mesh file prefix\> \n
    @todo Detailed description of argument.

    @param -scale \<number\>\n
    Scale factor.

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
#include "starMesh.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
//  Main program:

int main(int argc, char *argv[])
{
    argList::noParallel();
    argList::validArgs.append("STAR mesh file prefix");
    argList::validOptions.insert("scale", "scale factor");

    argList args(argc, argv);

    if (!args.check())
    {
        FatalError.exit();
    }

    scalar scaleFactor = 1.0;
    args.optionReadIfPresent("scale", scaleFactor);

#   include <OpenFOAM/createTime.H>

    fileName starMeshFile(args.additionalArgs()[0]);
    starMesh makeMesh(starMeshFile, runTime, scaleFactor);

    // Set the precision of the points data to 10
    IOstream::defaultPrecision(10);

    Info << "Writing mesh" << endl;
    makeMesh.writeMesh();

    Info<< nl << "End" << nl << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
