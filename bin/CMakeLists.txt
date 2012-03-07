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

# make sure that .py.in is stripped on non-Windows platforms
if(NOT WIN32)
  set(FOAM_STRIP_SUFFIXES "\\.py$" "\\.in$")
endif()

# configure the freefoam script for build and install tree
foam_configure_files(installFreefoam
  DESTDIR bin
  "freefoam.py.in==${LOWER_PROJECT_NAME}.py"
  )

# configure the utility scripts for build tree and the install tree
foam_configure_files(installScripts
  DESTDIR libexec/FreeFOAM/${FOAM_VERSION_FULL}
  "freefoam-clearPolyMesh.py.in==${FOAM_EXE_PREFIX}clearPolyMesh.py"
  "freefoam-copySettings.py.in==${FOAM_EXE_PREFIX}copySettings.py"
  "freefoam-graphExecTime.py.in==${FOAM_EXE_PREFIX}graphExecTime.py"
  "freefoam-graphResKE.py.in==${FOAM_EXE_PREFIX}graphResKE.py"
  "freefoam-graphResUVWP.py.in==${FOAM_EXE_PREFIX}graphResUVWP.py"
  "freefoam-job.py.in==${FOAM_EXE_PREFIX}job.py"
  "freefoam-log.py.in==${FOAM_EXE_PREFIX}log.py"
  "freefoam-solverSweeps.py.in==${FOAM_EXE_PREFIX}solverSweeps.py"
  )

foam_configure_files(installPFScript
  DESTDIR libexec/FreeFOAM/${FOAM_VERSION_FULL}
  "freefoam-para.py.in==${FOAM_EXE_PREFIX}para.py"
  )
list(APPEND buildScripts ${buildPFScript})
list(APPEND installScripts ${installPFScript})

# install the scripts
install(PROGRAMS
  ${installFreefoam}
  DESTINATION ${FOAM_INSTALL_BIN_PATH}
  COMPONENT bin
  )

install(PROGRAMS
  ${installScripts}
  DESTINATION ${FOAM_INSTALL_LIBEXEC_PATH}
  COMPONENT bin
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
