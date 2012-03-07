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
  attachDetach/attachDetach.C
  attachDetach/attachInterface.C
  attachDetach/detachInterface.C
  attachDetach/attachDetachPointMatchMap.C
  layerAdditionRemoval/layerAdditionRemoval.C
  layerAdditionRemoval/setLayerPairing.C
  layerAdditionRemoval/addCellLayer.C
  layerAdditionRemoval/removeCellLayer.C
  slidingInterface/enrichedPatch/enrichedPatch.C
  slidingInterface/enrichedPatch/enrichedPatchPointMap.C
  slidingInterface/enrichedPatch/enrichedPatchFaces.C
  slidingInterface/enrichedPatch/enrichedPatchPointPoints.C
  slidingInterface/enrichedPatch/enrichedPatchCutFaces.C
  slidingInterface/enrichedPatch/enrichedPatchMasterPoints.C
  polyTopoChange/polyTopoChange/topoAction/topoActions.C
  polyTopoChange/polyMeshModifier/polyMeshModifier.C
  polyTopoChange/polyMeshModifier/newPolyMeshModifier.C
  polyTopoChange/polyTopoChanger/polyTopoChanger.C
  polyTopoChange/polyTopoChange/polyTopoChange.C
  polyTopoChange/polyTopoChange/addPatchCellLayer.C
  polyTopoChange/polyTopoChange/edgeCollapser.C
  polyTopoChange/polyTopoChange/faceCollapser.C
  polyTopoChange/polyTopoChange/hexRef8.C
  polyTopoChange/polyTopoChange/removeCells.C
  polyTopoChange/polyTopoChange/removeFaces.C
  polyTopoChange/polyTopoChange/refinementData.C
  polyTopoChange/polyTopoChange/refinementDistanceData.C
  polyTopoChange/polyTopoChange/refinementHistory.C
  polyTopoChange/polyTopoChange/removePoints.C
  polyTopoChange/polyTopoChange/combineFaces.C
  polyTopoChange/polyTopoChange/localPointRegion.C
  polyTopoChange/polyTopoChange/duplicatePoints.C
  slidingInterface/slidingInterface.C
  slidingInterface/slidingInterfaceProjectPoints.C
  slidingInterface/coupleSlidingInterface.C
  slidingInterface/slidingInterfaceAttachedAddressing.C
  slidingInterface/slidingInterfaceClearCouple.C
  slidingInterface/decoupleSlidingInterface.C
  perfectInterface/perfectInterface.C
  boundaryMesh/boundaryMesh.C
  boundaryPatch/boundaryPatch.C
  boundaryMesh/octreeDataFaceList.C
  setUpdater/setUpdater.C
  meshCut/meshModifiers/boundaryCutter/boundaryCutter.C
  meshCut/meshModifiers/meshCutter/meshCutter.C
  meshCut/meshModifiers/meshCutAndRemove/meshCutAndRemove.C
  meshCut/meshModifiers/undoableMeshCutter/undoableMeshCutter.C
  meshCut/meshModifiers/refinementIterator/refinementIterator.C
  meshCut/meshModifiers/multiDirRefinement/multiDirRefinement.C
  meshCut/cellLooper/cellLooper.C
  meshCut/cellLooper/topoCellLooper.C
  meshCut/cellLooper/geomCellLooper.C
  meshCut/cellLooper/hexCellLooper.C
  meshCut/directions/directions.C
  meshCut/directions/directionInfo/directionInfo.C
  meshCut/edgeVertex/edgeVertex.C
  meshCut/cellCuts/cellCuts.C
  meshCut/splitCell/splitCell.C
  meshCut/refineCell/refineCell.C
  meshCut/wallLayerCells/wallLayerCells.C
  meshCut/wallLayerCells/wallNormalInfo/wallNormalInfo.C
  polyTopoChange/attachPolyTopoChanger/attachPolyTopoChanger.C
  polyTopoChange/repatchPolyTopoChanger/repatchPolyTopoChanger.C
  fvMeshAdder/fvMeshAdder.C
  fvMeshDistribute/fvMeshDistribute.C
  polyMeshAdder/faceCoupleInfo.C
  polyMeshAdder/polyMeshAdder.C
  motionSmoother/motionSmoother.C
  motionSmoother/motionSmootherCheck.C
  motionSmoother/polyMeshGeometry/polyMeshGeometry.C
  motionSolver/motionSolver.C
  )

