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
    simpleSRFFoam

Description
    Steady-state solver for incompressible, turbulent flow of non-Newtonian
    fluids with single rotating frame.

\*---------------------------------------------------------------------------*/

#include <finiteVolume/fvCFD.H>
#include <incompressibleTransportModels/singlePhaseTransportModel.H>
#include <incompressibleRASModels/RASModel.H>
#include <finiteVolume/SRFModel.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{

#   include <OpenFOAM/setRootCase.H>

#   include <OpenFOAM/createTime.H>
#   include <OpenFOAM/createMesh.H>
#   include "createFields.H"
#   include <finiteVolume/initContinuityErrs.H>

    //mesh.clearPrimitives();

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    for (runTime++; !runTime.end(); runTime++)
    {
        Info<< "Time = " << runTime.timeName() << nl << endl;

#       include <finiteVolume/readSIMPLEControls.H>

        p.storePrevIter();

        // Pressure-velocity SIMPLE corrector
        {
            // Momentum predictor
            tmp<fvVectorMatrix> UrelEqn
            (
                fvm::div(phi, Urel)
              + turbulence->divDevReff(Urel)
              + SRF->Su()
            );

            UrelEqn().relax();

            solve(UrelEqn() == -fvc::grad(p));

            p.boundaryField().updateCoeffs();
            volScalarField AUrel = UrelEqn().A();
            Urel = UrelEqn().H()/AUrel;
            UrelEqn.clear();
            phi = fvc::interpolate(Urel) & mesh.Sf();
            adjustPhi(phi, Urel, p);

            // Non-orthogonal pressure corrector loop
            for (int nonOrth=0; nonOrth<=nNonOrthCorr; nonOrth++)
            {
                fvScalarMatrix pEqn
                (
                    fvm::laplacian(1.0/AUrel, p) == fvc::div(phi)
                );

                pEqn.setReference(pRefCell, pRefValue);
                pEqn.solve();

                if (nonOrth == nNonOrthCorr)
                {
                    phi -= pEqn.flux();
                }
            }

#           include <finiteVolume/continuityErrs.H>

            // Explicitly relax pressure for momentum corrector
            p.relax();

            // Momentum corrector
            Urel -= fvc::grad(p)/AUrel;
            Urel.correctBoundaryConditions();
        }

        turbulence->correct();


        if (runTime.outputTime())
        {
            volVectorField Uabs
            (
                IOobject
                (
                    "Uabs",
                    runTime.timeName(),
                    mesh,
                    IOobject::NO_READ,
                    IOobject::AUTO_WRITE
                ),
                Urel + SRF->U()
            );

            runTime.write();
        }

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return(0);
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
