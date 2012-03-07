/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 1991-2009 OpenCFD Ltd.
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
    buoyantPimpleFoam

Description
    Transient solver for buoyant, turbulent flow of compressible fluids for
    ventilation and heat-transfer.

    Turbulence is modelled using a run-time selectable compressible RAS or
    LES model.

Usage
    - buoyantPisoFoam [OPTION]

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
#include <basicThermophysicalModels/basicRhoThermo.H>
#include <compressibleTurbulenceModel/turbulenceModel.H>
#include <finiteVolume/fixedGradientFvPatchFields.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>
    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMesh.H>
    #include <finiteVolume/readGravitationalAcceleration.H>
    #include "createFields.H"
    #include <finiteVolume/initContinuityErrs.H>
    #include <finiteVolume/readTimeControls.H>
    #include <finiteVolume/compressibleCourantNo.H>
    #include <finiteVolume/setInitialDeltaT.H>

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.run())
    {
        #include <finiteVolume/readTimeControls.H>
        #include <finiteVolume/readPIMPLEControls.H>
        #include <finiteVolume/compressibleCourantNo.H>
        #include <finiteVolume/setDeltaT.H>

        runTime++;

        Info<< "Time = " << runTime.timeName() << nl << endl;

        #include <finiteVolume/rhoEqn.H>

        // --- Pressure-velocity PIMPLE corrector loop
        for (int oCorr=0; oCorr<nOuterCorr; oCorr++)
        {
            bool finalIter = oCorr == nOuterCorr-1;

            if (nOuterCorr != 1)
            {
                p_rgh.storePrevIter();
            }

            #include "UEqn.H"
            #include "hEqn.H"

            // --- PISO loop
            for (int corr=0; corr<nCorr; corr++)
            {
                #include "pEqn.H"
            }

            turbulence->correct();

            rho = thermo.rho();
        }

        runTime.write();

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
