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

set(ASCIIDOC_SRCS
  UserGuide.txt
  introduction.txt
  preface.txt
  fdl.txt
  bibliography.txt
  tutorials/cavity.txt
  tutorials/index.txt
  tutorials/plateHole.txt
  tutorials/damBreak.txt
  applications/index.txt
  applications/language.txt
  applications/compiling.txt
  applications/running.txt
  applications/running-parallel.txt
  applications/solvers.txt
  applications/utilities.txt
  applications/libraries.txt
  cases/index.txt
  cases/structure.txt
  cases/basic-file-format.txt
  cases/controlDict.txt
  cases/fvSchemes.txt
  cases/fvSolution.txt
  mesh/index.txt
  mesh/description.txt
  mesh/boundaries.txt
  mesh/blockMesh.txt
  mesh/snappyHexMesh.txt
  mesh/conversion.txt
  mesh/mapFields.txt
  postProcessing/index.txt
  postProcessing/para.txt
  postProcessing/fluent.txt
  postProcessing/fieldview.txt
  postProcessing/ensight.txt
  postProcessing/sample.txt
  postProcessing/monitoring.txt
  models/index.txt
  models/thermophysical.txt
  models/turbulence.txt
  )

set(ASY_SRCS
  images/intro_structure.asy
  images/tut_ico_cavity_block.asy
  images/tut_ico_cavity_geometry.asy
  images/tut_ico_cavity_paraFoamCavityGraphParameters.asy
  images/tut_ico_cavity_paraFoamCavityMesh.asy
  images/tut_ico_cavity_paraFoamCavityPContourDisplay.asy
  images/tut_ico_cavity_paraFoamCavityGlyphParameters.asy
  images/tut_ico_cavity_paraFoamCavityStreamTracerParameters.asy
  images/tut_ico_cavityGrade_block.asy
  images/tut_plateHole_block.asy
  images/tut_plateHole_geometry.asy
  images/tut_plateHole_sigmaxx.asy
  images/tut_plateHole_sigmaxx_profile.asy
  images/tut_damBreak_geometry.asy
  images/tut_damBreak_initial.asy
  images/tut_damBreak_snapshot_1.asy
  images/tut_damBreak_snapshot_2.asy
  images/tut_damBreakFine_snapshot_1.asy
  images/tut_damBreakFine_snapshot_2.asy
  images/app_compiling.asy
  images/app_directoryStructure.asy
  images/case_directoryStructure.asy
  images/mesh_faceNumbering.asy
  images/mesh_hexNumbering.asy
  images/mesh_wedgeNumbering.asy
  images/mesh_prismNumbering.asy
  images/mesh_pyrNumbering.asy
  images/mesh_tetNumbering.asy
  images/mesh_tetWedgeNumbering.asy
  images/mesh_patchAttributes.asy
  images/mesh_wedgeGeometry.asy
  images/mesh_cyclicGeometry.asy
  images/mesh_block.asy
  images/mesh_edgeGrading.asy
  images/mesh_overlappingPatches.asy
  images/mesh_wedgeBlock.asy
  images/mesh_snappyHexMeshBlockMesh.asy
  images/mesh_snappyHexMeshCellRemoval.asy
  images/mesh_snappyHexMeshCellSplittingFeatures.asy
  images/mesh_snappyHexMeshCellSplittingRegion.asy
  images/mesh_snappyHexMeshCellSplittingSurface.asy
  images/mesh_snappyHexMeshDescription.asy
  images/mesh_snappyHexMeshLayers.asy
  images/mesh_snappyHexMeshSnapping.asy
  images/mesh_mappingInconsistentFields.asy
  images/post_parametersPanel.asy
  images/post_displayPanel.asy
  images/post_paraviewToolbars.asy
  images/post_UxResidual.asy
  )

set(IMAGES
  images/tut_ico_cavity_paraFoamCavityGraphParameters_snapshot.png
  images/tut_ico_cavity_paraFoamCavityMesh_snapshot.png
  images/tut_ico_cavity_pcell_icon.png
  images/tut_ico_cavity_pnode_icon.png
  images/tut_ico_cavity_paraFoamCavityPContourDisplay_snapshot.png
  images/tut_ico_cavity_pressureCavity.png
  images/tut_ico_cavity_paraFoamCavityGlyphParameters_snapshot.png
  images/tut_ico_cavity_velocityCavity.png
  images/tut_ico_cavity_paraFoamCavityStreamTracerParameters_snapshot.png
  images/tut_ico_cavity_streamlinesCavity.png
  images/tut_ico_cavity_paraFoamCavityGraph.png
  images/tut_ico_cavityClipped_velocityCavityClipped.png
  images/tut_ico_cavityClipped_velocityCavityClippedFinal.png
  images/tut_plateHole_bar.png
  images/tut_plateHole_field.png
  images/tut_plateHole_mesh.png
  images/tut_damBreakFine_mesh_proc1.png
  images/tut_damBreakFine_bar.png
  images/tut_damBreakFine_snapshot_field_1.png
  images/tut_damBreakFine_snapshot_field_2.png
  images/tut_damBreak_bar.png
  images/tut_damBreak_initial_field.png
  images/tut_damBreak_snapshot_field_1.png
  images/tut_damBreak_snapshot_field_2.png
  images/post_displayPanel-snapshot.png
  images/post_paraFoamOpen.png
  images/post_parametersPanel-snapshot.png
  images/post_paraviewToolbars-snapshot.png
  )

