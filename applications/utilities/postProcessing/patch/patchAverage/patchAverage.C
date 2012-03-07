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
    patchAverage

Description
    Calculates the average of the specified field over the specified patch.

Usage

    - patchAverage [OPTIONS] \<fieldName\> \<patchName\>

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

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
    timeSelector::addOptions();
    argList::validArgs.append("fieldName");
    argList::validArgs.append("patchName");
#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>
    instantList timeDirs = timeSelector::select0(runTime, args);
#   include <OpenFOAM/createMesh.H>

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

            if (fieldHeader.headerClassName() == "volScalarField")
            {
                Info<< "    Reading volScalarField " << fieldName << endl;
                volScalarField field(fieldHeader, mesh);

                scalar area = gSum(mesh.magSf().boundaryField()[patchi]);
                scalar sumField = 0;

                if (area > 0)
                {
                    sumField = gSum
                    (
                        mesh.magSf().boundaryField()[patchi]
                      * field.boundaryField()[patchi]
                    ) / area;
                }

                Info<< "    Average of " << fieldName << " over patch "
                    << patchName << '[' << patchi << ']' << " = "
                    << sumField << endl;
            }
            else
            {
                FatalError
                    << "Only possible to average volScalarFields "
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
