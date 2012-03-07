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
    checkMesh

Description
    Checks validity of a mesh

Usage

    - checkMesh [OPTIONS]

    @param -noTopology \n
    Do not check mesh-topology.

    @param -allTopology \n
    More extensive topology checks.

    @param -allGeometry \n
    More extensive geometry checks.

    @param -region \<name\>\n
    Only apply to named mesh region.

    @param -latestTime \n
    Only apply to latest time step.

    @param -time \<time\>\n
    Apply only to specific time.

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

#include <OpenFOAM/argList.H>
#include <OpenFOAM/timeSelector.H>
#include <OpenFOAM/Time.H>

#include <OpenFOAM/polyMesh.H>
#include <OpenFOAM/globalMeshData.H>

#include "printMeshStats.H"
#include "checkTopology.H"
#include "checkGeometry.H"

using namespace Foam;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    timeSelector::addOptions();
#   include <OpenFOAM/addRegionOption.H>
    argList::validOptions.insert("noTopology", "");
    argList::validOptions.insert("allGeometry", "");
    argList::validOptions.insert("allTopology", "");

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>
    instantList timeDirs = timeSelector::select0(runTime, args);
#   include <OpenFOAM/createNamedPolyMesh.H>

    const bool noTopology  = args.optionFound("noTopology");
    const bool allGeometry = args.optionFound("allGeometry");
    const bool allTopology = args.optionFound("allTopology");

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);

        polyMesh::readUpdateState state = mesh.readUpdate();

        if
        (
            !timeI
         || state == polyMesh::TOPO_CHANGE
         || state == polyMesh::TOPO_PATCH_CHANGE
        )
        {
            Info<< "Time = " << runTime.timeName() << nl << endl;

            // Clear mesh before checking
            mesh.clearOut();

            // Reconstruct globalMeshData
            mesh.globalData();

            printMeshStats(mesh, allTopology);

            label noFailedChecks = 0;

            if (!noTopology)
            {
                noFailedChecks += checkTopology(mesh, allTopology, allGeometry);
            }

            noFailedChecks += checkGeometry(mesh, allGeometry);

            // Note: no reduction in noFailedChecks necessary since is
            //       counter of checks, not counter of failed cells,faces etc.

            if (noFailedChecks == 0)
            {
                Info<< "\nMesh OK.\n" << endl;
            }
            else
            {
                Info<< "\nFailed " << noFailedChecks << " mesh checks.\n"
                    << endl;
            }
        }
        else if (state == polyMesh::POINTS_MOVED)
        {
            Info<< "Time = " << runTime.timeName() << nl << endl;

            label nFailedChecks = checkGeometry(mesh, allGeometry);

            if (nFailedChecks)
            {
                Info<< "\nFailed " << nFailedChecks << " mesh checks.\n"
                    << endl;
            }
            else
            {
                Info << "\nMesh OK.\n" << endl;
            }
        }
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
