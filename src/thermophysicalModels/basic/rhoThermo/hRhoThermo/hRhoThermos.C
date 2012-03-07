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

#include <basicThermophysicalModels/makeBasicRhoThermo.H>

#include <specie/perfectGas.H>
#include <specie/incompressible.H>

#include <specie/hConstThermo.H>
#include <specie/janafThermo.H>
#include <specie/specieThermo.H>

#include <specie/constTransport.H>
#include <specie/sutherlandTransport.H>

#include <specie/icoPolynomial.H>
#include <specie/hPolynomialThermo.H>
#include <specie/polynomialTransport.H>

#include "hRhoThermo.H"
#include <basicThermophysicalModels/pureMixture.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/* * * * * * * * * * * * * * * private static data * * * * * * * * * * * * * */

makeBasicRhoThermo
(
    hRhoThermo,
    pureMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeBasicRhoThermo
(
    hRhoThermo,
    pureMixture,
    sutherlandTransport,
    hConstThermo,
    perfectGas
);

makeBasicRhoThermo
(
    hRhoThermo,
    pureMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeBasicRhoThermo
(
    hRhoThermo,
    pureMixture,
    constTransport,
    hConstThermo,
    incompressible
);

makeBasicRhoPolyThermo
(
    hRhoThermo,
    pureMixture,
    3
);

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
