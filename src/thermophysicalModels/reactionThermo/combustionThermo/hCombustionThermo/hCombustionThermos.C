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

#include "makeCombustionThermo.H"

#include "hCombustionThermo.H"
#include <reactionThermophysicalModels/hPsiMixtureThermo.H>

#include <specie/perfectGas.H>

#include <specie/hConstThermo.H>
#include <specie/janafThermo.H>
#include <specie/specieThermo.H>

#include <specie/constTransport.H>
#include <specie/sutherlandTransport.H>

#include <reactionThermophysicalModels/homogeneousMixture.H>
#include <reactionThermophysicalModels/inhomogeneousMixture.H>
#include <reactionThermophysicalModels/veryInhomogeneousMixture.H>
#include <reactionThermophysicalModels/dieselMixture.H>
#include <reactionThermophysicalModels/multiComponentMixture.H>
#include <reactionThermophysicalModels/reactingMixture.H>

#include <specie/thermoPhysicsTypes.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    homogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    inhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    veryInhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    homogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    inhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    veryInhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeCombustionThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    dieselMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

// Multi-component thermo

makeCombustionMixtureThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    multiComponentMixture,
    gasThermoPhysics
);


// Multi-component reaction thermo

makeCombustionMixtureThermo
(
    hCombustionThermo,
    hPsiMixtureThermo,
    reactingMixture,
    gasThermoPhysics
);


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
