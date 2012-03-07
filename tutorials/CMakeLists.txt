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

file(RELATIVE_PATH TUTORIAL_DIR ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})

# make sure that the right suffixes get stripped
if(NOT WIN32)
  set(FOAM_STRIP_SUFFIXES "\\.py\\.in$" "\\.in$")
endif()

foam_configure_files(installScriptFiles
  DESTDIR ${TUTORIAL_DIR}
  Allrun.py.in
  )

foam_install_configured_files(PROGRAMS ${installScriptFiles}
  DESTINATION ${FOAM_INSTALL_TUTORIALS_PATH}
  COMPONENT tutorials
  )

add_subdirectory(DNS/dnsFoam)
add_subdirectory(basic/laplacianFoam)
add_subdirectory(basic/potentialFoam)
add_subdirectory(basic/scalarTransportFoam)
add_subdirectory(combustion/XiFoam)
add_subdirectory(combustion/dieselFoam)
add_subdirectory(combustion/engineFoam)
add_subdirectory(combustion/reactingFoam)
add_subdirectory(combustion/fireFoam)
add_subdirectory(compressible/rhoCentralFoam)
add_subdirectory(compressible/rhoPimpleFoam)
add_subdirectory(compressible/rhoPorousMRFPimpleFoam)
add_subdirectory(compressible/rhoPisoFoam)
add_subdirectory(compressible/rhoPorousSimpleFoam)
add_subdirectory(compressible/sonicFoam)
add_subdirectory(compressible/sonicLiquidFoam)
add_subdirectory(discreteMethods/dsmcFoam)
add_subdirectory(discreteMethods/molecularDynamics/mdEquilibrationFoam)
add_subdirectory(discreteMethods/molecularDynamics/mdFoam)
add_subdirectory(electromagnetics/electrostaticFoam)
add_subdirectory(electromagnetics/mhdFoam)
add_subdirectory(financial/financialFoam)
add_subdirectory(heatTransfer/buoyantPimpleFoam)
add_subdirectory(heatTransfer/buoyantSimpleFoam)
add_subdirectory(heatTransfer/buoyantSimpleRadiationFoam)
add_subdirectory(heatTransfer/buoyantBoussinesqPimpleFoam)
add_subdirectory(heatTransfer/buoyantBoussinesqSimpleFoam)
add_subdirectory(heatTransfer/chtMultiRegionFoam)
add_subdirectory(heatTransfer/chtMultiRegionSimpleFoam)
add_subdirectory(incompressible/MRFSimpleFoam)
add_subdirectory(incompressible/SRFPimpleFoam)
add_subdirectory(incompressible/boundaryFoam)
add_subdirectory(incompressible/channelFoam)
add_subdirectory(incompressible/icoFoam)
add_subdirectory(incompressible/nonNewtonianIcoFoam)
add_subdirectory(incompressible/pimpleFoam)
add_subdirectory(incompressible/pimpleDyMFoam)
add_subdirectory(incompressible/pisoFoam)
add_subdirectory(incompressible/shallowWaterFoam)
add_subdirectory(incompressible/simpleFoam)
add_subdirectory(incompressible/simpleSRFFoam)
add_subdirectory(incompressible/simpleWindFoam)
add_subdirectory(incompressible/porousSimpleFoam)
add_subdirectory(lagrangian/rhoPisoTwinParcelFoam)
add_subdirectory(lagrangian/coalChemistryFoam)
add_subdirectory(lagrangian/porousExplicitSourceReactingParcelFoam)
add_subdirectory(lagrangian/reactingParcelFoam)
add_subdirectory(mesh/moveDynamicMesh)
add_subdirectory(mesh/snappyHexMesh)
add_subdirectory(multiphase/MRFInterFoam)
add_subdirectory(multiphase/bubbleFoam)
add_subdirectory(multiphase/cavitatingFoam)
add_subdirectory(multiphase/compressibleInterFoam)
add_subdirectory(multiphase/interDyMFoam)
add_subdirectory(multiphase/interFoam)
add_subdirectory(multiphase/interPhaseChangeFoam)
add_subdirectory(multiphase/multiphaseInterFoam)
add_subdirectory(multiphase/MRFMultiphaseInterFoam)
add_subdirectory(multiphase/settlingFoam)
add_subdirectory(multiphase/twoPhaseEulerFoam)
add_subdirectory(multiphase/interMixingFoam)
add_subdirectory(stressAnalysis/solidDisplacementFoam)
add_subdirectory(stressAnalysis/solidEquilibriumDisplacementFoam)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
