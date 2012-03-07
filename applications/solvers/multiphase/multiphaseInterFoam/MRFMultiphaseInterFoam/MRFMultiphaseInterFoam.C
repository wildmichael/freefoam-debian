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
    MRFMultiphaseInterFoam

Description
    Solver for n incompressible fluids which captures the interfaces and
    includes surface-tension and contact-angle effects for each phase.

    Turbulence modelling is generic, i.e. laminar, RAS or LES may be selected.

Usage
    - MRFMultiphaseInterFoam. [OPTION]

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
#include <multiphaseMixture/multiphaseMixture.H>
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
    #include "../../multiphaseInterFoam/createFields.H"
    #include "../../interFoam/MRFInterFoam/createMRFZones.H"
    #include <finiteVolume/readTimeControls.H>
    #include "../../interFoam/correctPhi.H"
    #include <finiteVolume/CourantNo.H>
    #include <finiteVolume/setInitialDeltaT.H>

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.run())
    {
        #include <finiteVolume/readPISOControls.H>
        #include <finiteVolume/readTimeControls.H>
        #include <finiteVolume/CourantNo.H>
        #include "../../multiphaseInterFoam/alphaCourantNo.H"
        #include "../../interFoam/setDeltaT.H"

        runTime++;

        Info<< "Time = " << runTime.timeName() << nl << endl;

        mixture.solve();
        rho = mixture.rho();
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
