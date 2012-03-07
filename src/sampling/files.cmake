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
  probes/probes.C
  probes/probesFunctionObject.C
  probes/patchProbes.C
  sampledSet/coordSet/coordSet.C
  sampledSet/patchCloud/patchCloudSet.C
  sampledSet/sampledSet/sampledSet.C
  sampledSet/cloud/cloudSet.C
  sampledSet/face/faceOnlySet.C
  sampledSet/curve/curveSet.C
  sampledSet/uniform/uniformSet.C
  sampledSet/midPoint/midPointSet.C
  sampledSet/midPointAndFace/midPointAndFaceSet.C
  sampledSet/sampledSets/sampledSets.C
  sampledSet/sampledSetsFunctionObject/sampledSetsFunctionObject.C
  sampledSet/writers/writers.C
  sampledSet/writers/gnuplot/gnuplotSetWriterRunTime.C
  sampledSet/writers/jplot/jplotSetWriterRunTime.C
  sampledSet/writers/raw/rawSetWriterRunTime.C
  sampledSet/writers/xmgrace/xmgraceSetWriterRunTime.C
  sampledSet/writers/csv/csvSetWriterRunTime.C
  cuttingPlane/cuttingPlane.C
  sampledSurface/sampledPatch/sampledPatch.C
  sampledSurface/sampledPlane/sampledPlane.C
  sampledSurface/isoSurface/isoSurface.C
  sampledSurface/isoSurface/sampledIsoSurface.C
  sampledSurface/isoSurface/isoSurfaceCell.C
  sampledSurface/isoSurface/sampledIsoSurfaceCell.C
  sampledSurface/distanceSurface/distanceSurface.C
  sampledSurface/sampledCuttingPlane/sampledCuttingPlane.C
  sampledSurface/sampledSurface/sampledSurface.C
  sampledSurface/sampledSurfaces/sampledSurfaces.C
  sampledSurface/sampledSurfacesFunctionObject/sampledSurfacesFunctionObject.C
  sampledSurface/sampledTriSurfaceMesh/sampledTriSurfaceMesh.C
  sampledSurface/thresholdCellFaces/thresholdCellFaces.C
  sampledSurface/thresholdCellFaces/sampledThresholdCellFaces.C
  sampledSurface/writers/surfaceWriters.C
  sampledSurface/writers/dx/dxSurfaceWriterRunTime.C
  sampledSurface/writers/foamFile/foamFileSurfaceWriterRunTime.C
  sampledSurface/writers/null/nullSurfaceWriterRunTime.C
  sampledSurface/writers/proxy/proxySurfaceWriterRunTime.C
  sampledSurface/writers/raw/rawSurfaceWriterRunTime.C
  sampledSurface/writers/vtk/vtkSurfaceWriterRunTime.C
  graphField/writePatchGraph.C
  graphField/writeCellGraph.C
  graphField/makeGraph.C
  meshToMeshInterpolation/meshToMesh/meshToMesh.C
  meshToMeshInterpolation/meshToMesh/calculateMeshToMeshAddressing.C
  meshToMeshInterpolation/meshToMesh/calculateMeshToMeshWeights.C
  )

