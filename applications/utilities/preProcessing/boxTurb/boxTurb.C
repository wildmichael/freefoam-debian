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
    boxTurb

Description
    Makes a box of turbulence which conforms to a given energy
    spectrum and is divergence free.

Usage

    - boxTurb [OPTIONS]

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
#include <OpenFOAM/graph.H>
#include <OpenFOAM/OFstream.H>
#include <randomProcesses/Kmesh.H>
#include <randomProcesses/turbGen.H>
#include <randomProcesses/calcEk.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    argList::noParallel();
#   include <OpenFOAM/setRootCase.H>

#   include <OpenFOAM/createTime.H>
#   include <OpenFOAM/createMesh.H>
#   include "createFields.H"
#   include "readBoxTurbDict.H"


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Kmesh K(mesh);

    turbGen Ugen(K, Ea, k0);

    U.internalField() = Ugen.U();
    U.correctBoundaryConditions();

    Info<< "k("
         << runTime.timeName()
         << ") = "
         << 3.0/2.0*average(magSqr(U)).value() << endl;

    U.write();

    calcEk(U, K).write(runTime.timePath()/"Ek", runTime.graphFormat());

    Info<< "end" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
