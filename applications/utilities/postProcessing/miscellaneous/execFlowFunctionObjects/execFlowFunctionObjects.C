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

Global
    execFlowFunctionObjects

Application
    execFlowFunctionObjects

Description
    Execute the set of functionObjects specified in the selected dictionary
    (which defaults to system/controlDict) for the selected set of times.

    The flow (p-U) and optionally turbulence fields are available for the
    function objects to operate on allowing forces and other related properties
    to be calculated in addition to cutting planes etc.

Usage

    - execFlowFunctionObjects [OPTIONS]

    @param -noWrite \n
    Suppress output to files.

    @param -dict \<dictionary name\>\n
    Use named dictionary instead of system/controlDict.

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

#include <postCalc/calc.H>

#include <incompressibleTransportModels/singlePhaseTransportModel.H>

#include <incompressibleRASModels/RASModel.H>
#include <incompressibleLESModels/LESModel.H>

#include <basicThermophysicalModels/basicPsiThermo.H>
#include <compressibleRASModels/RASModel.H>
#include <compressibleLESModels/LESModel.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
    void execFlowFunctionObjects(const argList& args, const Time& runTime)
    {
        if (args.optionFound("dict"))
        {
            IOdictionary dict
            (
                IOobject
                (
                    args.option("dict"),
                    runTime.system(),
                    runTime,
                    IOobject::MUST_READ
                )
            );

            functionObjectList fol(runTime, dict);
            fol.start();
            fol.execute();
        }
        else
        {
            functionObjectList fol(runTime);
            fol.start();
            fol.execute();
        }
    }
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

void Foam::calc(const argList& args, const Time& runTime, const fvMesh& mesh)
{
    Info<< "    Reading phi" << endl;
    surfaceScalarField phi
    (
        IOobject
        (
            "phi",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        ),
        mesh
    );

    Info<< "    Reading U" << endl;
    volVectorField U
    (
        IOobject
        (
            "U",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        ),
        mesh
    );

    Info<< "    Reading p" << endl;
    volScalarField p
    (
        IOobject
        (
            "p",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        ),
        mesh
    );

    if (phi.dimensions() == dimensionSet(0, 3, -1, 0, 0))
    {
        IOobject RASPropertiesHeader
        (
            "RASProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE,
            false
        );

        IOobject LESPropertiesHeader
        (
            "LESProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE,
            false
        );

        singlePhaseTransportModel laminarTransport(U, phi);

        if (RASPropertiesHeader.headerOk())
        {
            IOdictionary RASProperties(RASPropertiesHeader);

            autoPtr<incompressible::RASModel> RASModel
            (
                incompressible::RASModel::New
                (
                    U,
                    phi,
                    laminarTransport
                )
            );
            execFlowFunctionObjects(args, runTime);
        }
        else if (LESPropertiesHeader.headerOk())
        {
            IOdictionary LESProperties(LESPropertiesHeader);

            autoPtr<incompressible::LESModel> sgsModel
            (
                incompressible::LESModel::New(U, phi, laminarTransport)
            );

            execFlowFunctionObjects(args, runTime);
        }
        else
        {
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

            dimensionedScalar nu(transportProperties.lookup("nu"));

            execFlowFunctionObjects(args, runTime);
        }
    }
    else if (phi.dimensions() == dimensionSet(1, 0, -1, 0, 0))
    {
        autoPtr<basicPsiThermo> thermo(basicPsiThermo::New(mesh));

        volScalarField rho
        (
            IOobject
            (
                "rho",
                runTime.timeName(),
                mesh
            ),
            thermo->rho()
        );

        IOobject RASPropertiesHeader
        (
            "RASProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE,
            false
        );

        IOobject LESPropertiesHeader
        (
            "LESProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE,
            false
        );

        if (RASPropertiesHeader.headerOk())
        {
            IOdictionary RASProperties(RASPropertiesHeader);

            autoPtr<compressible::RASModel> RASModel
            (
                compressible::RASModel::New
                (
                    rho,
                    U,
                    phi,
                    thermo()
                )
            );

            execFlowFunctionObjects(args, runTime);
        }
        else if (LESPropertiesHeader.headerOk())
        {
            IOdictionary LESProperties(LESPropertiesHeader);

            autoPtr<compressible::LESModel> sgsModel
            (
                compressible::LESModel::New(rho, U, phi, thermo())
            );

            execFlowFunctionObjects(args, runTime);
        }
        else
        {
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

            dimensionedScalar mu(transportProperties.lookup("mu"));

            execFlowFunctionObjects(args, runTime);
        }
    }
    else
    {
        FatalErrorIn(args.executable())
            << "Incorrect dimensions of phi: " << phi.dimensions()
            << nl << exit(FatalError);
    }
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
