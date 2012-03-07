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

if(FOAM_DOCS_FOR_SF)
  set(FOAM_DOXYDOC_FOR_SF_BEGIN)
  set(FOAM_DOXYDOC_FOR_SF_END)
else()
  set(FOAM_DOXYDOC_FOR_SF_BEGIN "<!--")
  set(FOAM_DOXYDOC_FOR_SF_END "-->")
endif()

if(FOAM_DOCS_FOR_SF OR FOAM_ENABLE_XHTML_GUIDES)
  set(CONFIG_UG_BASE_URL ..)
else()
  set(CONFIG_UG_BASE_URL
    "http://freefoam.sourceforge.net/doc/v${FOAM_VERSION_FULL}")
endif()

if(FOAM_DOCS_FOR_SF OR FOAM_ENABLE_XHTML_HELP)
  set(CONFIG_MAN_BASE_URL ..)
else()
  set(CONFIG_MAN_BASE_URL
    "http://freefoam.sourceforge.net/doc/v${FOAM_VERSION_FULL}")
endif()

if(FOAM_DOCS_FOR_SF OR FOAM_ENABLE_XHTML_HELP OR FOAM_ENABLE_XHTML_GUIDES)
  set(CONFIG_DOC_BASE_URL ..)
else()
  set(CONFIG_DOC_BASE_URL
    "http://freefoam.sourceforge.net/doc/v${FOAM_VERSION_FULL}")
endif()

foam_configure_files(noInstallFiles
  DESTDIR doc/Doxygen
  FoamHeader.html.in
  COPYONLY
  FoamFooter.html
  DoxygenLayout.xml
  )

foam_generate_doxygen()

configure_file(Doxyfile.in "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile" @ONLY)
configure_file(filter.py.in "${CMAKE_CURRENT_BINARY_DIR}/filter.py" @ONLY)
configure_file(fixupDoxygen.py.in
  "${CMAKE_CURRENT_BINARY_DIR}/fixupDoxygen.py" @ONLY)

set(DOXYDOC_OUTPUT
  ${CMAKE_CURRENT_BINARY_DIR}/../html/API/index.html
  ${CMAKE_CURRENT_BINARY_DIR}/../html/API/pages.html
  ${CMAKE_CURRENT_BINARY_DIR}/../html/API/namespaces.html
  ${CMAKE_CURRENT_BINARY_DIR}/../html/API/classes.html
  ${CMAKE_CURRENT_BINARY_DIR}/../html/API/files.html
  ${CMAKE_CURRENT_BINARY_DIR}/../html/API/dirs.html
  )

set(DOXYGEN_CMD_STRING
  COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
  COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/fixupDoxygen.py
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Generating Doxygen documentation"
  VERBATIM
  )

add_custom_command(OUTPUT ${DOXYDOC_OUTPUT}
  ${DOXYGEN_CMD_STRING}
  )

# this one runs only once (or after a clean)
add_custom_target(apidoc-all ALL
  DEPENDS ${DOXYDOC_OUTPUT}
  )
add_dependencies(doc apidoc-all)

# this one runs everytime the user calls it (for manual update)
add_custom_target(apidoc
  ${DOXYGEN_CMD_STRING}
  )

# depend on version_check if enabled
if(FOAM_HAVE_GIT)
  add_dependencies(apidoc-all version_check)
  add_dependencies(apidoc version_check)
endif()

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../html/API
  DESTINATION ${FOAM_INSTALL_DOC_PATH} COMPONENT apidoc
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
