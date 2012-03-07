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

set(noinstUitlsSrcs
  checkApi.py.in
  compareDeps.py.in
  generateOpenFOAMDeps.py.in
  postProcFreeFOAMDeps.py.in)

if(FOAM_HAVE_GIT)
  list(APPEND noinstUitlsSrcs checkVersionInfo.py.in)
endif()

foam_configure_files(noinstUtils
  DESTDIR data/utilities
  ${noinstUitlsSrcs})

if(NOT WIN32)
  set(FOAM_STRIP_SUFFIXES "\\.py\\.in$" "\\.in$")
endif()

# configure the utility scripts for build tree and the install tree
foam_configure_files(installDevUtils
  DESTDIR data/utilities
  doxyToX.py.in
  extractBrief.py.in
  foamNew.py.in
  foamPNGMathFilter.py.in
  wmakeToCMake.cmake.in
  )

if(CMAKE_SYSTEM_NAME STREQUAL SunOS)
  set(REPLACEALLSHELLSUN foamUpdateCaseFileHeader.in)
else()
  set(REPLACEALLSHELLSUN)
endif()

foam_configure_files(installBinUtils
  DESTDIR data/utilities
  foamUpdateCaseFileHeader.in

  COPYONLY
  ${REPLACEALLSHELLSUN}
  foamUpgradeTurbulenceProperties
  )

# install the utility scripts
install(PROGRAMS
  ${installBinUtils}
  DESTINATION ${FOAM_INSTALL_DATA_PATH}/utilities
  COMPONENT bin
  )

install(PROGRAMS
  ${installDevUtils}
  DESTINATION ${FOAM_INSTALL_DATA_PATH}/utilities
  COMPONENT dev
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
