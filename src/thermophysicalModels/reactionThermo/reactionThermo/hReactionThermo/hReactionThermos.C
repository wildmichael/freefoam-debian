/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2009-2010 OpenCFD Ltd.
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

#include "makeReactionThermo.H"

#include "hReactionThermo.H"
#include <reactionThermophysicalModels/hRhoMixtureThermo.H>

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

makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    homogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    inhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    veryInhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    homogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    inhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    veryInhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);


makeReactionThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    dieselMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);


// Multi-component thermo

makeReactionMixtureThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    multiComponentMixture,
    icoPoly8ThermoPhysics
);

makeReactionMixtureThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    multiComponentMixture,
    gasThermoPhysics
);


// Multi-component reaction thermo

makeReactionMixtureThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    reactingMixture,
    icoPoly8ThermoPhysics
);

makeReactionMixtureThermo
(
    hReactionThermo,
    hRhoMixtureThermo,
    reactingMixture,
    gasThermoPhysics
);


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
