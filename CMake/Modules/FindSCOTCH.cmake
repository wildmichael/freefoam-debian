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

# - Find SCOTCH
#
# Scotch provides two different error-handling libraries. By setting
# SCOTCH_USE_ERREXIT to TRUE the variable SCOTCH_LIBRARIES will contain the
# scotcherrexit library, otherwise the scotcherr library is used.
#
# This module looks for SCOTCH support and defines the following values
#  SCOTCH_FOUND                 TRUE if SCOTCH has been found
#  SCOTCH_INCLUDE_DIRS          the include path for SCOTCH
#  SCOTCH_scotch_LIBRARY        the scotch library (cached)
#  SCOTCH_scotcherr_LIBRARY     the error handling library (cached)
#  SCOTCH_scotcherrexit_LIBRARY the alternative error handling library (cached)
#  SCOTCH_LIBRARIES             the libraries to link against.

find_path(SCOTCH_INCLUDE_DIR scotch.h PATH_SUFFIXES scotch)

find_library(SCOTCH_scotch_LIBRARY
  NAMES scotch
  )

find_library(SCOTCH_scotcherr_LIBRARY
  NAMES scotcherr
  )

find_library(SCOTCH_scotcherrexit_LIBRARY
  NAMES scotcherrexit
  )

set(SCOTCH_INCLUDE_DIRS ${SCOTCH_INCLUDE_DIR})
set(SCOTCH_LIBRARIES ${SCOTCH_scotch_LIBRARY})
if(SCOTCH_USE_ERREXIT)
  list(APPEND SCOTCH_LIBRARIES ${SCOTCH_scotcherrexit_LIBRARY})
endif()

# detect whether we have scotch or ptscotch (MPI version)
if(SCOTCH_INCLUDE_DIR)
  file(READ ${SCOTCH_INCLUDE_DIR}/scotch.h _SCOTCH_contents)
  if(_SCOTCH_contents MATCHES ".*#define[ \t]+SCOTCH_PTSCOTCH.*")
    find_package(MPI REQUIRED)
    list(APPEND SCOTCH_INCLUDE_DIRS ${MPI_INCLUDE_PATH})
    list(APPEND SCOTCH_LIBRARIES ${MPI_LIBRARIES})
  endif()
endif()

mark_as_advanced(
  SCOTCH_INCLUDE_DIR
  SCOTCH_scotch_LIBRARY
  SCOTCH_scotcherr_LIBRARY
  SCOTCH_scotcherrexit_LIBRARY
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SCOTCH
  DEFAULT_MSG
  SCOTCH_scotch_LIBRARY
  SCOTCH_scotcherr_LIBRARY
  SCOTCH_scotcherrexit_LIBRARY
  SCOTCH_INCLUDE_DIR
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
