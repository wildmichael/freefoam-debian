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
  chemistryReaders/chemkinReader/chemkinReader.C
  chemistryReaders/chemkinReader/chemkinLexer.L
  chemistryReaders/chemistryReader/makeChemistryReaders.C
  mixtures/basicMultiComponentMixture/basicMultiComponentMixture.C
  combustionThermo/hCombustionThermo/hCombustionThermo.C
  combustionThermo/hCombustionThermo/newhCombustionThermo.C
  combustionThermo/hCombustionThermo/hCombustionThermos.C
  combustionThermo/hsCombustionThermo/hsCombustionThermo.C
  combustionThermo/hsCombustionThermo/newhsCombustionThermo.C
  combustionThermo/hsCombustionThermo/hsCombustionThermos.C
  combustionThermo/hhuCombustionThermo/hhuCombustionThermo.C
  combustionThermo/hhuCombustionThermo/newhhuCombustionThermo.C
  combustionThermo/hhuCombustionThermo/hhuCombustionThermos.C
  reactionThermo/hReactionThermo/hReactionThermo.C
  reactionThermo/hReactionThermo/newhReactionThermo.C
  reactionThermo/hReactionThermo/hReactionThermos.C
  reactionThermo/hsReactionThermo/hsReactionThermo.C
  reactionThermo/hsReactionThermo/newhsReactionThermo.C
  reactionThermo/hsReactionThermo/hsReactionThermos.C
  derivedFvPatchFields/fixedUnburntEnthalpy/fixedUnburntEnthalpyFvPatchScalarField.C
  derivedFvPatchFields/gradientUnburntEnthalpy/gradientUnburntEnthalpyFvPatchScalarField.C
  derivedFvPatchFields/mixedUnburntEnthalpy/mixedUnburntEnthalpyFvPatchScalarField.C
  )

set(HDRS
  chemistryReaders/chemistryReader/chemistryReader.C
  chemistryReaders/chemistryReader/chemistryReader.H
  chemistryReaders/chemkinReader/chemkinReader.H
  chemistryReaders/foamChemistryReader/foamChemistryReader.C
  chemistryReaders/foamChemistryReader/foamChemistryReader.H
  combustionThermo/hCombustionThermo/hCombustionThermo.H
  combustionThermo/hCombustionThermo/makeCombustionThermo.H
  combustionThermo/hsCombustionThermo/hsCombustionThermo.H
  combustionThermo/hsCombustionThermo/makeHsCombustionThermo.H
  combustionThermo/hhuCombustionThermo/hhuCombustionThermo.H
  combustionThermo/mixtureThermos/hPsiMixtureThermo/hPsiMixtureThermo.C
  combustionThermo/mixtureThermos/hPsiMixtureThermo/hPsiMixtureThermo.H
  combustionThermo/mixtureThermos/hsPsiMixtureThermo/hsPsiMixtureThermo.C
  combustionThermo/mixtureThermos/hsPsiMixtureThermo/hsPsiMixtureThermo.H
  combustionThermo/mixtureThermos/hhuMixtureThermo/hhuMixtureThermo.C
  combustionThermo/mixtureThermos/hhuMixtureThermo/hhuMixtureThermo.H
  derivedFvPatchFields/fixedUnburntEnthalpy/fixedUnburntEnthalpyFvPatchScalarField.H
  derivedFvPatchFields/gradientUnburntEnthalpy/gradientUnburntEnthalpyFvPatchScalarField.H
  derivedFvPatchFields/mixedUnburntEnthalpy/mixedUnburntEnthalpyFvPatchScalarField.H
  mixtures/basicMultiComponentMixture/basicMultiComponentMixture.H
  mixtures/basicMultiComponentMixture/basicMultiComponentMixtureI.H
  mixtures/dieselMixture/dieselMixture.C
  mixtures/dieselMixture/dieselMixture.H
  mixtures/egrMixture/egrMixture.C
  mixtures/egrMixture/egrMixture.H
  mixtures/homogeneousMixture/homogeneousMixture.C
  mixtures/homogeneousMixture/homogeneousMixture.H
  mixtures/inhomogeneousMixture/inhomogeneousMixture.C
  mixtures/inhomogeneousMixture/inhomogeneousMixture.H
  mixtures/multiComponentMixture/multiComponentMixture.C
  mixtures/multiComponentMixture/multiComponentMixture.H
  mixtures/reactingMixture/reactingMixture.C
  mixtures/reactingMixture/reactingMixture.H
  mixtures/veryInhomogeneousMixture/veryInhomogeneousMixture.C
  mixtures/veryInhomogeneousMixture/veryInhomogeneousMixture.H
  reactionThermo/hReactionThermo/hReactionThermo.H
  reactionThermo/hReactionThermo/makeReactionThermo.H
  reactionThermo/hsReactionThermo/hsReactionThermo.H
  reactionThermo/hsReactionThermo/makeHsReactionThermo.H
  reactionThermo/mixtureThermos/hRhoMixtureThermo/hRhoMixtureThermo.C
  reactionThermo/mixtureThermos/hRhoMixtureThermo/hRhoMixtureThermo.H
  reactionThermo/mixtureThermos/hsRhoMixtureThermo/hsRhoMixtureThermo.C
  reactionThermo/mixtureThermos/hsRhoMixtureThermo/hsRhoMixtureThermo.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
