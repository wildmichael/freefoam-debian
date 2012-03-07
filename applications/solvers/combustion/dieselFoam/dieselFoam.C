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
    dieselFoam

Description
    Solver for diesel spray and combustion.

Usage
    - dieselFoam [OPTION]

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
#include <reactionThermophysicalModels/hCombustionThermo.H>
#include <compressibleTurbulenceModel/turbulenceModel.H>
#include <dieselSpray/spray.H>
#include <chemistryModel/psiChemistryModel.H>
#include <chemistryModel/chemistrySolver.H>

#include <finiteVolume/multivariateScheme.H>
#include <OpenFOAM/IFstream.H>
#include <OpenFOAM/OFstream.H>
#include <OpenFOAM/Switch.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>
    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMesh.H>
    #include "../dieselEngineFoam/createFields.H"
    #include <finiteVolume/readGravitationalAcceleration.H>
    #include "../dieselEngineFoam/readCombustionProperties.H"
    #include "../dieselEngineFoam/createSpray.H"
    #include <finiteVolume/initContinuityErrs.H>
    #include <finiteVolume/readTimeControls.H>
    #include <finiteVolume/compressibleCourantNo.H>
    #include <finiteVolume/setInitialDeltaT.H>

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.run())
    {
        #include <finiteVolume/readPISOControls.H>
        #include <finiteVolume/compressibleCourantNo.H>
        #include <finiteVolume/setDeltaT.H>

        runTime++;
        Info<< "Time = " << runTime.timeName() << nl << endl;

        Info<< "Evolving Spray" << endl;

        dieselSpray.evolve();

        Info<< "Solving chemistry" << endl;

        chemistry.solve
        (
            runTime.value() - runTime.deltaT().value(),
            runTime.deltaT().value()
        );

        // turbulent time scale
        {
            volScalarField tk =
                Cmix*sqrt(turbulence->muEff()/rho/turbulence->epsilon());
            volScalarField tc = chemistry.tc();

            // Chalmers PaSR model
            kappa = (runTime.deltaT() + tc)/(runTime.deltaT()+tc+tk);
        }

        chemistrySh = kappa*chemistry.Sh()();

        #include "../dieselEngineFoam/rhoEqn.H"
        #include "../dieselEngineFoam/UEqn.H"

        for (label ocorr=1; ocorr <= nOuterCorr; ocorr++)
        {
            #include "../dieselEngineFoam/YEqn.H"
            #include "../dieselEngineFoam/hsEqn.H"

            // --- PISO loop
            for (int corr=1; corr<=nCorr; corr++)
            {
                #include "pEqn.H"
            }
        }

        turbulence->correct();

        #include "../dieselEngineFoam/spraySummary.H"

        rho = thermo.rho();

        if (runTime.write())
        {
            chemistry.dQ()().write();
        }

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
