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

#include "makeHsCombustionThermo.H"

#include "hsCombustionThermo.H"
#include <reactionThermophysicalModels/hsPsiMixtureThermo.H>

#include <specie/perfectGas.H>

#include <specie/hConstThermo.H>
#include <specie/janafThermo.H>
#include <specie/specieThermo.H>

#include <specie/constTransport.H>
#include <specie/sutherlandTransport.H>

#include <reactionThermophysicalModels/dieselMixture.H>
#include <reactionThermophysicalModels/homogeneousMixture.H>
#include <reactionThermophysicalModels/inhomogeneousMixture.H>
#include <reactionThermophysicalModels/veryInhomogeneousMixture.H>

#include <reactionThermophysicalModels/reactingMixture.H>
#include <reactionThermophysicalModels/multiComponentMixture.H>

#include <specie/thermoPhysicsTypes.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    homogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    inhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    veryInhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    homogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    inhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    veryInhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeHsCombustionThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    dieselMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

// Multi-component thermo

makeHsCombustionMixtureThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    multiComponentMixture,
    gasThermoPhysics
);


// Multi-component reaction thermo

makeHsCombustionMixtureThermo
(
    hsCombustionThermo,
    hsPsiMixtureThermo,
    reactingMixture,
    gasThermoPhysics
);

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
