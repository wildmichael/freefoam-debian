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

# - Find ccmio
#
# This module looks for ccmio support and defines the following values
#  CCMIO_FOUND        TRUE if ccmio has been found
#  CCMIO_INCLUDE_DIRS the include path for ccmio
#  CCMIO_LIBRARIES    the libraries to link against

find_path(CCMIO_INCLUDE_DIR libccmio/ccmio.h)

find_library(CCMIO_LIBRARY
  NAMES ccmio
  )

set(CCMIO_INCLUDE_DIRS ${CCMIO_INCLUDE_DIR})
set(CCMIO_LIBRARIES ${CCMIO_LIBRARY})

mark_as_advanced(
  CCMIO_INCLUDE_DIR
  CCMIO_LIBRARY
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Ccmio
  DEFAULT_MSG
  CCMIO_LIBRARY
  CCMIO_INCLUDE_DIR
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
