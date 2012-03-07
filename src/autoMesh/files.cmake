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
  autoHexMesh/autoHexMeshDriver/autoLayerDriver.C
  autoHexMesh/autoHexMeshDriver/autoLayerDriverShrink.C
  autoHexMesh/autoHexMeshDriver/autoSnapDriver.C
  autoHexMesh/autoHexMeshDriver/autoRefineDriver.C
  autoHexMesh/autoHexMeshDriver/autoHexMeshDriver.C
  autoHexMesh/autoHexMeshDriver/layerParameters/layerParameters.C
  autoHexMesh/autoHexMeshDriver/refinementParameters/refinementParameters.C
  autoHexMesh/autoHexMeshDriver/snapParameters/snapParameters.C
  autoHexMesh/autoHexMeshDriver/pointData/pointData.C
  autoHexMesh/meshRefinement/meshRefinementBaffles.C
  autoHexMesh/meshRefinement/meshRefinement.C
  autoHexMesh/meshRefinement/meshRefinementMerge.C
  autoHexMesh/meshRefinement/meshRefinementProblemCells.C
  autoHexMesh/meshRefinement/meshRefinementRefine.C
  autoHexMesh/refinementSurfaces/refinementSurfaces.C
  autoHexMesh/shellSurfaces/shellSurfaces.C
  autoHexMesh/trackedParticle/trackedParticle.C
  autoHexMesh/trackedParticle/trackedParticleCloud.C
  )

set(HDRS
  autoHexMesh/autoHexMeshDriver/autoHexMeshDriver.H
  autoHexMesh/autoHexMeshDriver/autoLayerDriver.H
  autoHexMesh/autoHexMeshDriver/autoLayerDriverTemplates.C
  autoHexMesh/autoHexMeshDriver/autoRefineDriver.H
  autoHexMesh/autoHexMeshDriver/autoSnapDriver.H
  autoHexMesh/autoHexMeshDriver/layerParameters/layerParameters.H
  autoHexMesh/autoHexMeshDriver/pointData/pointData.H
  autoHexMesh/autoHexMeshDriver/pointData/pointDataI.H
  autoHexMesh/autoHexMeshDriver/refinementParameters/refinementParameters.H
  autoHexMesh/autoHexMeshDriver/snapParameters/snapParameters.H
  autoHexMesh/meshRefinement/meshRefinement.H
  autoHexMesh/meshRefinement/meshRefinementTemplates.C
  autoHexMesh/refinementSurfaces/refinementSurfaces.H
  autoHexMesh/shellSurfaces/shellSurfaces.H
  autoHexMesh/trackedParticle/ExactParticle.C
  autoHexMesh/trackedParticle/ExactParticle.H
  autoHexMesh/trackedParticle/trackedParticle.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
