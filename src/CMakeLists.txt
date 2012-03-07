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

add_subdirectory(Pstream)
add_subdirectory(OSspecific)
add_subdirectory(OpenFOAM)
add_subdirectory(lagrangian)
add_subdirectory(triSurface)
add_subdirectory(edgeMesh)
add_subdirectory(meshTools)
add_subdirectory(finiteVolume)
add_subdirectory(genericPatchFields)
add_subdirectory(decompositionMethods)
add_subdirectory(sampling)
add_subdirectory(dynamicMesh)
add_subdirectory(dynamicFvMesh)
add_subdirectory(topoChangerFvMesh)
add_subdirectory(fvMotionSolver)
add_subdirectory(engine)
add_subdirectory(ODE)
add_subdirectory(randomProcesses)
add_subdirectory(thermophysicalModels)
add_subdirectory(transportModels)
add_subdirectory(turbulenceModels)
add_subdirectory(postProcessing)
add_subdirectory(conversion)
add_subdirectory(autoMesh)
add_subdirectory(errorEstimation)
foam_conditional_component(MGridGenGamgAgglomeration ${FOAM_ENABLE_MGRIDGEN}
  fvAgglomerationMethods/MGridGenGamgAgglomeration
  "FOAM_ENABLE_MGRIDGEN disabled")
add_subdirectory(surfMesh)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
