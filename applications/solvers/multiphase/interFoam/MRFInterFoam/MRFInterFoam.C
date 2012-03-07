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
    MRFInterFoam

Description
    Solver for 2 incompressible, isothermal immiscible fluids.

    Using a VOF (volume of fluid) phase-fraction based interface capturing
    approach. The momentum and other fluid properties are of the "mixture" and
    a single momentum equation is solved.

    Turbulence modelling is generic, i.e. laminar, RAS or LES may be selected.

    For a two-fluid approach see twoPhaseEulerFoam.

\*---------------------------------------------------------------------------*/

#include <finiteVolume/fvCFD.H>
#include <finiteVolume/MULES.H>
#include <OpenFOAM/subCycle.H>
#include <interfaceProperties/interfaceProperties.H>
#include <incompressibleTransportModels/twoPhaseMixture.H>
#include <incompressibleTurbulenceModel/turbulenceModel.H>
#include <finiteVolume/MRFZones.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>
    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMesh.H>
    #include <finiteVolume/readPISOControls.H>
    #include <finiteVolume/initContinuityErrs.H>
    #include "../createFields.H"
    #include "createMRFZones.H"
    #include <finiteVolume/readTimeControls.H>
    #include "../correctPhi.H"
    #include <finiteVolume/CourantNo.H>
    #include <finiteVolume/setInitialDeltaT.H>

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.run())
    {
        #include <finiteVolume/readPISOControls.H>
        #include <finiteVolume/readTimeControls.H>
        #include <finiteVolume/CourantNo.H>
        #include "../alphaCourantNo.H"
        #include "../setDeltaT.H"

        runTime++;

        Info<< "Time = " << runTime.timeName() << nl << endl;

        twoPhaseProperties.correct();

        #include "../alphaEqnSubCycle.H"
        #include "zonePhaseVolumes.H"

        #include "UEqn.H"

        // --- PISO loop
        for (int corr=0; corr<nCorr; corr++)
        {
            #include "pEqn.H"
        }

        turbulence->correct();

        runTime.write();

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
