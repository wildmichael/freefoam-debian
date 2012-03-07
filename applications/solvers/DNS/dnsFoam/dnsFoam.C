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
    dnsFoam

Description
    Direct numerical simulation solver for boxes of isotropic turbulence

Usage
    - dnsFoam [OPTION]

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
#include <randomProcesses/Kmesh.H>
#include <randomProcesses/UOprocess.H>
#include <randomProcesses/fft.H>
#include <randomProcesses/calcEk.H>
#include <OpenFOAM/graph.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>

    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMeshNoClear.H>
    #include "readTransportProperties.H"
    #include "createFields.H"
    #include "readTurbulenceProperties.H"
    #include <finiteVolume/initContinuityErrs.H>

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< nl << "Starting time loop" << endl;

    while (runTime.loop())
    {
        Info<< "Time = " << runTime.timeName() << nl << endl;

        #include <finiteVolume/readPISOControls.H>

        force.internalField() = ReImSum
        (
            fft::reverseTransform
            (
                K/(mag(K) + 1.0e-6) ^ forceGen.newField(), K.nn()
            )
        );

        #include "globalProperties.H"

        fvVectorMatrix UEqn
        (
            fvm::ddt(U)
          + fvm::div(phi, U)
          - fvm::laplacian(nu, U)
         ==
            force
        );

        solve(UEqn == -fvc::grad(p));


        // --- PISO loop

        for (int corr=1; corr<=1; corr++)
        {
            volScalarField rUA = 1.0/UEqn.A();

            U = rUA*UEqn.H();
            phi = (fvc::interpolate(U) & mesh.Sf())
                + fvc::ddtPhiCorr(rUA, U, phi);

            fvScalarMatrix pEqn
            (
                fvm::laplacian(rUA, p) == fvc::div(phi)
            );

            pEqn.solve();

            phi -= pEqn.flux();

            #include <finiteVolume/continuityErrs.H>

            U -= rUA*fvc::grad(p);
            U.correctBoundaryConditions();
        }

        runTime.write();

        if (runTime.outputTime())
        {
            calcEk(U, K).write(runTime.timePath()/"Ek", runTime.graphFormat());
        }

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
