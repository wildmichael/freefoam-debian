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
  ensight/file/ensightFile.C
  ensight/file/ensightGeoFile.C
  ensight/part/ensightPart.C
  ensight/part/ensightPartIO.C
  ensight/part/ensightPartCells.C
  ensight/part/ensightPartFaces.C
  ensight/part/ensightParts.C
  meshTables/boundaryRegion.C
  meshTables/cellTable.C
  meshReader/meshReader.C
  meshReader/meshReaderAux.C
  meshReader/calcPointCells.C
  meshReader/createPolyCells.C
  meshReader/createPolyBoundary.C
  meshReader/starcd/STARCDMeshReader.C
  meshWriter/meshWriter.C
  meshWriter/starcd/STARCDMeshWriter.C
  polyDualMesh/polyDualMesh.C
  )

set(HDRS
  ensight/file/ensightFile.H
  ensight/file/ensightGeoFile.H
  ensight/part/ensightPart.H
  ensight/part/ensightPartCells.H
  ensight/part/ensightPartFaces.H
  ensight/part/ensightPartI.H
  ensight/part/ensightParts.H
  ensight/part/ensightPartsI.H
  meshReader/meshReader.H
  meshReader/starcd/STARCDMeshReader.H
  meshTables/boundaryRegion.H
  meshTables/cellTable.H
  meshWriter/meshWriter.H
  meshWriter/starcd/STARCDMeshWriter.H
  polyDualMesh/polyDualMesh.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