set(HDRS
  cuttingPlane/cuttingPlane.H
  cuttingPlane/cuttingPlaneTemplates.C
  graphField/makeGraph.H
  graphField/writeCellGraph.H
  graphField/writePatchGraph.H
  include/buildPatch.H
  include/mapPatch.H
  meshToMeshInterpolation/meshToMesh/meshToMesh.H
  meshToMeshInterpolation/meshToMesh/meshToMeshInterpolate.C
  probes/IOprobes.H
  probes/probes.H
  probes/probesFunctionObject.H
  probes/patchProbes.H
  probes/patchProbesTemplates.C
  probes/probesTemplates.C
  sampledSet/cloud/cloudSet.H
  sampledSet/coordSet/coordSet.H
  sampledSet/patchCloud/patchCloudSet.H
  sampledSet/curve/curveSet.H
  sampledSet/face/faceOnlySet.H
  sampledSet/midPoint/midPointSet.H
  sampledSet/midPointAndFace/midPointAndFaceSet.H
  sampledSet/sampledSet/sampledSet.H
  sampledSet/sampledSets/IOsampledSets.H
  sampledSet/sampledSets/sampledSets.H
  sampledSet/sampledSets/sampledSetsTemplates.C
  sampledSet/sampledSetsFunctionObject/sampledSetsFunctionObject.H
  sampledSet/uniform/uniformSet.H
  sampledSet/writers/gnuplot/gnuplotSetWriter.C
  sampledSet/writers/gnuplot/gnuplotSetWriter.H
  sampledSet/writers/jplot/jplotSetWriter.C
  sampledSet/writers/jplot/jplotSetWriter.H
  sampledSet/writers/raw/rawSetWriter.C
  sampledSet/writers/raw/rawSetWriter.H
  sampledSet/writers/writer.C
  sampledSet/writers/writer.H
  sampledSet/writers/writers.H
  sampledSet/writers/xmgrace/xmgraceSetWriter.C
  sampledSet/writers/xmgrace/xmgraceSetWriter.H
  sampledSet/writers/csv/csvSetWriter.C
  sampledSet/writers/csv/csvSetWriter.H
  sampledSurface/distanceSurface/distanceSurface.H
  sampledSurface/distanceSurface/distanceSurfaceTemplates.C
  sampledSurface/isoSurface/isoSurface.H
  sampledSurface/isoSurface/isoSurfaceCell.H
  sampledSurface/isoSurface/isoSurfaceCellTemplates.C
  sampledSurface/isoSurface/isoSurfaceTemplates.C
  sampledSurface/isoSurface/sampledIsoSurface.H
  sampledSurface/isoSurface/sampledIsoSurfaceCell.H
  sampledSurface/isoSurface/sampledIsoSurfaceCellTemplates.C
  sampledSurface/isoSurface/sampledIsoSurfaceTemplates.C
  sampledSurface/sampledCuttingPlane/sampledCuttingPlane.H
  sampledSurface/sampledCuttingPlane/sampledCuttingPlaneTemplates.C
  sampledSurface/sampledPatch/sampledPatch.H
  sampledSurface/sampledPatch/sampledPatchTemplates.C
  sampledSurface/sampledPlane/sampledPlane.H
  sampledSurface/sampledPlane/sampledPlaneTemplates.C
  sampledSurface/sampledSurface/sampledSurface.H
  sampledSurface/sampledSurface/sampledSurfaceTemplates.C
  sampledSurface/sampledSurfaces/IOsampledSurfaces.H
  sampledSurface/sampledSurfaces/sampledSurfaces.H
  sampledSurface/sampledSurfaces/sampledSurfacesTemplates.C
  sampledSurface/sampledSurfacesFunctionObject/sampledSurfacesFunctionObject.H
  sampledSurface/sampledTriSurfaceMesh/sampledTriSurfaceMesh.H
  sampledSurface/sampledTriSurfaceMesh/sampledTriSurfaceMeshTemplates.C
  sampledSurface/thresholdCellFaces/sampledThresholdCellFaces.H
  sampledSurface/thresholdCellFaces/sampledThresholdCellFacesTemplates.C
  sampledSurface/thresholdCellFaces/thresholdCellFaces.H
  sampledSurface/writers/dx/dxSurfaceWriter.C
  sampledSurface/writers/dx/dxSurfaceWriter.H
  sampledSurface/writers/foamFile/foamFileSurfaceWriter.C
  sampledSurface/writers/foamFile/foamFileSurfaceWriter.H
  sampledSurface/writers/null/nullSurfaceWriter.C
  sampledSurface/writers/null/nullSurfaceWriter.H
  sampledSurface/writers/proxy/proxySurfaceWriter.C
  sampledSurface/writers/proxy/proxySurfaceWriter.H
  sampledSurface/writers/raw/rawSurfaceWriter.C
  sampledSurface/writers/raw/rawSurfaceWriter.H
  sampledSurface/writers/surfaceWriter.C
  sampledSurface/writers/surfaceWriter.H
  sampledSurface/writers/surfaceWriters.H
  sampledSurface/writers/vtk/vtkSurfaceWriter.C
  sampledSurface/writers/vtk/vtkSurfaceWriter.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
