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
  faceTriangulation/faceTriangulation.C
  meshTriangulation/meshTriangulation.C
  triSurface/triSurface.C
  triSurface/triSurfaceAddressing.C
  triSurface/stitchTriangles.C
  triSurface/interfaces/STL/writeSTL.C
  triSurface/interfaces/STL/readSTL.C
  triSurface/interfaces/STL/readSTLASCII.L
  triSurface/interfaces/STL/readSTLBINARY.C
  triSurface/interfaces/GTS/writeGTS.C
  triSurface/interfaces/GTS/readGTS.C
  triSurface/interfaces/OBJ/readOBJ.C
  triSurface/interfaces/OBJ/writeOBJ.C
  triSurface/interfaces/SMESH/writeSMESH.C
  triSurface/interfaces/OFF/readOFF.C
  triSurface/interfaces/OFF/writeOFF.C
  triSurface/interfaces/TRI/writeTRI.C
  triSurface/interfaces/TRI/readTRI.C
  triSurface/interfaces/DX/writeDX.C
  triSurface/interfaces/AC3D/readAC.C
  triSurface/interfaces/AC3D/writeAC.C
  triSurface/interfaces/VTK/writeVTK.C
  triSurface/interfaces/NAS/readNAS.C
  triSurface/geometricSurfacePatch/geometricSurfacePatch.C
  triSurface/surfacePatch/surfacePatch.C
  triSurface/surfacePatch/surfacePatchIOList.C
  tools/labelledTri/sortLabelledTri.C
  triSurfaceFields/triSurfaceFields.C
  )

set(HDRS
  faceTriangulation/faceTriangulation.H
  meshTriangulation/meshTriangulation.H
  tools/hashSignedLabel/hashSignedLabel.H
  tools/labelPair/labelPairLookup.H
  tools/labelledTri/labelledTri.H
  tools/labelledTri/labelledTriI.H
  tools/labelledTri/sortLabelledTri.H
  triSurface/geometricSurfacePatch/geometricSurfacePatch.H
  triSurface/geometricSurfacePatch/geometricSurfacePatchList.H
  triSurface/interfaces/STL/STLpoint.H
  triSurface/interfaces/STL/STLpointI.H
  triSurface/interfaces/STL/STLtriangle.H
  triSurface/interfaces/STL/STLtriangleI.H
  triSurface/surfacePatch/surfacePatch.H
  triSurface/surfacePatch/surfacePatchIOList.H
  triSurface/surfacePatch/surfacePatchList.H
  triSurface/triSurface.H
  triSurfaceFields/triSurfaceFields.H
  triSurfaceFields/triSurfaceFieldsFwd.H
  triSurfaceFields/triSurfaceGeoMesh.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