set(HDRS
  attachDetach/attachDetach.H
  boundaryMesh/bMesh.H
  boundaryMesh/boundaryMesh.H
  boundaryMesh/octreeDataFaceList.H
  boundaryPatch/boundaryPatch.H
  fvMeshAdder/fvMeshAdder.H
  fvMeshAdder/fvMeshAdderTemplates.C
  fvMeshDistribute/CompactListList_dev.C
  fvMeshDistribute/CompactListList_dev.H
  fvMeshDistribute/CompactListList_devI.H
  fvMeshDistribute/CompactListList_devIO.C
  fvMeshDistribute/fvMeshDistribute.H
  fvMeshDistribute/fvMeshDistributeTemplates.C
  layerAdditionRemoval/layerAdditionRemoval.H
  meshCut/cellCuts/cellCuts.H
  meshCut/cellLooper/cellLooper.H
  meshCut/cellLooper/geomCellLooper.H
  meshCut/cellLooper/hexCellLooper.H
  meshCut/cellLooper/topoCellLooper.H
  meshCut/directions/directionInfo/directionInfo.H
  meshCut/directions/directionInfo/directionInfoI.H
  meshCut/directions/directions.H
  meshCut/edgeVertex/edgeVertex.H
  meshCut/meshModifiers/boundaryCutter/boundaryCutter.H
  meshCut/meshModifiers/meshCutAndRemove/meshCutAndRemove.H
  meshCut/meshModifiers/meshCutter/meshCutter.H
  meshCut/meshModifiers/multiDirRefinement/multiDirRefinement.H
  meshCut/meshModifiers/refinementIterator/refinementIterator.H
  meshCut/meshModifiers/undoableMeshCutter/undoableMeshCutter.H
  meshCut/refineCell/refineCell.H
  meshCut/splitCell/splitCell.H
  meshCut/wallLayerCells/wallLayerCells.H
  meshCut/wallLayerCells/wallNormalInfo/wallNormalInfo.H
  meshCut/wallLayerCells/wallNormalInfo/wallNormalInfoI.H
  motionSmoother/motionSmoother.H
  motionSmoother/motionSmootherTemplates.C
  motionSmoother/polyMeshGeometry/polyMeshGeometry.H
  motionSolver/motionSolver.H
  perfectInterface/perfectInterface.H
  polyMeshAdder/faceCoupleInfo.H
  polyMeshAdder/faceCoupleInfoTemplates.C
  polyMeshAdder/polyMeshAdder.H
  polyMeshAdder/polyMeshAdderTemplates.C
  polyTopoChange/attachPolyTopoChanger/attachPolyTopoChanger.H
  polyTopoChange/polyMeshModifier/polyMeshModifier.H
  polyTopoChange/polyTopoChange/addObject/polyAddCell.H
  polyTopoChange/polyTopoChange/addObject/polyAddFace.H
  polyTopoChange/polyTopoChange/addObject/polyAddPoint.H
  polyTopoChange/polyTopoChange/addPatchCellLayer.H
  polyTopoChange/polyTopoChange/combineFaces.H
  polyTopoChange/polyTopoChange/duplicatePoints.H
  polyTopoChange/polyTopoChange/edgeCollapser.H
  polyTopoChange/polyTopoChange/faceCollapser.H
  polyTopoChange/polyTopoChange/hexRef8.H
  polyTopoChange/polyTopoChange/localPointRegion.H
  polyTopoChange/polyTopoChange/modifyObject/polyModifyCell.H
  polyTopoChange/polyTopoChange/modifyObject/polyModifyFace.H
  polyTopoChange/polyTopoChange/modifyObject/polyModifyPoint.H
  polyTopoChange/polyTopoChange/polyTopoChange.H
  polyTopoChange/polyTopoChange/polyTopoChangeI.H
  polyTopoChange/polyTopoChange/polyTopoChangeTemplates.C
  polyTopoChange/polyTopoChange/refinementData.H
  polyTopoChange/polyTopoChange/refinementDataI.H
  polyTopoChange/polyTopoChange/refinementDistanceData.H
  polyTopoChange/polyTopoChange/refinementDistanceDataI.H
  polyTopoChange/polyTopoChange/refinementHistory.H
  polyTopoChange/polyTopoChange/removeCells.H
  polyTopoChange/polyTopoChange/removeFaces.H
  polyTopoChange/polyTopoChange/removeObject/polyRemoveCell.H
  polyTopoChange/polyTopoChange/removeObject/polyRemoveFace.H
  polyTopoChange/polyTopoChange/removeObject/polyRemovePoint.H
  polyTopoChange/polyTopoChange/removePoints.H
  polyTopoChange/polyTopoChange/topoAction/topoAction.H
  polyTopoChange/polyTopoChanger/polyTopoChanger.H
  polyTopoChange/repatchPolyTopoChanger/repatchPolyTopoChanger.H
  setUpdater/setUpdater.H
  setUpdater/setUpdaterTemplates.C
  slidingInterface/enrichedPatch/enrichedPatch.H
  slidingInterface/slidingInterface.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
