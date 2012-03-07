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
    chtMultiRegionFoam

Description
    Combination of heatConductionFoam and buoyantFoam for conjugate heat
    transfer between a solid region and fluid region

Usage
    - chtMultiRegionFoam [OPTION]

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
#include <compressibleRASModels/regionProperties.H>
#include "fluid/compressibleCourantNo.H"
#include "solid/solidRegionDiffNo.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>
    #include <OpenFOAM/createTime.H>

    regionProperties rp(runTime);

    #include "fluid/createFluidMeshes.H"
    #include "solid/createSolidMeshes.H"

    #include "fluid/createFluidFields.H"
    #include "solid/createSolidFields.H"

    #include "fluid/initContinuityErrs.H"

    #include <finiteVolume/readTimeControls.H>
    #include "solid/readSolidTimeControls.H"


    #include "fluid/compressibleMultiRegionCourantNo.H"
    #include "solid/solidRegionDiffusionNo.H"
    #include "include/setInitialMultiRegionDeltaT.H"


    while (runTime.run())
    {
        #include <finiteVolume/readTimeControls.H>
        #include "solid/readSolidTimeControls.H"
        #include "readPIMPLEControls.H"


        #include "fluid/compressibleMultiRegionCourantNo.H"
        #include "solid/solidRegionDiffusionNo.H"
        #include "include/setMultiRegionDeltaT.H"

        runTime++;

        Info<< "Time = " << runTime.timeName() << nl << endl;

        if (nOuterCorr != 1)
        {
            forAll(fluidRegions, i)
            {
                #include "fluid/setRegionFluidFields.H"
                #include "fluid/storeOldFluidFields.H"
            }
        }


        // --- PIMPLE loop
        for (int oCorr=0; oCorr<nOuterCorr; oCorr++)
        {
            forAll(fluidRegions, i)
            {
                Info<< "\nSolving for fluid region "
                    << fluidRegions[i].name() << endl;
                #include "fluid/setRegionFluidFields.H"
                #include "fluid/readFluidMultiRegionPIMPLEControls.H"
                #include "fluid/solveFluid.H"
            }

            forAll(solidRegions, i)
            {
                Info<< "\nSolving for solid region "
                    << solidRegions[i].name() << endl;
                #include "solid/setRegionSolidFields.H"
                #include "solid/readSolidMultiRegionPIMPLEControls.H"
                #include "solid/solveSolid.H"
            }
        }

        runTime.write();

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info << "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
