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
    surfacePointMerge

Description
    Merges points on surface if they are within absolute distance.

    Since absolute distance use with care!

Usage

    - surfacePointMerge [OPTIONS] \<Foam surface file\> \<(absolute) merge distance\> \<Foam output surface file\>

    @param \<Foam surface file\> \n
    @todo Detailed description of argument.

    @param \<(absolute) merge distance\> \n
    @todo Detailed description of argument.

    @param \<Foam output surface file\> \n
    @todo Detailed description of argument.

    @param -case \<dir\>\n
    Case directory.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <triSurface/triSurface.H>
#include <meshTools/triSurfaceTools.H>
#include <OpenFOAM/argList.H>
#include <OpenFOAM/OFstream.H>
#include <OpenFOAM/boundBox.H>

using namespace Foam;


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
    argList::noParallel();
    argList::validArgs.clear();
    argList::validArgs.append("surface file");
    argList::validArgs.append("merge distance");
    argList::validArgs.append("output file");
    argList args(argc, argv);

    fileName surfFileName(args.additionalArgs()[0]);
    scalar mergeTol(readScalar(IStringStream(args.additionalArgs()[1])()));
    fileName outFileName(args.additionalArgs()[2]);

    Info<< "Reading surface from " << surfFileName << " ..." << endl;
    Info<< "Merging points within " << mergeTol << " meter." << endl;

    triSurface surf1(surfFileName);

    Info<< "Original surface:" << endl;

    surf1.writeStats(Info);


    triSurface cleanSurf(surf1);

    while(true)
    {
        label nOldVert = cleanSurf.nPoints();

        cleanSurf = triSurfaceTools::mergePoints(cleanSurf, mergeTol);

        Info<< "After merging points:" << endl;

        cleanSurf.writeStats(Info);

        if (nOldVert == cleanSurf.nPoints())
        {
            break;
        }
    }

    cleanSurf.write(outFileName);

    Info << "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
