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

add_subdirectory(attachMesh)
add_subdirectory(autoPatch)
add_subdirectory(cellSet)
add_subdirectory(checkMesh)
add_subdirectory(createBaffles)
add_subdirectory(createPatch)
add_subdirectory(deformedGeom)
add_subdirectory(faceSet)
add_subdirectory(flattenMesh)
add_subdirectory(insideCells)
add_subdirectory(mergeMeshes)
add_subdirectory(mergeOrSplitBaffles)
add_subdirectory(mirrorMesh)
add_subdirectory(moveDynamicMesh)
add_subdirectory(moveEngineMesh)
add_subdirectory(moveMesh)
add_subdirectory(objToVTK)
add_subdirectory(pointSet)
add_subdirectory(refineMesh)
add_subdirectory(renumberMesh)
add_subdirectory(rotateMesh)
add_subdirectory(setSet)
add_subdirectory(setsToZones)
add_subdirectory(splitMesh)
add_subdirectory(splitMeshRegions)
add_subdirectory(stitchMesh)
add_subdirectory(subsetMesh)
add_subdirectory(transformPoints)
add_subdirectory(zipUpMesh)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
