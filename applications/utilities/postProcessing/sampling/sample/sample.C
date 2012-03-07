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
    sample

Description
    Sample field data with a choice of interpolation schemes, sampling options
    and write formats.

    Keywords:

    @param setFormat : set output format, choice of \n
      - @c xmgr
      - @c jplot
      - @c gnuplot
      - @c raw

    @param surfaceFormat : surface output format, choice of \n
      - @c null        : suppress output
      - @c foamFile    : separate points, faces and values file
      - @c dx          : DX scalar or vector format
      - @c vtk         : VTK ascii format
      - @c raw         : x y z value format for use with e.g. gnuplot 'splot'.
      - @c obj         : Wavefron stl. Does not contain values!
      - @c stl         : ascii stl. Does not contain values!

    @param interpolationScheme : interpolation scheme, choice of \n
      - @c cell          : use cell-centre value; constant over cells (default)
      - @c cellPoint     : use cell-centre and vertex values
      - @c cellPointFace : use cell-centre, vertex and face values. \n
        -# vertex values determined from neighbouring cell-centre values
        -# face values determined using the current face interpolation scheme
           for the field (linear, limitedLinear, etc.)

    @param fields : list of fields to sample

    @param sets : list of sets to sample, choice of \n
      - @c uniform           : evenly distributed points on line
      - @c face              : one point per face intersection
      - @c midPoint          : one point per cell, inbetween two face intersections
      - @c midPointAndFace   : combination of face and midPoint
      - @c curve             : specified points, not nessecary on line, uses
                               tracking
      - @c cloud             : specified points, uses findCell
      .
      Option axis: how to write point coordinate. Choice of
      - @c x/y/z: x/y/z coordinate only
      - @c xyz: three columns
        (probably does not make sense for anything but raw)
      - @c distance: distance from start of sampling line (if uses line)
        or distance from first specified sampling point
      .
      Type specific options:
      - @c uniform, face, midPoint, midPointAndFace : start and end coordinate
      - @c uniform: extra number of sampling points
      - @c curve, @c cloud: list of coordinates

    @param surfaces : list of surfaces to sample, choice of \n
      - @c plane : values on plane defined by point, normal.
      - @c patch : values on patch.

Usage

    - sample [OPTION]

    @param -noZero \n
    Do not sample the @em 0 directory.

    @param -case \<dir\> \n
    Path to the case directory. Defaults to the
    current working directory.

    @param -parallel \n
    Run in parallel.

    @param -latestTime \n
    Only sample the latest time directory.

    @param -time \<time\> \n
    Only sample the @em time directory.

    @param -constant \n
    Include the constant directory.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

Notes
    Runs in parallel

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/argList.H>
#include <OpenFOAM/timeSelector.H>
#include <sampling/IOsampledSets.H>
#include <sampling/IOsampledSurfaces.H>

using namespace Foam;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
    timeSelector::addOptions();
    #include <OpenFOAM/addRegionOption.H>
    argList::validOptions.insert("dict", "dictionary name");

    #include <OpenFOAM/setRootCase.H>
    #include <OpenFOAM/createTime.H>
    instantList timeDirs = timeSelector::select0(runTime, args);
    #include <OpenFOAM/createNamedMesh.H>

    word sampleDict = "sampleDict";
    if (args.optionFound("dict"))
    {
        sampleDict = args.option("dict");
        Info<< "Reading sample dictionary: " << sampleDict << nl << endl;
    }

    IOsampledSets sSets
    (
        sampledSets::typeName,
        mesh,
        sampleDict,
        IOobject::MUST_READ,
        true
    );

    IOsampledSurfaces sSurfs
    (
        sampledSurfaces::typeName,
        mesh,
        sampleDict,
        IOobject::MUST_READ,
        true
    );

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);
        Info<< "Time = " << runTime.timeName() << endl;

        // Handle geometry/topology changes
        polyMesh::readUpdateState state = mesh.readUpdate();

        sSets.readUpdate(state);
        sSurfs.readUpdate(state);

        sSets.write();
        sSurfs.write();

        Info<< endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
