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
    mergeMeshes

Description
    Merge two meshes.

Usage

    - mergeMeshes [OPTIONS] \<master root\> \<master case name\> \<root to add\> \<case to add\>

    @param \<master root\> \n
    @todo Detailed description of argument.

    @param \<master case name\> \n
    @todo Detailed description of argument.

    @param \<root to add\> \n
    @todo Detailed description of argument.

    @param \<case to add\> \n
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
#include "mergePolyMesh.H"

using namespace Foam;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
    argList::noParallel();
#   include "setRoots.H"
#   include "createTimes.H"

    Info<< "Reading master mesh for time = " << runTimeMaster.timeName() << endl;

    Info<< "Create mesh\n" << endl;
    mergePolyMesh masterMesh
    (
        IOobject
        (
            masterRegion,
            runTimeMaster.timeName(),
            runTimeMaster
        )
    );


    Info<< "Reading mesh to add for time = " << runTimeToAdd.timeName() << endl;

    Info<< "Create mesh\n" << endl;
    polyMesh meshToAdd
    (
        IOobject
        (
            addRegion,
            runTimeToAdd.timeName(),
            runTimeToAdd
        )
    );

    runTimeMaster++;

    Info<< "Writing combined mesh to " << runTimeMaster.timeName() << endl;

    masterMesh.addMesh(meshToAdd);
    masterMesh.merge();
    masterMesh.polyMesh::write();

    Info << nl << "End" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
