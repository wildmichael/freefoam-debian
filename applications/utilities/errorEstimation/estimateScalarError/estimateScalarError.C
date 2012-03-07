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
    estimateScalarError

Description
    Estimates the error in the solution for a scalar transport equation in the
    standard form

Usage

    - estimateScalarError [OPTIONS]

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
#include <errorEstimation/errorEstimate.H>
#include <errorEstimation/resError.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    timeSelector::addOptions();

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>

    instantList timeDirs = timeSelector::select0(runTime, args);

#   include <OpenFOAM/createMesh.H>

    Info<< "\nEstimating error in scalar transport equation\n"
        << "Reading transportProperties\n" << endl;

    IOdictionary transportProperties
    (
        IOobject
        (
            "transportProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE
        )
    );


    Info<< "Reading diffusivity DT\n" << endl;

    dimensionedScalar DT
    (
        transportProperties.lookup("DT")
    );


    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);

        Info<< "Time = " << runTime.timeName() << endl;

        mesh.readUpdate();

        IOobject THeader
        (
            "T",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        );

        IOobject Uheader
        (
            "U",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        );

        if (THeader.headerOk() && Uheader.headerOk())
        {
            Info << "Reading T" << endl;
            volScalarField T(THeader, mesh);

            Info << "Reading U" << endl;
            volVectorField U(Uheader, mesh);

#           include <finiteVolume/createPhi.H>

            errorEstimate<scalar> ee
            (
                resError::div(phi, T)
              - resError::laplacian(DT, T)
            );

            ee.residual()().write();
            volScalarField e = ee.error();
            e.write();
            mag(e)().write();
        }
        else
        {
            Info<< "    No T or U" << endl;
        }

        Info<< endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
