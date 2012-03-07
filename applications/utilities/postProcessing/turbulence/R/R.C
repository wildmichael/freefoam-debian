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
    R

Description
    Calculates and writes the Reynolds stress R for the current time step.

Usage

    - R [OPTIONS]

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
#include <incompressibleTransportModels/singlePhaseTransportModel.H>
#include <incompressibleRASModels/RASModel.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>

    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMesh.H>
    #include "createFields.H"

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nCalculating the Reynolds Stress R\n" << endl;

    volSymmTensorField R
    (
        IOobject
        (
            "R",
            runTime.timeName(),
            mesh,
            IOobject::NO_READ,
            IOobject::AUTO_WRITE
        ),
        RASModel->R()
    );

    R.write();

    Info<< "End" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
