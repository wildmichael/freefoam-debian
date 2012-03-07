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
    postChannel

Description
    Post-processes data from channel flow calculations

    For each time: calculate: txx, txy,tyy, txy,
    eps, prod, vorticity, enstrophy and helicity. Assuming that the mesh
    is periodic in the x and z directions, collapse Umeanx, Umeany, txx,
    txy and tyy to a line and print them as standard output.

Usage

    - postChannel [OPTIONS]

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

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <finiteVolume/fvCFD.H>
#include "channelIndex.H"
#include <sampling/makeGraph.H>

#include <OpenFOAM/OSspecific.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
//  Main program:

int main(int argc, char *argv[])
{
    argList::noParallel();
    timeSelector::addOptions();

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>

    // Get times list
    instantList timeDirs = timeSelector::select0(runTime, args);

#   include <OpenFOAM/createMesh.H>
#   include "readTransportProperties.H"

    const word& gFormat = runTime.graphFormat();

    // Setup channel indexing for averaging over channel down to a line

    IOdictionary channelDict
    (
        IOobject
        (
            "postChannelDict",
            mesh.time().constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE
        )
    );
    channelIndex channelIndexing(mesh, channelDict);


    // For each time step read all fields
    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);
        Info<< "Collapsing fields for time " << runTime.timeName() << endl;

#       include "readFields.H"
#       include "calculateFields.H"

        // Average fields over channel down to a line
#       include "collapse.H"
    }

    Info<< "\nEnd" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
