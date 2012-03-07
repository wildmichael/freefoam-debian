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
  RASModel/RASModel.C
  laminar/laminar.C
  kEpsilon/kEpsilon.C
  RNGkEpsilon/RNGkEpsilon.C
  realizableKE/realizableKE.C
  kOmega/kOmega.C
  kOmegaSST/kOmegaSST.C
  SpalartAllmaras/SpalartAllmaras.C
  LRR/LRR.C
  LaunderGibsonRSTM/LaunderGibsonRSTM.C
  LaunderSharmaKE/LaunderSharmaKE.C
  qZeta/qZeta.C
  LienCubicKE/LienCubicKE.C
  LienCubicKELowRe/LienCubicKELowRe.C
  NonlinearKEShih/NonlinearKEShih.C
  LienLeschzinerLowRe/LienLeschzinerLowRe.C
  LamBremhorstKE/LamBremhorstKE.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutLowReWallFunction/nutLowReWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutkWallFunction/nutkWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutWallFunction/nutWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutRoughWallFunction/nutRoughWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutSpalartAllmarasWallFunction/nutSpalartAllmarasWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutSpalartAllmarasStandardWallFunction/nutSpalartAllmarasStandardWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutSpalartAllmarasStandardRoughWallFunction/nutSpalartAllmarasStandardRoughWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/epsilonWallFunctions/epsilonWallFunction/epsilonWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/omegaWallFunctions/omegaWallFunction/omegaWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchFields.C
  derivedFvPatchFields/wallFunctions/kappatWallFunctions/kappatJayatillekeWallFunction/kappatJayatillekeWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/turbulentHeatFluxTemperature/turbulentHeatFluxTemperatureFvPatchScalarField.C
  derivedFvPatchFields/turbulentMixingLengthDissipationRateInlet/turbulentMixingLengthDissipationRateInletFvPatchScalarField.C
  derivedFvPatchFields/turbulentMixingLengthFrequencyInlet/turbulentMixingLengthFrequencyInletFvPatchScalarField.C
  derivedFvPatchFields/fixedShearStress/fixedShearStressFvPatchVectorField.C
  derivedFvPatchFields/atmBoundaryLayerInletEpsilon/atmBoundaryLayerInletEpsilonFvPatchScalarField.C
  derivedFvPatchFields/atmBoundaryLayerInletVelocity/atmBoundaryLayerInletVelocityFvPatchVectorField.C
  backwardsCompatibility/wallFunctions/backwardsCompatibilityWallFunctions.C
  )

set(HDRS
  LRR/LRR.H
  LamBremhorstKE/LamBremhorstKE.H
  LaunderGibsonRSTM/LaunderGibsonRSTM.H
  LaunderSharmaKE/LaunderSharmaKE.H
  LienCubicKE/LienCubicKE.H
  LienCubicKELowRe/LienCubicKELowRe.H
  LienCubicKELowRe/LienCubicKELowReSetWallDissipation.H
  LienLeschzinerLowRe/LienLeschzinerLowRe.H
  LienLeschzinerLowRe/LienLeschzinerLowReSetWallDissipation.H
  NonlinearKEShih/NonlinearKEShih.H
  RASModel/forceLink.C
  RASModel/RASModel.H
  RNGkEpsilon/RNGkEpsilon.H
  SpalartAllmaras/SpalartAllmaras.H
  backwardsCompatibility/wallFunctions/backwardsCompatibilityWallFunctions.H
  backwardsCompatibility/wallFunctions/backwardsCompatibilityWallFunctionsTemplates.C
  derivedFvPatchFields/turbulentHeatFluxTemperature/turbulentHeatFluxTemperatureFvPatchScalarField.H
  derivedFvPatchFields/turbulentMixingLengthDissipationRateInlet/turbulentMixingLengthDissipationRateInletFvPatchScalarField.H
  derivedFvPatchFields/turbulentMixingLengthFrequencyInlet/turbulentMixingLengthFrequencyInletFvPatchScalarField.H
  derivedFvPatchFields/fixedShearStress/fixedShearStressFvPatchVectorField.H
  derivedFvPatchFields/atmBoundaryLayerInletEpsilon/atmBoundaryLayerInletEpsilonFvPatchScalarField.H
  derivedFvPatchFields/atmBoundaryLayerInletVelocity/atmBoundaryLayerInletVelocityFvPatchVectorField.H
  derivedFvPatchFields/wallFunctions/epsilonWallFunctions/epsilonWallFunction/epsilonWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchField.C
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchField.H
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchFields.H
  derivedFvPatchFields/wallFunctions/kappatWallFunctions/kappatJayatillekeWallFunction/kappatJayatillekeWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutLowReWallFunction/nutLowReWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutkWallFunction/nutkWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutRoughWallFunction/nutRoughWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutSpalartAllmarasStandardRoughWallFunction/nutSpalartAllmarasStandardRoughWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutSpalartAllmarasStandardWallFunction/nutSpalartAllmarasStandardWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutSpalartAllmarasWallFunction/nutSpalartAllmarasWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/nutWallFunctions/nutWallFunction/nutWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/omegaWallFunctions/omegaWallFunction/omegaWallFunctionFvPatchScalarField.H
  include/nonLinearWallFunctionsI.H
  include/wallDissipationI.H
  include/wallNonlinearViscosityI.H
  kEpsilon/kEpsilon.H
  kOmega/kOmega.H
  kOmegaSST/kOmegaSST.H
  laminar/laminar.H
  qZeta/qZeta.H
  realizableKE/realizableKE.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
