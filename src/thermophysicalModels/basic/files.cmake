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
  mixtures/basicMixture/basicMixture.C
  mixtures/basicMixture/basicMixtures.C
  basicThermo/basicThermo.C
  psiThermo/basicPsiThermo/basicPsiThermo.C
  psiThermo/basicPsiThermo/newBasicPsiThermo.C
  psiThermo/hPsiThermo/hPsiThermos.C
  psiThermo/hsPsiThermo/hsPsiThermos.C
  psiThermo/ePsiThermo/ePsiThermos.C
  rhoThermo/basicRhoThermo/basicRhoThermo.C
  rhoThermo/basicRhoThermo/newBasicRhoThermo.C
  rhoThermo/hRhoThermo/hRhoThermos.C
  rhoThermo/hsRhoThermo/hsRhoThermos.C
  derivedFvPatchFields/fixedEnthalpy/fixedEnthalpyFvPatchScalarField.C
  derivedFvPatchFields/gradientEnthalpy/gradientEnthalpyFvPatchScalarField.C
  derivedFvPatchFields/mixedEnthalpy/mixedEnthalpyFvPatchScalarField.C
  derivedFvPatchFields/fixedInternalEnergy/fixedInternalEnergyFvPatchScalarField.C
  derivedFvPatchFields/gradientInternalEnergy/gradientInternalEnergyFvPatchScalarField.C
  derivedFvPatchFields/mixedInternalEnergy/mixedInternalEnergyFvPatchScalarField.C
  derivedFvPatchFields/wallHeatTransfer/wallHeatTransferFvPatchScalarField.C
  )

set(HDRS
  basicThermo/basicThermo.H
  derivedFvPatchFields/fixedEnthalpy/fixedEnthalpyFvPatchScalarField.H
  derivedFvPatchFields/fixedInternalEnergy/fixedInternalEnergyFvPatchScalarField.H
  derivedFvPatchFields/gradientEnthalpy/gradientEnthalpyFvPatchScalarField.H
  derivedFvPatchFields/gradientInternalEnergy/gradientInternalEnergyFvPatchScalarField.H
  derivedFvPatchFields/mixedEnthalpy/mixedEnthalpyFvPatchScalarField.H
  derivedFvPatchFields/mixedInternalEnergy/mixedInternalEnergyFvPatchScalarField.H
  derivedFvPatchFields/wallHeatTransfer/wallHeatTransferFvPatchScalarField.H
  mixtures/basicMixture/basicMixture.H
  mixtures/basicMixture/makeBasicMixture.H
  mixtures/pureMixture/pureMixture.C
  mixtures/pureMixture/pureMixture.H
  psiThermo/basicPsiThermo/basicPsiThermo.H
  psiThermo/basicPsiThermo/makeBasicPsiThermo.H
  psiThermo/ePsiThermo/ePsiThermo.C
  psiThermo/ePsiThermo/ePsiThermo.H
  psiThermo/hPsiThermo/hPsiThermo.C
  psiThermo/hPsiThermo/hPsiThermo.H
  psiThermo/hsPsiThermo/hsPsiThermo.C
  psiThermo/hsPsiThermo/hsPsiThermo.H
  rhoThermo/basicRhoThermo/basicRhoThermo.H
  rhoThermo/basicRhoThermo/makeBasicRhoThermo.H
  rhoThermo/hRhoThermo/hRhoThermo.C
  rhoThermo/hRhoThermo/hRhoThermo.H
  rhoThermo/hsRhoThermo/hsRhoThermo.C
  rhoThermo/hsRhoThermo/hsRhoThermo.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
