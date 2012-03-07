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

#include "hhuCombustionThermo.H"
#include <reactionThermophysicalModels/hhuMixtureThermo.H>

#include <reactionThermophysicalModels/makeCombustionThermo.H>
#include <OpenFOAM/addToRunTimeSelectionTable.H>

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
#include <reactionThermophysicalModels/egrMixture.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * * h-hu-Thermos * * * * * * * * * * * * * * * //

makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    homogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    inhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    veryInhomogeneousMixture,
    constTransport,
    hConstThermo,
    perfectGas
);

makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    homogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    inhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);

makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    veryInhomogeneousMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);


makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    egrMixture,
    constTransport,
    hConstThermo,
    perfectGas
);



makeCombustionThermo
(
    hhuCombustionThermo,
    hhuMixtureThermo,
    egrMixture,
    sutherlandTransport,
    janafThermo,
    perfectGas
);


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
