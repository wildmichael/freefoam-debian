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
  vanDriestDelta/vanDriestDelta.C
  LESModel/LESModel.C
  GenEddyVisc/GenEddyVisc.C
  GenSGSStress/GenSGSStress.C
  laminar/laminar.C
  SpalartAllmaras/SpalartAllmaras.C
  SpalartAllmarasDDES/SpalartAllmarasDDES.C
  SpalartAllmarasIDDES/SpalartAllmarasIDDES.C
  SpalartAllmarasIDDES/IDDESDelta/IDDESDelta.C
  oneEqEddy/oneEqEddy.C
  dynOneEqEddy/dynOneEqEddy.C
  locDynOneEqEddy/locDynOneEqEddy.C
  Smagorinsky/Smagorinsky.C
  homogeneousDynSmagorinsky/homogeneousDynSmagorinsky.C
  LRRDiffStress/LRRDiffStress.C
  DeardorffDiffStress/DeardorffDiffStress.C
  spectEddyVisc/spectEddyVisc.C
  scaleSimilarity/scaleSimilarity.C
  mixedSmagorinsky/mixedSmagorinsky.C
  kOmegaSSTSAS/kOmegaSSTSAS.C
  derivedFvPatchFields/wallFunctions/nuSgsWallFunctions/nuSgsWallFunction/nuSgsWallFunctionFvPatchScalarField.C
  )

set(HDRS
  DeardorffDiffStress/DeardorffDiffStress.H
  GenEddyVisc/GenEddyVisc.H
  GenSGSStress/GenSGSStress.H
  LESModel/forceLink.C
  LESModel/LESModel.H
  LRRDiffStress/LRRDiffStress.H
  Smagorinsky/Smagorinsky.H
  Smagorinsky2/Smagorinsky2.C
  Smagorinsky2/Smagorinsky2.H
  SpalartAllmaras/SpalartAllmaras.H
  SpalartAllmarasDDES/SpalartAllmarasDDES.H
  SpalartAllmarasIDDES/IDDESDelta/IDDESDelta.H
  SpalartAllmarasIDDES/SpalartAllmarasIDDES.H
  derivedFvPatchFields/wallFunctions/nuSgsWallFunctions/nuSgsWallFunction/nuSgsWallFunctionFvPatchScalarField.H
  dynOneEqEddy/dynOneEqEddy.H
  homogeneousDynSmagorinsky/homogeneousDynSmagorinsky.H
  kOmegaSSTSAS/kOmegaSSTSAS.H
  laminar/laminar.H
  locDynOneEqEddy/locDynOneEqEddy.H
  mixedSmagorinsky/mixedSmagorinsky.H
  oneEqEddy/oneEqEddy.H
  scaleSimilarity/scaleSimilarity.H
  spectEddyVisc/spectEddyVisc.H
  vanDriestDelta/vanDriestDelta.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
