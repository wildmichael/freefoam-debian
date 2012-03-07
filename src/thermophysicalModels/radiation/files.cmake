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
  radiationConstants/radiationConstants.C
  radiationModel/radiationModel/radiationModel.C
  radiationModel/radiationModel/newRadiationModel.C
  radiationModel/noRadiation/noRadiation.C
  radiationModel/P1/P1.C
  radiationModel/fvDOM/fvDOM/fvDOM.C
  radiationModel/fvDOM/radiativeIntensityRay/radiativeIntensityRay.C
  radiationModel/fvDOM/blackBodyEmission/blackBodyEmission.C
  radiationModel/fvDOM/absorptionCoeffs/absorptionCoeffs.C
  submodels/scatterModel/scatterModel/scatterModel.C
  submodels/scatterModel/scatterModel/newScatterModel.C
  submodels/scatterModel/constantScatter/constantScatter.C
  submodels/absorptionEmissionModel/absorptionEmissionModel/absorptionEmissionModel.C
  submodels/absorptionEmissionModel/absorptionEmissionModel/newAbsorptionEmissionModel.C
  submodels/absorptionEmissionModel/noAbsorptionEmission/noAbsorptionEmission.C
  submodels/absorptionEmissionModel/constantAbsorptionEmission/constantAbsorptionEmission.C
  submodels/absorptionEmissionModel/binaryAbsorptionEmission/binaryAbsorptionEmission.C
  submodels/absorptionEmissionModel/greyMeanAbsorptionEmission/greyMeanAbsorptionEmission.C
  submodels/absorptionEmissionModel/wideBandAbsorptionEmission/wideBandAbsorptionEmission.C
  derivedFvPatchFields/MarshakRadiation/MarshakRadiationMixedFvPatchScalarField.C
  derivedFvPatchFields/MarshakRadiationFixedT/MarshakRadiationFixedTMixedFvPatchScalarField.C
  derivedFvPatchFields/greyDiffusiveRadiation/greyDiffusiveRadiationMixedFvPatchScalarField.C
  derivedFvPatchFields/wideBandDiffusiveRadiation/wideBandDiffusiveRadiationMixedFvPatchScalarField.C
  )

set(HDRS
  derivedFvPatchFields/MarshakRadiation/MarshakRadiationMixedFvPatchScalarField.H
  derivedFvPatchFields/MarshakRadiationFixedT/MarshakRadiationFixedTMixedFvPatchScalarField.H
  derivedFvPatchFields/greyDiffusiveRadiation/greyDiffusiveRadiationMixedFvPatchScalarField.H
  derivedFvPatchFields/wideBandDiffusiveRadiation/wideBandDiffusiveRadiationMixedFvPatchScalarField.H
  include/createRadiationModel.H
  radiationConstants/radiationConstants.H
  radiationModel/P1/P1.H
  radiationModel/fvDOM/absorptionCoeffs/absorptionCoeffs.H
  radiationModel/fvDOM/absorptionCoeffs/absorptionCoeffsI.H
  radiationModel/fvDOM/blackBodyEmission/blackBodyEmission.H
  radiationModel/fvDOM/fvDOM/fvDOM.H
  radiationModel/fvDOM/fvDOM/fvDOMI.H
  radiationModel/fvDOM/interpolationLookUpTable/interpolationLookUpTable.C
  radiationModel/fvDOM/interpolationLookUpTable/interpolationLookUpTable.H
  radiationModel/fvDOM/interpolationLookUpTable/interpolationLookUpTableI.H
  radiationModel/fvDOM/radiativeIntensityRay/radiativeIntensityRay.H
  radiationModel/fvDOM/radiativeIntensityRay/radiativeIntensityRayI.H
  radiationModel/noRadiation/noRadiation.H
  radiationModel/radiationModel/radiationModel.H
  radiationModel/radiationModel/forceLink.C
  submodels/absorptionEmissionModel/absorptionEmissionModel/absorptionEmissionModel.H
  submodels/absorptionEmissionModel/binaryAbsorptionEmission/binaryAbsorptionEmission.H
  submodels/absorptionEmissionModel/constantAbsorptionEmission/constantAbsorptionEmission.H
  submodels/absorptionEmissionModel/greyMeanAbsorptionEmission/greyMeanAbsorptionEmission.H
  submodels/absorptionEmissionModel/noAbsorptionEmission/noAbsorptionEmission.H
  submodels/absorptionEmissionModel/wideBandAbsorptionEmission/wideBandAbsorptionEmission.H
  submodels/scatterModel/constantScatter/constantScatter.H
  submodels/scatterModel/scatterModel/scatterModel.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
