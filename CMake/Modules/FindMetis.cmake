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

# - Find metis
#
# This module looks for metis support and defines the following values
#  METIS_FOUND          TRUE if metis has been found
#  METIS_INCLUDE_DIRS   include path for metis
#  METIS_LIBRARIES      libraries to link against
#  METIS_FROM_PARMETIS  TRUE if the metis library is from ParMetis
#  METIS_COMPILE_FLAGS  compile-flags for metis
#  METIS_LINK_FLAGS     linker-flags for metis
#  METIS_NEW_API        TRUE if the new API introduced in 5.0rc1 is present

find_path(METIS_INCLUDE_DIR metis.h
  PATH_SUFFIXES metis
  )

find_library(METIS_LIBRARY
  NAMES metis
  )

set(METIS_INCLUDE_DIRS ${METIS_INCLUDE_DIR} ${MPI_INCLUDE_PATH})
set(METIS_LIBRARIES ${METIS_LIBRARY})

# now check whether that metis.h comes from ParMetis
set(METIS_FROM_PARMETIS FALSE)
find_package(ParMetis QUIET)
if(PARMETIS_FOUND)
  include(CheckSymbolExists)
  set(CMAKE_REQUIRED_INCLUDES ${METIS_INCLUDE_DIRS})
  set(CMAKE_REQUIRED_LIBRARIES ${PARMETIS_LIBRARIES})
  set(CMAKE_REQUIRED_FLAGS ${PARMETIS_COMPILE_FLAGS})
  # by checking whether metis.h include parmetis.h
  check_symbol_exists(PARMETIS_MAJOR_VERSION metis.h METIS_FROM_PARMETIS)

  if(METIS_FROM_PARMETIS)
    message(STATUS "NOTE: Metis is provided by ParMetis")
    find_package(MPI REQUIRED)
    list(APPEND METIS_INCLUDE_DIRS ${MPI_INCLUDE_PATH})
    list(APPEND METIS_LIBRARIES ${MPI_LIBRARIES})
    set(METIS_COMPILE_FLAGS ${MPI_COMPILE_FLAGS})
    set(METIS_LINK_FLAGS ${MPI_LINK_FLAGS})
  endif()
endif()

# now check whether the Metis found has the new API
if(METIS_INCLUDE_DIR AND METIS_LIBRARY)
  include(CheckFunctionExists)
  set(CMAKE_REQUIRED_INCLUDES ${METIS_INCLUDE_DIRS})
  set(CMAKE_REQUIRED_LIBRARIES ${METIS_LIBRARIES})
  set(CMAKE_REQUIRED_FLAGS ${METIS_COMPILE_FLAGS})
  check_function_exists(METIS_WPartGraphRecursive HAVE_METIS_WPARTGRAPHRECURSIVE)

  if(HAVE_METIS_WPARTGRAPHRECURSIVE)
    set(METIS_NEW_API FALSE)
  else()
    set(METIS_NEW_API TRUE)
  endif()
endif()

mark_as_advanced(
  METIS_INCLUDE_DIR
  METIS_LIBRARY
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Metis
  DEFAULT_MSG
  METIS_LIBRARY
  METIS_INCLUDE_DIR
  )

set(CMAKE_REQUIRED_FLAGS)
set(CMAKE_REQUIRED_LIBRARIES)
set(CMAKE_REQUIRED_INCLUDES)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
