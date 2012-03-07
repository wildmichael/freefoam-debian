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

# - Find MGRIDGEN
#
# This module looks for MGRIDGEN support and defines the following values
#  MGRIDGEN_FOUND        TRUE if MGRIDGEN has been found
#  MGRIDGEN_INCLUDE_DIRS include path for MGRIDGEN
#  MGRIDGEN_LIBRARIES    the libraries to link against
#  MGRIDGEN_DEFINITIONS  definitions required to compile with MGRIDGEN
#
# If you want the single-precision (float) libraries, set MGRIDGEN_USE_REAL
# to ON and use MGRIDGEN_DEFINITIONS in add_definitions. The module assumes
# that the library name is suffixed with _single, i.e. is mgrid_single.
# If your system uses a different name, you can define the variable
# MGRIDGEN_mgrid_NAME before calling this module (both, with MGRIDGEN_USE_REAL
# set and unset).

if(NOT DEFINED MGRIDGEN_mgrid_NAME)
  if(MGRIDGEN_USE_REAL)
    set(_mgrid_SUFFIX "_single")
  else()
    set(_mgrid_SUFFIX)
  endif()
  set(MGRIDGEN_mgrid_NAME mgrid${_mgrid_SUFFIX})
endif()

if(MGRIDGEN_USE_REAL)
  set(MGRIDGEN_DEFINITIONS "-DTYPE_REAL")
else()
  set(MGRIDGEN_DEFINITIONS)
endif()

find_path(MGRIDGEN_INCLUDE_DIR mgridgen.h)

find_library(MGRIDGEN_LIBRARY
  NAMES ${MGRIDGEN_mgrid_NAME}
  )

set(MGRIDGEN_INCLUDE_DIRS ${MGRIDGEN_INCLUDE_DIR})
set(MGRIDGEN_LIBRARIES ${MGRIDGEN_LIBRARY})

mark_as_advanced(
  MGRIDGEN_INCLUDE_DIR
  MGRIDGEN_LIBRARY
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MGRIDGEN
  DEFAULT_MSG
  MGRIDGEN_LIBRARY
  MGRIDGEN_INCLUDE_DIR
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
