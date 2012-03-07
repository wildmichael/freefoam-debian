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

defineTemplateTypeNameAndDebug(gasReaction, 0);
defineTemplateRunTimeSelectionTable(gasReaction, Istream);


// * * * * * * * * * * * * * Make CHEMKIN reactions  * * * * * * * * * * * * //

makeIRNReactions(gasThermoPhysics, ArrheniusReactionRate)
makeIRNReactions(gasThermoPhysics, LandauTellerReactionRate)
makeIRNReactions(gasThermoPhysics, thirdBodyArrheniusReactionRate)
makeIRReactions(gasThermoPhysics, JanevReactionRate)
makeIRReactions(gasThermoPhysics, powerSeriesReactionRate)

makePressureDependentReactions
(
    gasThermoPhysics,
    ArrheniusReactionRate,
    LindemannFallOffFunction
)

makePressureDependentReactions
(
    gasThermoPhysics,
    ArrheniusReactionRate,
    TroeFallOffFunction
)

makePressureDependentReactions
(
    gasThermoPhysics,
    ArrheniusReactionRate,
    SRIFallOffFunction
)


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
