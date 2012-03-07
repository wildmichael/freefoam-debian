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
    patchIntegrate

Description
    Calculates the integral of the specified field over the specified patch.

Usage

    - patchIntegrate [OPTIONS] \<fieldName\> \<patchName\>

    @param \<fieldName\> \n
    @todo Detailed description of argument.

    @param \<patchName\> \n
    @todo Detailed description of argument.

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
#include <OpenFOAM/cyclicPolyPatch.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
#   include <OpenFOAM/addRegionOption.H>
    timeSelector::addOptions();
    argList::validArgs.append("fieldName");
    argList::validArgs.append("patchName");
#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>
    instantList timeDirs = timeSelector::select0(runTime, args);
#   include <OpenFOAM/createNamedMesh.H>

    word fieldName(args.additionalArgs()[0]);
    word patchName(args.additionalArgs()[1]);

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);
        Info<< "Time = " << runTime.timeName() << endl;

        IOobject fieldHeader
        (
            fieldName,
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ
        );

        // Check field exists
        if (fieldHeader.headerOk())
        {
            mesh.readUpdate();

            label patchi = mesh.boundaryMesh().findPatchID(patchName);
            if (patchi < 0)
            {
                FatalError
                    << "Unable to find patch " << patchName << nl
                    << exit(FatalError);
            }

            // Give patch area
            if (isA<cyclicPolyPatch>(mesh.boundaryMesh()[patchi]))
            {
                Info<< "    Cyclic patch vector area: " << nl;
                label nFaces = mesh.boundaryMesh()[patchi].size();
                vector sum1 = vector::zero;
                vector sum2 = vector::zero;
                for (label i=0; i<nFaces/2; i++)
                {
                    sum1 += mesh.Sf().boundaryField()[patchi][i];
                    sum2 += mesh.Sf().boundaryField()[patchi][i+nFaces/2];
                }
                reduce(sum1, sumOp<vector>());
                reduce(sum2, sumOp<vector>());
                Info<< "    - half 1 = " << sum1 << ", " << mag(sum1) << nl
                    << "    - half 2 = " << sum2 << ", " << mag(sum2) << nl
                    << "    - total  = " << (sum1 + sum2) << ", "
                    << mag(sum1 + sum2) << endl;
                Info<< "    Cyclic patch area magnitude = "
                    << gSum(mesh.magSf().boundaryField()[patchi])/2.0 << endl;
            }
            else
            {
                Info<< "    Area vector of patch "
                    << patchName << '[' << patchi << ']' << " = "
                    << gSum(mesh.Sf().boundaryField()[patchi]) << endl;
                Info<< "    Area magnitude of patch "
                    << patchName << '[' << patchi << ']' << " = "
                    << gSum(mesh.magSf().boundaryField()[patchi]) << endl;
            }

            // Read field and calc integral
            if (fieldHeader.headerClassName() == volScalarField::typeName)
            {
                Info<< "    Reading " << volScalarField::typeName << " "
                    << fieldName << endl;

                volScalarField field(fieldHeader, mesh);

                Info<< "    Integral of " << fieldName
                    << " over vector area of patch "
                    << patchName << '[' << patchi << ']' << " = "
                    << gSum
                       (
                           mesh.Sf().boundaryField()[patchi]
                          *field.boundaryField()[patchi]
                       )
                    << nl;

                Info<< "    Integral of " << fieldName
                    << " over area magnitude of patch "
                    << patchName << '[' << patchi << ']' << " = "
                    << gSum
                       (
                           mesh.magSf().boundaryField()[patchi]
                          *field.boundaryField()[patchi]
                       )
                    << nl;
            }
            else if
            (
                fieldHeader.headerClassName() == surfaceScalarField::typeName
            )
            {
                Info<< "    Reading " << surfaceScalarField::typeName << " "
                    << fieldName << endl;

                surfaceScalarField field(fieldHeader, mesh);
                scalar sumField = gSum(field.boundaryField()[patchi]);

                Info<< "    Integral of " << fieldName << " over patch "
                    << patchName << '[' << patchi << ']' << " = "
                    << sumField << nl;
            }
            else
            {
                FatalError
                    << "Only possible to integrate "
                    << volScalarField::typeName << "s "
                    << "and " << surfaceScalarField::typeName << "s"
                    << nl << exit(FatalError);
            }
        }
        else
        {
            Info<< "    No field " << fieldName << endl;
        }

        Info<< endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
