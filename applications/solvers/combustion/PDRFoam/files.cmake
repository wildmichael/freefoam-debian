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

set(COMMON_SRCS
  XiModels/XiModel/XiModel.C
  XiModels/XiModel/newXiModel.C
  XiModels/fixed/fixed.C
  XiModels/algebraic/algebraic.C
  XiModels/transport/transport.C
  XiModels/XiEqModels/XiEqModel/XiEqModel.C
  XiModels/XiEqModels/XiEqModel/newXiEqModel.C
  XiModels/XiEqModels/Gulder/Gulder.C
  XiModels/XiEqModels/instabilityXiEq/instabilityXiEq.C
  XiModels/XiEqModels/SCOPEBlendXiEq/SCOPEBlendXiEq.C
  XiModels/XiEqModels/SCOPEXiEq/SCOPEXiEq.C
  XiModels/XiGModels/XiGModel/XiGModel.C
  XiModels/XiGModels/XiGModel/newXiGModel.C
  XiModels/XiGModels/KTS/KTS.C
  XiModels/XiGModels/instabilityG/instabilityG.C
  PDRModels/turbulence/PDRkEpsilon/PDRkEpsilon.C
  PDRModels/dragModels/PDRDragModel/PDRDragModel.C
  PDRModels/dragModels/PDRDragModel/newPDRDragModel.C
  PDRModels/dragModels/basic/basic.C
  PDRModels/XiEqModels/basicXiSubXiEq/basicXiSubXiEq.C
  PDRModels/XiGModels/basicXiSubG/basicXiSubG.C
  laminarFlameSpeed/SCOPE/SCOPELaminarFlameSpeed.C
  ${FORCE_LINK_COMPRESSIBLE_RAS_MODELS})

set(PDR_SRCS
  PDRFoam.C
  ${COMMON_SRCS}
  )

set(PDRAUTOREFINE_SRCS
  PDRFoamAutoRefine.C
  ${COMMON_SRCS}
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
