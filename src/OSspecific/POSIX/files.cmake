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

list(APPEND SRCS
  signals/sigFpeImpl.C
  signals/sigSegvImpl.C
  signals/sigIntImpl.C
  signals/sigQuitImpl.C
  regExp.C
  timer.C
  fileStat.C
  POSIX.C
  cpuTime/cpuTimeImpl.C
  clockTime/clockTimeImpl.C
  )

# only use printStack.C if we have a GCC compiler, are in Debug build type
# and have execinfo.h and cxxabi.h
if(CMAKE_COMPILER_IS_GNUCXX AND CMAKE_BUILD_TYPE STREQUAL Debug AND EXECINFO_FOUND)
  list(APPEND SRCS printStack.C)
else()
  list(APPEND SRCS dummyPrintStack.C)
endif()

list(APPEND HDRS regExp.H)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
