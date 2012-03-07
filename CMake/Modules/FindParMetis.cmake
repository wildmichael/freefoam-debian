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

# - Find ParMetis
#
# This module looks for ParMetis support and defines the following values
#  PARMETIS_FOUND          TRUE if ParMetis has been found
#  PARMETIS_INCLUDE_DIRS   include path for parmetis
#  PARMETIS_LIBRARIES      the libraries to link against
#  PARMETIS_COMPILE_FLAGS  compilation flags for ParMetis
#  PARMETIS_LINK_FLAGS     linking flags for ParMetis

find_path(PARMETIS_INCLUDE_DIR parmetis.h
  PATH_SUFFIXES "parmetis")

find_library(PARMETIS_parmetis_LIBRARY
  NAMES parmetis
  )

find_library(PARMETIS_metis_LIBRARY
  NAMES metis
  )

find_package(MPI REQUIRED)

set(PARMETIS_INCLUDE_DIRS ${PARMETIS_INCLUDE_DIR} ${MPI_INCLUDE_PATH})
set(PARMETIS_LIBRARIES ${PARMETIS_parmetis_LIBRARY} ${PARMETIS_metis_LIBRARY} ${MPI_LIBRARIES})
set(PARMETIS_COMPILE_FLAGS ${MPI_COMPILE_FLAGS})
set(PARMETIS_LINK_FLAGS ${MPI_LINK_FLAGS})

mark_as_advanced(
  PARMETIS_INCLUDE_DIR
  PARMETIS_parmetis_LIBRARY
  PARMETIS_metis_LIBRARY
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ParMetis
  DEFAULT_MSG
  PARMETIS_parmetis_LIBRARY
  PARMETIS_metis_LIBRARY
  PARMETIS_INCLUDE_DIR
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
