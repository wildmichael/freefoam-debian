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
    kivaToFoam

Description
    Converts a KIVA3v grid to FOAM format

Usage

    - kivaToFoam [OPTIONS]

    @param -zHeadMin \<scalar\>\n
    Minimum cylinder-head height.

    @param -file \<kiva file\>\n
    Use a different kiva file from otape17.

    @param -version \<kiva version\>\n
    Specify kiva version.

    @param -case \<dir\>\n
    Case directory.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/argList.H>
#include <OpenFOAM/Time.H>
#include <OpenFOAM/polyMesh.H>
#include <OpenFOAM/IFstream.H>
#include <OpenFOAM/OFstream.H>
#include <OpenFOAM/cellShape.H>
#include <OpenFOAM/cellModeller.H>
#include <OpenFOAM/preservePatchTypes.H>
#include <OpenFOAM/emptyPolyPatch.H>
#include <OpenFOAM/wallPolyPatch.H>
#include <OpenFOAM/symmetryPolyPatch.H>
#include <OpenFOAM/wedgePolyPatch.H>
#include <OpenFOAM/cyclicPolyPatch.H>
#include <OpenFOAM/mathematicalConstants.H>

using namespace Foam;

// Supported KIVA versions
enum kivaVersions
{
    kiva3,
    kiva3v
};

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
    argList::noParallel();
    argList::validOptions.insert("file", "fileName");
    argList::validOptions.insert("version", "[kiva3|kiva3v]");
    argList::validOptions.insert("zHeadMin", "scalar");

#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>

    fileName kivaFileName("otape17");
    if (args.optionFound("file"))
    {
        kivaFileName = args.option("file");
    }

    kivaVersions kivaVersion = kiva3v;
    if (args.optionFound("version"))
    {
        word kivaVersionName = args.option("version");

        if (kivaVersionName == "kiva3")
        {
            kivaVersion = kiva3;
        }
        else if (kivaVersionName == "kiva3v")
        {
            kivaVersion = kiva3v;
        }
        else
        {
            FatalErrorIn("main(int argc, char *argv[])")
                << "KIVA file version " << kivaVersionName << " not supported"
                << exit(FatalError);

            args.printUsage();

            FatalError.exit(1);
        }
    }

    scalar zHeadMin = -GREAT;
    args.optionReadIfPresent("zHeadMin", zHeadMin);

#   include "readKivaGrid.H"

    Info << "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
