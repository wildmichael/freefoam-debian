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
    coldEngineFoam

Description
    Solver for cold-flow in internal combustion engines.

Usage
    - coldEngineFoam [OPTION]

    @param -case \<dir\> \n
    Specify the case directory

    @param -parallel \n
    Run the case in parallel

    @param -help \n
    Display short usage message

    @param -doc \n
    Display Doxygen documentation page

    @param -srcDoc \n
    Display source code

\*---------------------------------------------------------------------------*/

#include <finiteVolume/fvCFD.H>
#include <engine/engineTime.H>
#include <engine/engineMesh.H>
#include <basicThermophysicalModels/basicPsiThermo.H>
#include <compressibleTurbulenceModel/turbulenceModel.H>
#include <OpenFOAM/OFstream.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>

    #include <engine/createEngineTime.H>
    #include <engine/createEngineMesh.H>
    #include "createFields.H"
    #include <finiteVolume/initContinuityErrs.H>
    #include "../engineFoam/readEngineTimeControls.H"
    #include <finiteVolume/compressibleCourantNo.H>
    #include <finiteVolume/setInitialDeltaT.H>
    #include "startSummary.H"

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.run())
    {
        #include <finiteVolume/readPISOControls.H>
        #include "../engineFoam/readEngineTimeControls.H"
        #include <finiteVolume/compressibleCourantNo.H>
        #include <finiteVolume/setDeltaT.H>

        runTime++;

        Info<< "Crank angle = " << runTime.theta() << " CA-deg"
            << endl;

        mesh.move();

        #include <finiteVolume/rhoEqn.H>

        #include "../engineFoam/UEqn.H"

        // --- PISO loop
        for (int corr=1; corr<=nCorr; corr++)
        {
            #include "hEqn.H"
            #include "../engineFoam/pEqn.H"
        }

        turbulence->correct();

        runTime.write();

        #include "logSummary.H"

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
