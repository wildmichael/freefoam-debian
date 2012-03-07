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

foam_extract_brief_docs(${CMAKE_CURRENT_BINARY_DIR}/brief_app_doc.txt)

foam_queue_manpage(${FOAM_EXE_PREFIX}clearPolyMesh
  ${CMAKE_CURRENT_SOURCE_DIR}/clearPolyMesh.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}copySettings
  ${CMAKE_CURRENT_SOURCE_DIR}/copySettings.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}graphExecTime
  ${CMAKE_CURRENT_SOURCE_DIR}/graphExecTime.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}graphResKE
  ${CMAKE_CURRENT_SOURCE_DIR}/graphResKE.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}graphResUVWP
  ${CMAKE_CURRENT_SOURCE_DIR}/graphResUVWP.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}job
  ${CMAKE_CURRENT_SOURCE_DIR}/job.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}log
  ${CMAKE_CURRENT_SOURCE_DIR}/log.1.in.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}solverSweeps
  ${CMAKE_CURRENT_SOURCE_DIR}/solverSweeps.1.in.txt)
foam_queue_manpage(${LOWER_PROJECT_NAME}
  ${CMAKE_CURRENT_SOURCE_DIR}/freefoam.1.in.txt
  ${CMAKE_CURRENT_BINARY_DIR}/brief_app_doc.txt)
foam_queue_manpage(${FOAM_EXE_PREFIX}para
  ${CMAKE_CURRENT_SOURCE_DIR}/para.1.in.txt)

foam_create_manpages()

# ------------------------- vim: set ft=cmake sw=2 sts=2 et: --------------- end-of-file
