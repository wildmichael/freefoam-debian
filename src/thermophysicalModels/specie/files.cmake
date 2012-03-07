#-------------------------------------------------------------------------------
#               ______                _     ____          __  __
#              |  ____|             _| |_  / __ \   /\   |  \/  |
#              | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
#              |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
#              | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
#              |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|
#
#                   FreeFOAM: The Cross-Platform CFD Toolkit
#
# Copyright (C) 2008-2012 Michael Wild <themiwi@users.sf.net>
#                         Gerber van der Graaf <gerber_graaf@users.sf.net>
#-------------------------------------------------------------------------------
# License
#   This file is part of FreeFOAM.
#
#   FreeFOAM is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#   for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------

set(SRCS
  atomicWeights/atomicWeights.C
  specie/specie.C
  speciesTable/speciesTable.C
  equationOfState/perfectGas/perfectGas.C
  equationOfState/incompressible/incompressible.C
  reaction/reactions/makeChemkinReactions.C
  reaction/reactions/makeReactionThermoReactions.C
  reaction/reactions/makeLangmuirHinshelwoodReactions.C
  )

set(HDRS
  atomicWeights/atomicWeights.H
  equationOfState/icoPolynomial/icoPolynomial.C
  equationOfState/icoPolynomial/icoPolynomial.H
  equationOfState/icoPolynomial/icoPolynomialI.H
  equationOfState/perfectGas/perfectGas.H
  equationOfState/perfectGas/perfectGasI.H
  equationOfState/incompressible/incompressible.H
  equationOfState/incompressible/incompressibleI.H
  include/reactionTypes.H
  include/thermoPhysicsTypes.H
  reaction/Reactions_/IrreversibleReaction/IrreversibleReaction.C
  reaction/Reactions_/IrreversibleReaction/IrreversibleReaction.H
  reaction/Reactions_/NonEquilibriumReversibleReaction/NonEquilibriumReversibleReaction.C
  reaction/Reactions_/NonEquilibriumReversibleReaction/NonEquilibriumReversibleReaction.H
  reaction/Reactions_/Reaction/Reaction.C
  reaction/Reactions_/Reaction/Reaction.H
  reaction/Reactions_/Reaction/ReactionI.H
  reaction/Reactions_/ReversibleReaction/ReversibleReaction.C
  reaction/Reactions_/ReversibleReaction/ReversibleReaction.H
  reaction/reactionRate/ArrheniusReactionRate/ArrheniusReactionRate.H
  reaction/reactionRate/ArrheniusReactionRate/ArrheniusReactionRateI.H
  reaction/reactionRate/ChemicallyActivatedReactionRate/ChemicallyActivatedReactionRate.H
  reaction/reactionRate/ChemicallyActivatedReactionRate/ChemicallyActivatedReactionRateI.H
  reaction/reactionRate/FallOffReactionRate/FallOffReactionRate.H
  reaction/reactionRate/FallOffReactionRate/FallOffReactionRateI.H
  reaction/reactionRate/JanevReactionRate/JanevReactionRate.H
  reaction/reactionRate/JanevReactionRate/JanevReactionRateI.H
  reaction/reactionRate/LandauTellerReactionRate/LandauTellerReactionRate.H
  reaction/reactionRate/LandauTellerReactionRate/LandauTellerReactionRateI.H
  reaction/reactionRate/LangmuirHinshelwood/LangmuirHinshelwoodReactionRate.H
  reaction/reactionRate/LangmuirHinshelwood/LangmuirHinshelwoodReactionRateI.H
  reaction/reactionRate/fallOffFunctions/LindemannFallOffFunction/LindemannFallOffFunction.H
  reaction/reactionRate/fallOffFunctions/LindemannFallOffFunction/LindemannFallOffFunctionI.H
  reaction/reactionRate/fallOffFunctions/SRIFallOffFunction/SRIFallOffFunction.H
  reaction/reactionRate/fallOffFunctions/SRIFallOffFunction/SRIFallOffFunctionI.H
  reaction/reactionRate/fallOffFunctions/TroeFallOffFunction/TroeFallOffFunction.H
  reaction/reactionRate/fallOffFunctions/TroeFallOffFunction/TroeFallOffFunctionI.H
  reaction/reactionRate/powerSeries/powerSeriesReactionRate.H
  reaction/reactionRate/powerSeries/powerSeriesReactionRateI.H
  reaction/reactionRate/thirdBodyArrheniusReactionRate/thirdBodyArrheniusReactionRate.H
  reaction/reactionRate/thirdBodyArrheniusReactionRate/thirdBodyArrheniusReactionRateI.H
  reaction/reactionRate/thirdBodyEfficiencies/thirdBodyEfficiencies.H
  reaction/reactionRate/thirdBodyEfficiencies/thirdBodyEfficienciesI.H
  reaction/reactions/makeReactionThermo.H
  specie/specie.H
  specie/specieI.H
  speciesTable/speciesTable.H
  speciesTable/speciesTableI.H
  thermo/eConst/eConstThermo.C
  thermo/eConst/eConstThermo.H
  thermo/eConst/eConstThermoI.H
  thermo/hConst/hConstThermo.C
  thermo/hConst/hConstThermo.H
  thermo/hConst/hConstThermoI.H
  thermo/hPolynomial/hPolynomialThermo.C
  thermo/hPolynomial/hPolynomialThermo.H
  thermo/hPolynomial/hPolynomialThermoI.H
  thermo/janaf/janafThermo.C
  thermo/janaf/janafThermo.H
  thermo/janaf/janafThermoI.H
  thermo/specieThermo/specieThermo.C
  thermo/specieThermo/specieThermo.H
  thermo/specieThermo/specieThermoI.H
  transport/const/constTransport.C
  transport/const/constTransport.H
  transport/const/constTransportI.H
  transport/polynomial/polynomialTransport.C
  transport/polynomial/polynomialTransport.H
  transport/polynomial/polynomialTransportI.H
  transport/speciesTransport/speciesTransport.C
  transport/speciesTransport/speciesTransport.H
  transport/speciesTransport/speciesTransportI.H
  transport/sutherland/sutherlandTransport.C
  transport/sutherland/sutherlandTransport.H
  transport/sutherland/sutherlandTransportI.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
