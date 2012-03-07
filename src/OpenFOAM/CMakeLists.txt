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

if(FOAM_HAVE_GIT)
  if(FOAM_VERSION_CHECK_WARN_ONLY)
    set(_CHECK_VERSION_INFO_ARGS --warn)
  else()
    set(_CHECK_VERSION_INFO_ARGS)
  endif()
  add_custom_target(configure_global_C
    COMMAND "${CMAKE_COMMAND}"
      -P "${CMAKE_BINARY_DIR}/CMake/ConfigureGlobalC.cmake"
      DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/global/global.C.in"
    COMMENT "Generating src/OpenFOAM/global/global.C"
    VERBATIM)
  set_source_files_properties("${CMAKE_CURRENT_BINARY_DIR}/global/global.C"
    PROPERTIES GENERATED TRUE)
  add_dependencies(version_check configure_global_C)
else()
  configure_file(global/global.C.in
    "${CMAKE_CURRENT_BINARY_DIR}/global/global.C" @ONLY)
endif()

include_directories(${ZLIB_INCLUDE_DIR} "${CMAKE_CURRENT_SOURCE_DIR}")

foam_add_library(OpenFOAM)

foam_target_link_libraries(OpenFOAM
  OSspecific
  ${ZLIB_LIBRARIES}
  ${CMAKE_DL_LIBS}
  )

foam_install_targets(OpenFOAM)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
