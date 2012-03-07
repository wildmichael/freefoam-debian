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
    writeCellCentres

Description
    Write the three components of the cell centres as volScalarFields so
    they can be used in postprocessing in thresholding.

Usage

    - writeCellCentres [OPTIONS]

    @param -noZero \n
    Ignore timestep 0.

    @param -constant \n
    Include the constant directory.

    @param -time \<time\>\n
    Apply only to specific time.

    @param -latestTime \n
    Only apply to latest time step.

    @param -case \<dir\>\n
    Case directory.

    @param -parallel \n
    Run in parallel.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/argList.H>
#include <OpenFOAM/timeSelector.H>
#include <OpenFOAM/Time.H>
#include <finiteVolume/fvMesh.H>
#include <OpenFOAM/vectorIOField.H>
#include <finiteVolume/volFields.H>

using namespace Foam;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Main program:

int main(int argc, char *argv[])
{
    timeSelector::addOptions();

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>

    instantList timeDirs = timeSelector::select0(runTime, args);

#   include <OpenFOAM/createMesh.H>

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);

        Info<< "Time = " << runTime.timeName() << endl;

        // Check for new mesh
        mesh.readUpdate();

        volVectorField cc
        (
            IOobject
            (
                "cellCentres",
                runTime.timeName(),
                mesh,
                IOobject::NO_READ,
                IOobject::AUTO_WRITE
            ),
            mesh.C()
        );

        // Info<< "Writing cellCentre positions to " << cc.name() << " in "
        //     << runTime.timeName() << endl;
        //
        // cc.write();

        Info<< "Writing components of cellCentre positions to volScalarFields"
            << " ccx, ccy, ccz in " <<  runTime.timeName() << endl;

        for (direction i=0; i<vector::nComponents; i++)
        {
            volScalarField cci
            (
                IOobject
                (
                    "cc" + word(vector::componentNames[i]),
                    runTime.timeName(),
                    mesh,
                    IOobject::NO_READ,
                    IOobject::AUTO_WRITE
                ),
                mesh.C().component(i)
            );

            cci.write();
        }
    }

    Info<< "\nEnd" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
