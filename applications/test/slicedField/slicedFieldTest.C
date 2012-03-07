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
    slicedFieldTest

Description

\*---------------------------------------------------------------------------*/

#include <finiteVolume/fvCFD.H>
#include <OpenFOAM/SlicedGeometricField.H>
#include <finiteVolume/slicedFvPatchFields.H>
#include <finiteVolume/slicedSurfaceFields.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include <OpenFOAM/setRootCase.H>

    #include <OpenFOAM/createTime.H>
    #include <OpenFOAM/createMesh.H>

    Info<< "Reading field p\n" << endl;
    volScalarField p
    (
        IOobject
        (
            "p",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ,
            IOobject::AUTO_WRITE
        ),
        mesh
    );

    //Info<< min(p, p);

    Info<< "Reading field U\n" << endl;
    volVectorField U
    (
        IOobject
        (
            "U",
            runTime.timeName(),
            mesh,
            IOobject::MUST_READ,
            IOobject::AUTO_WRITE
        ),
        mesh
    );

    SlicedGeometricField<vector, fvPatchField, slicedFvPatchField, volMesh>
    C
    (
        IOobject
        (
            "C2",
            runTime.timeName(),
            mesh
        ),
        mesh,
        dimLength,
        mesh.cellCentres(),
        mesh.faceCentres()
    );

    Info<< C << endl;
    Info<< (C & U) << endl;

    SlicedGeometricField<vector, fvsPatchField, slicedFvsPatchField, surfaceMesh>
    Sf
    (
        IOobject
        (
            "Sf2",
            runTime.timeName(),
            mesh
        ),
        mesh,
        dimArea,
        mesh.faceAreas()
    );

    //Info<< Sf << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
