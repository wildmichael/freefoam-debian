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
  LaunderSharmaKE/LaunderSharmaKE.C
  LRR/LRR.C
  LaunderGibsonRSTM/LaunderGibsonRSTM.C
  realizableKE/realizableKE.C
  SpalartAllmaras/SpalartAllmaras.C
  kOmegaSST/kOmegaSST.C
  derivedFvPatchFields/wallFunctions/alphatWallFunctions/alphatWallFunction/alphatWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutLowReWallFunction/mutLowReWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutkWallFunction/mutkWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutWallFunction/mutWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutRoughWallFunction/mutRoughWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutSpalartAllmarasWallFunction/mutSpalartAllmarasWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutSpalartAllmarasStandardWallFunction/mutSpalartAllmarasStandardWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutSpalartAllmarasStandardRoughWallFunction/mutSpalartAllmarasStandardRoughWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/epsilonWallFunctions/epsilonWallFunction/epsilonWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/omegaWallFunctions/omegaWallFunction/omegaWallFunctionFvPatchScalarField.C
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchFields.C
  derivedFvPatchFields/turbulentHeatFluxTemperature/turbulentHeatFluxTemperatureFvPatchScalarField.C
  derivedFvPatchFields/turbulentMixingLengthDissipationRateInlet/turbulentMixingLengthDissipationRateInletFvPatchScalarField.C
  derivedFvPatchFields/turbulentMixingLengthFrequencyInlet/turbulentMixingLengthFrequencyInletFvPatchScalarField.C
  derivedFvPatchFields/turbulentTemperatureCoupledBaffle/turbulentTemperatureCoupledBaffleFvPatchScalarField.C
  derivedFvPatchFields/turbulentTemperatureCoupledBaffle/regionProperties.C
  derivedFvPatchFields/turbulentTemperatureCoupledBaffleMixed/turbulentTemperatureCoupledBaffleMixedFvPatchScalarField.C
  backwardsCompatibility/wallFunctions/backwardsCompatibilityWallFunctions.C
  )

set(HDRS
  LRR/LRR.H
  LaunderGibsonRSTM/LaunderGibsonRSTM.H
  LaunderSharmaKE/LaunderSharmaKE.H
  RASModel/forceLink.C
  RASModel/RASModel.H
  RNGkEpsilon/RNGkEpsilon.H
  SpalartAllmaras/SpalartAllmaras.H
  backwardsCompatibility/wallFunctions/backwardsCompatibilityWallFunctions.H
  backwardsCompatibility/wallFunctions/backwardsCompatibilityWallFunctionsTemplates.C
  derivedFvPatchFields/turbulentHeatFluxTemperature/turbulentHeatFluxTemperatureFvPatchScalarField.H
  derivedFvPatchFields/turbulentMixingLengthDissipationRateInlet/turbulentMixingLengthDissipationRateInletFvPatchScalarField.H
  derivedFvPatchFields/turbulentMixingLengthFrequencyInlet/turbulentMixingLengthFrequencyInletFvPatchScalarField.H
  derivedFvPatchFields/turbulentTemperatureCoupledBaffle/turbulentTemperatureCoupledBaffleFvPatchScalarField.H
  derivedFvPatchFields/turbulentTemperatureCoupledBaffle/regionProperties.H
  derivedFvPatchFields/turbulentTemperatureCoupledBaffleMixed/turbulentTemperatureCoupledBaffleMixedFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/alphatWallFunctions/alphatWallFunction/alphatWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutLowReWallFunction/mutLowReWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/epsilonWallFunctions/epsilonWallFunction/epsilonWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchField.C
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchField.H
  derivedFvPatchFields/wallFunctions/kqRWallFunctions/kqRWallFunction/kqRWallFunctionFvPatchFields.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutkWallFunction/mutkWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutRoughWallFunction/mutRoughWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutSpalartAllmarasStandardRoughWallFunction/mutSpalartAllmarasStandardRoughWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutSpalartAllmarasStandardWallFunction/mutSpalartAllmarasStandardWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutSpalartAllmarasWallFunction/mutSpalartAllmarasWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/mutWallFunctions/mutWallFunction/mutWallFunctionFvPatchScalarField.H
  derivedFvPatchFields/wallFunctions/omegaWallFunctions/omegaWallFunction/omegaWallFunctionFvPatchScalarField.H
  kEpsilon/kEpsilon.H
  kOmegaSST/kOmegaSST.H
  laminar/laminar.H
  realizableKE/realizableKE.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
