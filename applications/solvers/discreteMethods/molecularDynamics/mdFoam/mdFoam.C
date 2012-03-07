/*---------------------------------------------------------------------------*\
 =========                   |
 \\      /   F ield          | OpenFOAM: The Open Source CFD Toolbox
  \\    /    O peration      |
   \\  /     A nd            | Copyright (C) 2008-2010 OpenCFD Ltd.
    \\/      M anipulation   |
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
    mdFoam

Description
    Molecular dynamics solver for fluid dynamics

Usage
    - mdFoam [OPTION]

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
#include <molecule/md.H>

int main(int argc, char *argv[])
{

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>
#   include <OpenFOAM/createMesh.H>

    potential pot(mesh);

    moleculeCloud molecules(mesh, pot);

#   include <molecule/temperatureAndPressureVariables.H>

    label nAveragingSteps = 0;

    Info << "\nStarting time loop\n" << endl;

    while (runTime.loop())
    {

        nAveragingSteps++;

        Info << "Time = " << runTime.timeName() << endl;

        molecules.evolve();

#       include <molecule/meanMomentumEnergyAndNMols.H>

#       include <molecule/temperatureAndPressure.H>

        runTime.write();

        if (runTime.outputTime())
        {
            nAveragingSteps = 0;
        }

        Info << "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info << "End\n" << endl;

    return 0;
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
