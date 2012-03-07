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
    sonicLiquidFoam

Description
    Transient solver for trans-sonic/supersonic, laminar flow of a
    compressible liquid.

Usage
    - sonicLiquidFoam [OPTION]

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

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>
    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMesh.H>
    #include "readThermodynamicProperties.H"
    #include "readTransportProperties.H"
    #include "createFields.H"
    #include <finiteVolume/initContinuityErrs.H>

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.loop())
    {
        Info<< "Time = " << runTime.timeName() << nl << endl;

        #include <finiteVolume/readPISOControls.H>
        #include <finiteVolume/compressibleCourantNo.H>

        #include <finiteVolume/rhoEqn.H>

        fvVectorMatrix UEqn
        (
            fvm::ddt(rho, U)
          + fvm::div(phi, U)
          - fvm::laplacian(mu, U)
        );

        solve(UEqn == -fvc::grad(p));


        // --- PISO loop

        for (int corr=0; corr<nCorr; corr++)
        {
            volScalarField rUA = 1.0/UEqn.A();
            U = rUA*UEqn.H();

            surfaceScalarField phid
            (
                "phid",
                psi
               *(
                    (fvc::interpolate(U) & mesh.Sf())
                  + fvc::ddtPhiCorr(rUA, rho, U, phi)
                )
            );

            phi = (rhoO/psi)*phid;

            fvScalarMatrix pEqn
            (
                fvm::ddt(psi, p)
              + fvc::div(phi)
              + fvm::div(phid, p)
              - fvm::laplacian(rho*rUA, p)
            );

            pEqn.solve();

            phi += pEqn.flux();

            #include "compressibleContinuityErrs.H"

            U -= rUA*fvc::grad(p);
            U.correctBoundaryConditions();
        }

        rho = rhoO + psi*p;

        runTime.write();

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
