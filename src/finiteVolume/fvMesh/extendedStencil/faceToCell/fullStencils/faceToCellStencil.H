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

Class
    Foam::faceToCellStencil

Description
    baseclass for extended cell centred addressing. Contains per cell a
    list of neighbouring faces in global addressing.

SourceFiles
    faceToCellStencil.C

\*---------------------------------------------------------------------------*/

#ifndef faceToCellStencil_H
#define faceToCellStencil_H

#include <OpenFOAM/globalIndex.H>
#include <OpenFOAM/boolList.H>
#include <OpenFOAM/HashSet.H>
#include <OpenFOAM/indirectPrimitivePatch.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

class polyMesh;

/*---------------------------------------------------------------------------*\
                           Class faceToCellStencil Declaration
\*---------------------------------------------------------------------------*/

class faceToCellStencil
:
    public labelListList
{
    // Private data

        const polyMesh& mesh_;

        //- Global numbering for faces
        const globalIndex globalNumbering_;


    // Private Member Functions

        //- Disallow default bitwise copy construct
        faceToCellStencil(const faceToCellStencil&);

        //- Disallow default bitwise assignment
        void operator=(const faceToCellStencil&);

public:

    // Constructors

        //- Construct from mesh
        explicit faceToCellStencil(const polyMesh&);


    // Member Functions

        const polyMesh& mesh() const
        {
            return mesh_;
        }

        //- Global numbering for faces
        const globalIndex& globalNumbering() const
        {
            return globalNumbering_;
        }

        //- Work-around for C++ Standard Core Language Defect 391
        const faceToCellStencil& by_ref() const
        {
            return *this;
        }

};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
