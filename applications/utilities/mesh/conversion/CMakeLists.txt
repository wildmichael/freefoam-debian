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


add_subdirectory(Optional)
add_subdirectory(ansysToFoam)
add_subdirectory(cfx4ToFoam)
add_subdirectory(fluent3DMeshToFoam)
add_subdirectory(fluentMeshToFoam)
add_subdirectory(foamMeshToFluent)
add_subdirectory(foamToStarMesh)
add_subdirectory(gambitToFoam)
add_subdirectory(gmshToFoam)
add_subdirectory(ideasUnvToFoam)
add_subdirectory(kivaToFoam)
add_subdirectory(mshToFoam)
add_subdirectory(netgenNeutralToFoam)
add_subdirectory(plot3dToFoam)
add_subdirectory(polyDualMesh)
add_subdirectory(sammToFoam)
add_subdirectory(star4ToFoam)
add_subdirectory(starToFoam)
add_subdirectory(tetgenToFoam)
add_subdirectory(writeMeshObj)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
