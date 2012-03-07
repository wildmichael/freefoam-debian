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

# - Find Readline
#
# This module looks for readline support and defines the following values
#  READLINE_FOUND          TRUE if readline has been found
#  READLINE_INCLUDE_DIRS   include path for readline
#  READLINE_LIBRARIES      libraries to link against
#
# This module also checks whether linking against the readline library needs
# (n)curses or termcap and offers the user the choice between them with the
# variable READLINE_USE_CURSES. The default is OFF (use termcap).

include(CheckCSourceCompiles)

find_path(READLINE_INCLUDE_DIR readline/readline.h)
find_library(READLINE_LIBRARY readline)

mark_as_advanced(
  READLINE_INCLUDE_DIR
  READLINE_LIBRARY
  )

set(_READLINE_VARS READLINE_LIBRARY READLINE_INCLUDE_DIR READLINE_WORKS)

if(READLINE_INCLUDE_DIR AND READLINE_LIBRARY)
  set(READLINE_INCLUDE_DIRS "${READLINE_INCLUDE_DIR}")
  set(READLINE_LIBRARIES "${READLINE_LIBRARY}")

  # check whether it needs to be linked against curses or termcap
  set(_fr_CMAKE_REQUIRED_FLAGS_bak "${CMAKE_REQUIRED_FLAGS}")
  set(_fr_CMAKE_REQUIRED_DEFINITIONS_bak "${CMAKE_REQUIRED_DEFINITIONS}")
  set(_fr_CMAKE_REQUIRED_INCLUDES_bak "${CMAKE_REQUIRED_INCLUDES}")
  set(_fr_CMAKE_REQUIRED_LIBRARIES_bak "${CMAKE_REQUIRED_LIBRARIES}")

  set(CMAKE_REQUIRED_FLAGS)
  set(CMAKE_REQUIRED_DEFINITIONS)
  set(CMAKE_REQUIRED_INCLUDES "${READLINE_INCLUDE_DIR}")
  set(CMAKE_REQUIRED_LIBRARIES "${READLINE_LIBRARY}")
  set(READLINE_WORKS TRUE)
  check_c_source_compiles("int main(){return 0;}" _READLINE_WORKS_STANDALONE)

  if(NOT _READLINE_WORKS_STANDALONE)
    set(READLINE_WORKS FALSE)
    option(READLINE_USE_CURSES
      "Use the curses library instead of the termcap library" OFF)
    mark_as_advanced(READLINE_USE_CURSES)
    if(READLINE_USE_CURSES)
      find_package(Curses REQUIRED)
      list(APPEND _READLINE_VARS CURSES_FOUND)
      # check whether it works with curses
      if(CURSES_FOUND)
        set(CMAKE_REQUIRED_LIBRARIES "${READLINE_LIBRARY};${CURSES_LIBRARIES}")
        check_c_source_compiles("int main(){return 0;}" _READLINE_WORKS_WITH_CURSES)
        if(_READLINE_WORKS_WITH_CURSES)
          set(READLINE_WORKS TRUE)
          list(APPEND READLINE_LIBRARIES "${CURSES_LIBRARIES}")
        endif()
      endif()
    else()
      find_library(TERMCAP_LIBRARY termcap)
      mark_as_advanced(TERMCAP_LIBRARY)
      list(APPEND _READLINE_VARS TERMCAP_LIBRARY)
      # check whether it works with termcap
      if(TERMCAP_LIBRARY)
        set(CMAKE_REQUIRED_LIBRARIES "${READLINE_LIBRARY};${TERMCAP_LIBRARY}")
        check_c_source_compiles("int main(){return 0;}" _READLINE_WORKS_WITH_TERMCAP)
        if(_READLINE_WORKS_WITH_TERMCAP)
          set(READLINE_WORKS TRUE)
          list(APPEND READLINE_LIBRARIES "${TERMCAP_LIBRARY}")
        endif()
      endif()
    endif()
  endif()
  set(CMAKE_REQUIRED_FLAGS "${_fr_CMAKE_REQUIRED_FLAGS_bak}")
  set(CMAKE_REQUIRED_DEFINITIONS "${_fr_CMAKE_REQUIRED_DEFINITIONS_bak}")
  set(CMAKE_REQUIRED_INCLUDES "${_fr_CMAKE_REQUIRED_INCLUDES_bak}")
  set(CMAKE_REQUIRED_LIBRARIES "${_fr_CMAKE_REQUIRED_LIBRARIES_bak}")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Readline DEFAULT_MSG ${_READLINE_VARS})

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
