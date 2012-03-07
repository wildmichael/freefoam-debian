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
    pPrime2

Description
    Calculates and writes the scalar field of pPrime2 (sqr(p - pMean)) at
    each time

Usage

    - pPrime2 [OPTIONS]

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

#include <finiteVolume/fvCFD.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    timeSelector::addOptions();

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>

    instantList timeDirs = timeSelector::select0(runTime, args);

#   include <OpenFOAM/createMesh.H>

    runTime.setTime(timeDirs[timeDirs.size()-1], timeDirs.size()-1);

    volScalarField pMean
    (
        IOobject
        (
            "pMean",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        ),
        mesh
    );

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);

        Info<< "Time = " << runTime.timeName() << endl;

        IOobject pheader
        (
            "p",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        );

        // Check p exists
        if (pheader.headerOk())
        {
            mesh.readUpdate();

            Info<< "    Reading p" << endl;
            volScalarField p(pheader, mesh);

            Info<< "    Calculating pPrime2" << endl;
            volScalarField pPrime2
            (
                IOobject
                (
                    "pPrime2",
                    runTime.timeName(),
                    mesh,
                    IOobject::NO_READ
                ),
                sqr(p - pMean)
            );
            pPrime2.write();
        }
        else
        {
            Info<< "    No p" << endl;
        }

        Info<< endl;
    }

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
