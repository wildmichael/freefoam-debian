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

\*---------------------------------------------------------------------------*/

#include "wallDist.H"
#include <meshTools/patchWave.H>
#include <finiteVolume/fvMesh.H>
#include <OpenFOAM/wallPolyPatch.H>
#include <finiteVolume/fvPatchField.H>
#include <OpenFOAM/Field.H>
#include <finiteVolume/emptyFvPatchFields.H>

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::wallDist::wallDist(const fvMesh& mesh, const bool correctWalls)
:
    volScalarField
    (
        IOobject
        (
            "y",
            mesh.time().timeName(),
            mesh
        ),
        mesh,
        dimensionedScalar("y", dimLength, GREAT)
    ),
    cellDistFuncs(mesh),
    correctWalls_(correctWalls),
    nUnset_(0)
{
    wallDist::correct();
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::wallDist::~wallDist()
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

// Correct for mesh geom/topo changes. Might be more intelligent in the
// future (if only small topology change)
void Foam::wallDist::correct()
{
    // Get patchids of walls
    labelHashSet wallPatchIDs(getPatchIDs<wallPolyPatch>());

    // Calculate distance starting from wallPatch faces.
    patchWave wave(cellDistFuncs::mesh(), wallPatchIDs, correctWalls_);

    // Transfer cell values from wave into *this 
    transfer(wave.distance());

    // Transfer values on patches into boundaryField of *this
    forAll(boundaryField(), patchI)
    {
        if (!isA<emptyFvPatchScalarField>(boundaryField()[patchI]))
        {
            scalarField& waveFld = wave.patchDistance()[patchI];

            boundaryField()[patchI].transfer(waveFld);
        }
    }

    // Transfer number of unset values
    nUnset_ = wave.nUnset();
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
