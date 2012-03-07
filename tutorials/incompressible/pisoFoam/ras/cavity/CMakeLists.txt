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

foam_configure_files(installScriptFiles DESTDIR ${TUTORIAL_DIR}
  Allrun.py.in
  )

foam_configure_files(installFiles DESTDIR ${TUTORIAL_DIR}
  COPYONLY
  0/R
  0/U
  0/epsilon
  0/k
  0/nuTilda
  0/p
  0/nut
  constant/RASProperties
  constant/turbulenceProperties
  constant/transportProperties
  constant/polyMesh/blockMeshDict
  constant/polyMesh/boundary
  system/controlDict
  system/fvSchemes
  system/fvSolution
  )

install(PROGRAMS ${installScriptFiles}
  DESTINATION ${FOAM_INSTALL_TUTORIALS_PATH}/${TUTORIAL_DIR}
  COMPONENT tutorials
  )

foam_install_configured_files(FILES ${installFiles}
  DESTINATION ${FOAM_INSTALL_TUTORIALS_PATH}
  COMPONENT tutorials
  )

foam_add_tutorial_tests()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