set(XY_SRCS
  images/tut_plateHole_leftPatch_sigmaxx.xy
  images/post_Ux_0
  )

set(_ICO_CAVITY "${CMAKE_SOURCE_DIR}/tutorials/incompressible/icoFoam/cavity")
set(_ICO_CAVITYGRADE
  "${CMAKE_SOURCE_DIR}/tutorials/incompressible/icoFoam/cavityGrade")
set(_PISO_CAVITYGRADE
  "${CMAKE_SOURCE_DIR}/tutorials/incompressible/icoFoam/cavityGrade")
set(_PISO_CAVITY
  "${CMAKE_SOURCE_DIR}/tutorials/incompressible/pisoFoam/ras/cavity")
set(_ICO_CAVITYCLIPPED
  "${CMAKE_SOURCE_DIR}/tutorials/incompressible/icoFoam/cavityClipped")
set(_SOLIDDISPLACEMENT_PLATEHOLE
  "${CMAKE_SOURCE_DIR}/tutorials/stressAnalysis/solidDisplacementFoam/plateHole")
set(_INTER_DAMBREAK
  "${CMAKE_SOURCE_DIR}/tutorials/multiphase/interFoam/laminar/damBreak")
set(_SIMPLEWIND
  "${CMAKE_SOURCE_DIR}/tutorials/incompressible/simpleWindFoam/simpleWindFoam")
set(COPY_SRCS
  "images/tut_plateHole_leftPatch_sigmaxx.xy=>images"
  "images/tut_damBreak_commonDamBreak.asy=>images"
  "images/tut_damBreak_commonDamBreak.asy=>images"
  "${_ICO_CAVITY}/constant/polyMesh/blockMeshDict=>tutorials/assets/ico_cavity"
  "${_ICO_CAVITY}/0/p=[17:-2]>tutorials/assets/ico_cavity"
  "${_ICO_CAVITY}/constant/transportProperties=[17:-2]>tutorials/assets/ico_cavity"
  "${_ICO_CAVITY}/system/controlDict=[17:-2]>tutorials/assets/ico_cavity"
  "${_ICO_CAVITYGRADE}/constant/polyMesh/blockMeshDict=[17:-2]>tutorials/assets/ico_cavityGrade"
  "${_PISO_CAVITY}/0/nut=[17:-2]>tutorials/assets/piso_cavity"
  "${_PISO_CAVITY}/constant/turbulenceProperties=[17:-2]>tutorials/assets/piso_cavity"
  "${_ICO_CAVITYCLIPPED}/constant/polyMesh/blockMeshDict=[17:-2]>tutorials/assets/ico_cavityClipped"
  "${_SOLIDDISPLACEMENT_PLATEHOLE}/constant/polyMesh/blockMeshDict=[17:-2]>tutorials/assets/plateHole"
  "${_SOLIDDISPLACEMENT_PLATEHOLE}/0/D=[17:-2]>tutorials/assets/plateHole"
  "${_SOLIDDISPLACEMENT_PLATEHOLE}/system/controlDict=[17:-2]>tutorials/assets/plateHole"
  "${_SOLIDDISPLACEMENT_PLATEHOLE}/system/fvSchemes=[17:-2]>tutorials/assets/plateHole"
  "${_SOLIDDISPLACEMENT_PLATEHOLE}/system/fvSolution=[17:-2]>tutorials/assets/plateHole"
  "${_SOLIDDISPLACEMENT_PLATEHOLE}/system/sampleDict=[17:-2]>tutorials/assets/plateHole"
  "${_INTER_DAMBREAK}/constant/polyMesh/blockMeshDict=[17:-2]>tutorials/assets/damBreak"
  "${_INTER_DAMBREAK}/system/setFieldsDict=[17:-2]>tutorials/assets/damBreak"
  "${_INTER_DAMBREAK}/constant/g=[17:-2]>tutorials/assets/damBreak"
  "${_INTER_DAMBREAK}/constant/turbulenceProperties=[17:-2]>tutorials/assets/damBreak"
  "${_INTER_DAMBREAK}/system/controlDict=[17:-2]>tutorials/assets/damBreak"
  "${_INTER_DAMBREAK}/system/fvSchemes=[17:-2]>tutorials/assets/damBreak"
  "${_INTER_DAMBREAK}/system/fvSolution=[17:-2]>tutorials/assets/damBreak"
  "${_SIMPLEWIND}/simpleWindFoam.C=[50:-3]>applications/assets"
  "${_INTER_DAMBREAK}/system/decomposeParDict=[17:-2]>applications/assets"
  "images/mesh_snappyHexMeshCommon.asy=>images"
  "images/post_Ux_0=>images"
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
