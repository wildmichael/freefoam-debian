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

Description

\*---------------------------------------------------------------------------*/

#include <specie/reactionTypes.H>
#include "makeReactionThermo.H"

#include <specie/ArrheniusReactionRate.H>
#include <specie/thirdBodyArrheniusReactionRate.H>
#include <specie/FallOffReactionRate.H>
#include <specie/ChemicallyActivatedReactionRate.H>
#include <specie/LindemannFallOffFunction.H>
#include <specie/TroeFallOffFunction.H>
#include <specie/SRIFallOffFunction.H>
#include <specie/LandauTellerReactionRate.H>
#include <specie/JanevReactionRate.H>
#include <specie/powerSeriesReactionRate.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

defineTemplateTypeNameAndDebug(icoPoly8Reaction, 0);
defineTemplateRunTimeSelectionTable(icoPoly8Reaction, Istream);


// * * * * * * * * * * * * * Make CHEMKIN reactions  * * * * * * * * * * * * //

makeIRNReactions(icoPoly8ThermoPhysics, ArrheniusReactionRate)
makeIRNReactions(icoPoly8ThermoPhysics, LandauTellerReactionRate)
makeIRNReactions(icoPoly8ThermoPhysics, thirdBodyArrheniusReactionRate)
makeIRReactions(icoPoly8ThermoPhysics, JanevReactionRate)
makeIRReactions(icoPoly8ThermoPhysics, powerSeriesReactionRate)

makePressureDependentReactions
(
    icoPoly8ThermoPhysics,
    ArrheniusReactionRate,
    LindemannFallOffFunction
)

makePressureDependentReactions
(
    icoPoly8ThermoPhysics,
    ArrheniusReactionRate,
    TroeFallOffFunction
)

makePressureDependentReactions
(
    icoPoly8ThermoPhysics,
    ArrheniusReactionRate,
    SRIFallOffFunction
)


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
