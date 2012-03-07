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
    foamCalc

Description
    Generic wrapper for calculating a quantity at each time.

    Split into four phases:
        1. Intialise
        2. Pre-time calculation loop
        3. Calculation loop
        4. Post-calculation loop

Usage

    - foamCalc [OPTIONS] \<operation\> \<fields\>

    @param \<operation\> \n
    @todo Detailed description of argument.

    @param \<fields\> \n
    @todo Detailed description of argument.

    @param -noWrite \n
    Suppress output to files.

    @param -dictionary \<dictionary name\>\n
    Use specified dictionary.

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

#include <OpenFOAM/timeSelector.H>
#include <foamCalcFunctions/calcType.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    Foam::timeSelector::addOptions();
    Foam::argList::validOptions.insert("noWrite", "");
    Foam::argList::validOptions.insert("dict", "dictionary name");
    Foam::argList::validArgs.append("operation");
    Foam::argList::validArgs.append("field");

    if (argc < 2)
    {
        FatalError
            << "No utility has been supplied" << nl
            << exit(FatalError);
    }

    Foam::argList args(argc, argv, false);
    if (!args.checkRootCase())
    {
        Foam::FatalError.exit();
    }
#   include <OpenFOAM/createTime.H>
    Foam::instantList timeDirs = Foam::timeSelector::select0(runTime, args);
#   include <OpenFOAM/createMesh.H>

    word utilityName = args.additionalArgs()[0];

    Foam::autoPtr<Foam::calcType> utility
    (
        calcType::New(utilityName)
    );

    utility().tryInit();

    utility().tryPreCalc(args, runTime, mesh);

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);

        Foam::Info<< "Time = " << runTime.timeName() << Foam::endl;

        mesh.readUpdate();

        utility().tryCalc(args, runTime, mesh);

        Foam::Info<< Foam::endl;
    }

    utility().tryPostCalc(args, runTime, mesh);

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
