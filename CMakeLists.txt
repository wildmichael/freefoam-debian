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

cmake_minimum_required(VERSION 2.8.2 FATAL_ERROR)

project(FreeFOAM)

string(TOLOWER "${PROJECT_NAME}" LOWER_PROJECT_NAME)

# version information
set(FOAM_VERSION_MAJOR 0)
set(FOAM_VERSION_MINOR 1)
set(FOAM_VERSION_PATCH 2)
set(FOAM_VERSION_SUFFIX)
set(FOAM_VERSION ${FOAM_VERSION_MAJOR}.${FOAM_VERSION_MINOR})
set(FOAM_VERSION_FULL
  ${FOAM_VERSION}.${FOAM_VERSION_PATCH}${FOAM_VERSION_SUFFIX})
set(FOAM_SOVERSION 1)
set(FOAM_UPSTREAM_VERSION_FULL 1.7.x-d08d3c2)

# set up custom cmake module path
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake/Modules)

# utilities
set(FOAM_CREATE_INCLUDE_WRAPPERS TRUE)
set(FOAM_HAS_FLEX_SOURCES TRUE)
set(FOAM_ENABLE_DOC_INDEX TRUE)
set(FOAM_EXPORT_NAMESPACE FOAM_)
include(${CMAKE_SOURCE_DIR}/CMake/FOAMUtilities.cmake)
include(${CMAKE_SOURCE_DIR}/CMake/FOAMThirdPartyUtilities.cmake)
include(${CMAKE_SOURCE_DIR}/CMake/FOAMInternal.cmake)
include(CTest)

# determine computer system
include(${CMAKE_SOURCE_DIR}/CMake/FOAMDetermineArch.cmake)

# select precision
foam_option(FOAM_DOUBLE_PRECISION "Double precision"
  "Compile ${PROJECT_NAME} with double precision floating point arithmetics."
  ON)
mark_as_advanced(FOAM_DOUBLE_PRECISION)
if(FOAM_DOUBLE_PRECISION)
  set(FOAM_PRECISION DP)
else()
  set(FOAM_PRECISION SP)
endif()

# select whether we want to build framewors on Mac OS X
if(APPLE)
  foam_option(FOAM_BUILD_FRAMEWORKS "Build frameworks"
    "Build frameworks on Mac OS X" OFF)
  mark_as_advanced(FOAM_BUILD_FRAMEWORKS)
else()
  set(FOAM_BUILD_FRAMEWORKS OFF)
endif()

# find python interpreter
find_package(PythonInterp REQUIRED)

# make sure we got Python version 2.4 or newer
foam_dependent_variables(PYTHON_EXECUTABLE PYTHON_VERSION)
if(NOT PYTHON_VERSION)
  foam_determine_python_version(PYTHON_VERSION ${PYTHON_EXECUTABLE})
  set(PYTHON_VERSION ${PYTHON_VERSION} CACHE INTERNAL "The Python version")
  if(PYTHON_VERSION VERSION_LESS 2.4.0)
    message(SEND_ERROR
      "Python version 2.4 or newer required (PYTHON_EXECUTABLE)")
  endif()
endif()
string(REGEX REPLACE "\\.[0-9]+$" "" PYTHON_SHORT_VERSION ${PYTHON_VERSION})

# find the installed ParaView executable
find_program(
  FOAM_PARAVIEW3_APP NAMES "ParaView 3.12.0" "ParaView 3.10.1"
  "ParaView 3.10.0" "ParaView 3.8.1" "ParaView 3.8.0" ParaView paraview
  DOC "Path to the ParaView 3.8 (or newer) application")
mark_as_advanced(FOAM_PARAVIEW3_APP)
foam_dependent_variables(FOAM_PARAVIEW3_APP FOAM_PARAVIEW3_VERSION)
if(FOAM_PARAVIEW3_APP)
  if(NOT FOAM_PARAVIEW3_VERSION)
    get_filename_component(_FOAM_PV3_BINDIR ${FOAM_PARAVIEW3_APP} PATH)
    set(_FOAM_PVBATCH_EXECUTABLE ${_FOAM_PV3_BINDIR}/pvbatch)
    if(NOT EXISTS ${_FOAM_PVBATCH_EXECUTABLE})
      set(_FOAM_PVBATCH_EXECUTABLE ${FOAM_PARAVIEW3_APP})
    endif()
    execute_process(COMMAND ${_FOAM_PVBATCH_EXECUTABLE} --version
      OUTPUT_VARIABLE _pv_version_output
      ERROR_VARIABLE _pv_version_output
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
    if(_pv_version_output MATCHES
        "(paraview version |ParaView)(([0-9]+\\.)+[0-9]+)")
      set(FOAM_PARAVIEW3_VERSION ${CMAKE_MATCH_2} CACHE INTERNAL
        "The ParaView version")
      message(STATUS
        "ParaView ${FOAM_PARAVIEW3_VERSION} found: ${FOAM_PARAVIEW3_APP}")
    else()
      message(SEND_ERROR
        "Failed to determine the ParaView version: ${_pv_version_output}")
    endif()
  endif()
  if(${FOAM_PARAVIEW3_VERSION} VERSION_LESS 3.8)
    message(WARNING
      "ParaView versions older than 3.8 might not be able\n"
      "to read ${PROJECT_NAME} cases.")
  endif()
else()
  message(WARNING
    "Failed to find the ParaView application")
  set(FOAM_PARAVIEW3_APP)
endif()

# we want shared libraries
set(BUILD_SHARED_LIBS SHARED)

# installation directories
foam_installation_path(FOAM_INSTALL_BIN_PATH bin "Executables"
  "Executables installation path")
if(APPLE AND FOAM_BUILD_FRAMEWORKS)
  foam_installation_path(FOAM_INSTALL_FRAMEWORK_PATH /Library/Frameworks
    "Frameworks" "Framework installation path")
endif()
foam_installation_path(FOAM_INSTALL_LIBRARY_PATH
  lib/${CMAKE_PROJECT_NAME}-${FOAM_VERSION_FULL}
  "Libraries" "Library installation path")
if(NOT WIN32)
  foam_installation_path(FOAM_INSTALL_PLUGIN_PATH
    "${FOAM_INSTALL_LIBRARY_PATH_ORIG}/plugins${FOAM_SOVERSION}"
    "Plugins" "Plugin installation path")
endif()
foam_installation_path(FOAM_INSTALL_LIBEXEC_PATH
  libexec/${CMAKE_PROJECT_NAME}-${FOAM_VERSION_FULL} "Private executables"
  "Installation path for executables not on PATH.")
foam_installation_path(FOAM_INSTALL_HEADER_PATH
  include/${CMAKE_PROJECT_NAME}-${FOAM_VERSION_FULL}
  "Headers" "Header installation path (not for frameworks)")
foam_installation_path(FOAM_INSTALL_CONFIG_PATH
  etc/${CMAKE_PROJECT_NAME}/${FOAM_VERSION_FULL} "Config files"
  "Configuration files installation path")
foam_installation_path(FOAM_INSTALL_DATA_PATH
  share/${CMAKE_PROJECT_NAME}-${FOAM_VERSION_FULL} "Data files"
  "Data files installation path")
foam_installation_path(FOAM_INSTALL_DOC_PATH
  share/doc/${CMAKE_PROJECT_NAME}-${FOAM_VERSION_FULL} "Documentation"
  "Documentation files installation path")
foam_installation_path(FOAM_INSTALL_MAN_PATH share/man "Man pages"
  "Man-pages installation path")
foam_installation_path(FOAM_INSTALL_TUTORIALS_PATH
  "${FOAM_INSTALL_DOC_PATH_ORIG}" "Tutorials" "Tutorials installation path")
foam_installation_path(FOAM_INSTALL_CMAKE_PATH
  "${FOAM_INSTALL_DATA_PATH_ORIG}/CMake"
  "CMake files" "CMake configuration files installation path")
foam_dependent_variables(PYTHON_VERSION FOAM_INSTALL_PYTHON_PATH)
foam_installation_path(FOAM_INSTALL_PYTHON_PATH
  "lib/python${PYTHON_SHORT_VERSION}/site-packages"
  "Python modules" "Python modules installation base path")

set(FOAM_INSTALL_RUNTIME_PATH "${FOAM_INSTALL_LIBEXEC_PATH}")

# determine the INSTALL_NAME_DIR of potential frameworks
if(APPLE AND FOAM_BUILD_FRAMEWORKS)
  set(FOAM_FRAMEWORK_INSTALL_NAME_DIR "${FOAM_INSTALL_FRAMEWORK_PATH}")
else()
  set(FOAM_FRAMEWORK_INSTALL_NAME_DIR "${FOAM_INSTALL_LIBRARY_PATH}")
endif()

# select html documentation browser (try a few well known ones for default)
# have to loop, because find_program(HTML_DOC_BROWSER NAMES ...) garbles things
# up
set(_BROWSERS xdg-open sensible-browser x-www-browser gnome-open kde-open
  firefox chromium-browser epiphany konqueror www-browser w3m lynx launch)
if(APPLE)
  list(INSERT _BROWSERS 0 open)
endif()
foreach(browser IN LISTS _BROWSERS)
  find_program(HTML_DOC_BROWSER ${browser}
    DOC "Program to open an HTML file")
  if(HTML_DOC_BROWSER)
    break()
  endif()
endforeach()
if(NOT HTML_DOC_BROWSER)
  message(STATUS
    "Failed to find a program to open HTML pages with (a.k.a a browser).\n"
    "Point HTML_DOC_BROWSER to a suitable program.")
  set(HTML_DOC_BROWSER "ECHO" CACHE STRING
    "Command to open an HTML file (ECHO will print it to STDOUT)" FORCE)
endif()
set(FOAM_HTML_DOC_BROWSER_COMMAND
  "\${HTML_DOC_BROWSER} %f" CACHE STRING "Command to open an HTML file")
string(CONFIGURE "${FOAM_HTML_DOC_BROWSER_COMMAND}"
  FOAM_HTML_DOC_BROWSER_COMMAND ESCAPE_QUOTES)
mark_as_advanced(HTML_DOC_BROWSER FOAM_HTML_DOC_BROWSER_COMMAND)

# Executable-prefix
string(TOLOWER "${PROJECT_NAME}-" _FOAM_DEFAULT_EXE_PREFIX)
set(FOAM_EXE_PREFIX "${_FOAM_DEFAULT_EXE_PREFIX}"
  CACHE STRING "Prefix for application output-names")
mark_as_advanced(FOAM_EXE_PREFIX)
string(TOUPPER "${FOAM_EXE_PREFIX}" FOAM_UPPER_EXE_PREFIX)

# ask user whether she wants to build Doxygen docs
foam_option(FOAM_ENABLE_DOXYGEN_DOCS "Doxygen API documentation"
  "Build the Doxygen API documentation" OFF)
# make sure only ON and OFF are used
if(FOAM_ENABLE_DOXYGEN_DOCS)
  set(FOAM_ENABLE_DOXYGEN_DOCS ON)
else()
  set(FOAM_ENABLE_DOXYGEN_DOCS OFF)
endif()
# if user wants doxygen docs, find Doxygen and set up some options
if(FOAM_ENABLE_DOXYGEN_DOCS)
  find_package(Doxygen REQUIRED)
  execute_process(COMMAND ${DOXYGEN_EXECUTABLE} --version
    RESULT_VARIABLE DOXYGEN_VERSION_RESULT
    OUTPUT_VARIABLE DOXYGEN_VERSION_OUTPUT
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  if(DOXYGEN_VERSION_RESULT)
    message(SEND_ERROR "Failed to determine doxygen version")
  endif()
  if(${DOXYGEN_VERSION_OUTPUT} VERSION_GREATER 1.6.3 AND
      ${DOXYGEN_VERSION_OUTPUT} VERSION_LESS 1.7.2-20101106)
    message(WARNING
      "Found Doxygen version ${DOXYGEN_VERSION_OUTPUT}. "
      "Versions newer than 1.6.3 and older than 1.7.2-20101106 "
      "usually crash when processing the ${PROJECT_NAME} documentation.")
  endif()
  if(${DOXYGEN_VERSION_OUTPUT} VERSION_LESS 1.5.8)
    set(DOXYGEN_SOURCE_SEP "-")
  else()
    set(DOXYGEN_SOURCE_SEP "_")
  endif()
  # ask user whether she prefers local or www docs
  foam_option(FOAM_USE_LOCAL_DOXYGEN_DOCS "Use local API docs"
    "Use the local API documentation instead of http://freefoam.sf.net/doc/API"
    ON)
  mark_as_advanced(FOAM_USE_LOCAL_DOXYGEN_DOCS)
endif()

# ask user whether she wants to build the man pages
foam_option(FOAM_ENABLE_MANPAGE_HELP "Build manpage help"
  "Build the manpages (requires asciidoc)" OFF)
# ask user whether she wants to build the xhtml man pages
foam_option(FOAM_ENABLE_XHTML_HELP "Build xhtml help"
  "Build the xhtml help pages (requires asciidoc)" OFF)
# as user whether she wanst to build the xhtml guides
foam_option(FOAM_ENABLE_XHTML_GUIDES "Build the xhtml guides"
  "Build the xhtml guides (requires asciidoc, dot, inkscape and asymptote)"
  OFF)
# as user whether she wanst to build the xhtml guides
foam_option(FOAM_ENABLE_PDF_GUIDES "Build the PDF guides"
  "Build the PDF guides (requires asciidoc, dot, inkscape and asymptote)" OFF)
if(FOAM_ENABLE_PDF_GUIDES)
  foam_option(FOAM_USE_FOP "Use FOP instead of dblatex"
    "Use FOP to build the PDF guides instead of dblatex" OFF)
  mark_as_advanced(FOAM_USE_FOP)
else()
  set(FOAM_USE_FOP FALSE)
endif()

if(FOAM_ENABLE_DOXYGEN_DOCS OR FOAM_ENABLE_XHTML_GUIDES)
  foam_option(FOAM_DOCS_FOR_SF "Docs for SourceForge"
    "Build the docs for deployment on SourceForge" OFF)
  mark_as_advanced(FOAM_DOCS_FOR_SF)
  # make sure only ON and OFF are used
  if(FOAM_DOCS_FOR_SF)
    set(FOAM_DOCS_FOR_SF ON)
  else()
    set(FOAM_DOCS_FOR_SF OFF)
  endif()
endif()

if(BUILD_TESTING)
  # ask user whether whe wants full tutorial tests
  foam_option(FOAM_ENABLE_FULL_TUTORIAL_TESTS
    "Full tutorial tests"
    "Run the complete tutorial tests (not just a single time step)" OFF)
  mark_as_advanced(FOAM_ENABLE_FULL_TUTORIAL_TESTS)
endif()

if(FOAM_ENABLE_XHTML_GUIDES)
  set(FOAM_ENABLE_XHTML_GUIDES ON)
  foam_option(FOAM_ENABLE_MATHJAX "Use MathJax in XHTML guides"
    "Use MathJax for formulas in the XHTML version of the guides" ON)
  if(FOAM_ENABLE_MATHJAX)
    foam_option(FOAM_MATHJAX_USE_CDN
      "Use the MathJax CDN"
      "Use public MathJax installation at http://cdn.mathjax.org" ON)
    mark_as_advanced(FOAM_MATHJAX_USE_CDN)
    if(FOAM_MATHJAX_USE_CDN)
      set(FOAM_MATHJAX_URL "http://cdn.mathjax.org/mathjax/latest")
    else()
      set(FOAM_MATHJAX_URL "MathJAX-NOTFOUND" CACHE PATH
        "Path or URL to the MathJax directory containing the MathJax.js file")
      mark_as_advanced(FOAM_MATHJAX_URL)
      if(NOT FOAM_MATHJAX_URL)
        message(SEND_ERROR "FOAM_MATHJAX_URL must be set to the directory or "
          "URL containing MathJax.js")
      endif()
    endif()
  endif()
else()
  set(FOAM_ENABLE_XHTML_GUIDES OFF)
  set(FOAM_ENABLE_MATHJAX FALSE)
endif()

# assemble the list of enabled manpage formats
set(FOAM_MANPAGE_FORMATS)
if(FOAM_ENABLE_MANPAGE_HELP)
  list(APPEND FOAM_MANPAGE_FORMATS manpage)
endif()
if(FOAM_ENABLE_XHTML_HELP)
  list(APPEND FOAM_MANPAGE_FORMATS xhtml)
endif()

# assemble the list of enabled guides formats
set(FOAM_GUIDES_FORMATS)
if(FOAM_ENABLE_XHTML_GUIDES)
  list(APPEND FOAM_GUIDES_FORMATS xhtml)
endif()
if(FOAM_ENABLE_PDF_GUIDES)
  list(APPEND FOAM_GUIDES_FORMATS pdf)
endif()

if(FOAM_MANPAGE_FORMATS OR FOAM_GUIDES_FORMATS)
  # find AsciiDoc
  find_program(ASCIIDOC_EXECUTABLE NAMES asciidoc.py asciidoc)
  get_filename_component(asciidoc_path "${ASCIIDOC_EXECUTABLE}" PATH)
  find_program(A2X_EXECUTABLE NAMES a2x.py a2x HINTS "${asciidoc_path}")
  if(NOT ASCIIDOC_EXECUTABLE OR NOT A2X_EXECUTABLE)
    message(SEND_ERROR
      "AsciiDoc is required to create man and html help and the guides")
  endif()
  mark_as_advanced(ASCIIDOC_EXECUTABLE A2X_EXECUTABLE)
  # read CONF_DIR from A2X_EXECUTABLE and copy style files over
  if(A2X_EXECUTABLE)
    file(READ "${A2X_EXECUTABLE}" _asciidoc_text)
    if(_asciidoc_text MATCHES "[ \t]*CONF_DIR[ \t]*=[ \t]*r?['\"]([^'\"]+)")
      set(A2X_CONF_DIR "${CMAKE_MATCH_1}")
      if(IS_DIRECTORY "${A2X_CONF_DIR}")
        configure_file("${A2X_CONF_DIR}/docbook-xsl/common.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-common.xsl"
          COPYONLY)
        configure_file("${A2X_CONF_DIR}/docbook-xsl/chunked.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-chunked.xsl"
          COPYONLY)
        configure_file("${A2X_CONF_DIR}/docbook-xsl/xhtml.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-xhtml.xsl"
          COPYONLY)
        configure_file("${A2X_CONF_DIR}/dblatex/asciidoc-dblatex.sty"
          "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/orig-asciidoc-dblatex.sty"
          COPYONLY)
        configure_file("${A2X_CONF_DIR}/dblatex/asciidoc-dblatex.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/orig-asciidoc-dblatex.xsl"
          COPYONLY)
      else()
        message(SEND_ERROR "The Asciidoc configuration directory "
          "${A2X_CONF_DIR} does not exist")
      endif()
    else()
      message(SEND_ERROR "Failed to read CONF_DIR from ${A2X_EXECUTABLE}")
    endif()
  endif()
  if(FOAM_ENABLE_XHTML_GUIDES)
    find_program(XSLTPROC_EXECUTABLE xsltproc)
    if(NOT XSLTPROC_EXECUTABLE)
      message(SEND_ERROR "Failed to find xsltproc executable"
        "Required if FOAM_ENABLE_XHTML_GUIDES is enabled")
    endif()
    mark_as_advanced(XSLTPROC_EXECUTABLE)
  endif()
  set(FOAM_NEED_PNGMATH FALSE)
  if((FOAM_ENABLE_XHTML_GUIDES AND NOT FOAM_ENABLE_MATHJAX) OR
    (FOAM_ENABLE_PDF_GUIES AND FOAM_USE_FOP))
    set(FOAM_NEED_PNGMATH TRUE)
    foreach(prog latex dvipng)
      string(TOUPPER ${prog} uprog)
      find_program(${uprog}_EXECUTABLE ${prog})
      mark_as_advanced(${uprog}_EXECUTABLE)
      if(NOT ${uprog}_EXECUTABLE)
        message(SEND_ERROR
          "${prog} is required when FOAM_ENABLE_MATHJAX is disabled "
          "or FOAM_USE_FOP is enabled")
      endif()
    endforeach()
  endif()
  if(NOT PYTHON_VERSION VERSION_LESS 3)
    if(NOT PYTHON2_EXECUTABLE OR NOT PYTHON2_VERSION)
      foam_dependent_variables(PYTHON2_EXECUTABLE PYTHON2_VERSION)
      find_program(PYTHON2_EXECUTABLE NAMES python2.7 python2.6 python2.5
        python2.4 python)
      if(PYTHON2_EXECUTABLE)
        foam_determine_python_version(PYTHON2_VERSION ${PYTHON2_EXECUTABLE})
        set(PYTHON2_VERSION ${PYTHON2_VERSION} CACHE INTERNAL
          "The Python-2 version")
        if(PYTHON2_VERSION VERSION_LESS 2.4 OR
            NOT PYTHON2_VERSION VERSION_LESS 3)
          message(SEND_ERROR
            "Python version >= 2.4 and < 3 required (PYTHON2_EXECUTABLE)")
        endif()
      else()
        message(SEND_ERROR
          "Failed to find Python-2 required for AsciiDoc (PYTHON2_EXECUTABLE)")
      endif()
    endif()
  else()
    set(PYTHON2_EXECUTABLE ${PYTHON_EXECUTABLE})
  endif()
endif()
if(FOAM_GUIDES_FORMATS)
  # find asymptote
  find_program(ASY_EXECUTABLE asy)
  if(NOT ASY_EXECUTABLE)
    message(SEND_ERROR "Asymptote is required to create the guides")
  endif()
  mark_as_advanced(ASY_EXECUTABLE)
endif()

# set up the RPATH for installation
set(CMAKE_INSTALL_RPATH ${FOAM_INSTALL_LIBRARY_PATH})
set(CMAKE_INSTALL_NAME_DIR ${FOAM_FRAMEWORK_INSTALL_NAME_DIR})

# we want executables and libraries in uniform places
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
  "${CMAKE_BINARY_DIR}/libexec/${PROJECT_NAME}/${FOAM_VERSION_FULL}")
set(FOAM_LIBRARY_OUTPUT_DIRECTORY
  "${CMAKE_BINARY_DIR}/lib/${PROJECT_NAME}-${FOAM_VERSION_FULL}")
set(FOAM_FRAMEWORK_OUTPUT_DIRECTORY
  "${CMAKE_BINARY_DIR}/Library/Frameworks")
if(FOAM_BUILD_FRAMEWORKS)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${FOAM_FRAMEWORK_OUTPUT_DIRECTORY}")
else()
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${FOAM_LIBRARY_OUTPUT_DIRECTORY}")
endif()
set(FOAM_ARCHIVE_OUTPUT_DIRECTORY "${FOAM_LIBRARY_OUTPUT_DIRECTORY}")

# find parallel libraries
find_package(MPI)
if(MPI_FOUND)
  set(_FOAM_USE_MPI ON)
else()
  set(_FOAM_USE_MPI OFF)
endif()
foam_option(FOAM_USE_MPI "Use MPI"
  "Build ${CMAKE_PROJECT} against MPI parallel libraries" ${_FOAM_USE_MPI})
mark_as_advanced(FOAM_USE_MPI)
if(FOAM_USE_MPI AND NOT MPI_FOUND)
  message(SEND_ERROR
    "FOAM_ENABLE_MPI is true, but MPI cannot be found.\n"
    "If you have MPI installed on your system, edit the variables\n"
    "MPI_INCLUDE_DIR and MPI_LIBRARY in the cache, else disable the\n"
    "setting FOAM_USE_MPI."
  )
endif()

# find readline
find_package(Readline)

# substitution for build-tree and install-tree as used by
# foam_configure_files.
set(FOAM_CONFIGURE_FILES_VARIABLES
  FOAM_DATA_DIR
    "${CMAKE_BINARY_DIR}/data"
    "${FOAM_INSTALL_DATA_PATH}"
  FOAM_LOCAL_DOC_DIR
    "${CMAKE_BINARY_DIR}/doc"
    "${FOAM_INSTALL_DOC_PATH}"
  FOAM_BIN_DIR
    "${CMAKE_BINARY_DIR}/bin"
    "${FOAM_INSTALL_BIN_PATH}"
  FOAM_LIB_DIR
    "${CMAKE_BINARY_DIR}/lib/FreeFOAM-${FOAM_VERSION_FULL}"
    "${FOAM_INSTALL_LIBRARY_PATH}"
  FOAM_LIBEXEC_DIR
    "${CMAKE_BINARY_DIR}/libexec/FreeFOAM/${FOAM_VERSION_FULL}"
    "${FOAM_INSTALL_LIBEXEC_PATH}"
  FOAM_FRAMEWORK_DIR
    "${CMAKE_BINARY_DIR}/Library/Frameworks"
    "${FOAM_INSTALL_FRAMEWORK_PATH}"
  FOAM_INCLUDE_DIR
    "${CMAKE_BINARY_DIR}/include"
    "${FOAM_INSTALL_HEADER_PATH}"
  FOAM_CONFIG_DIR
    "${CMAKE_BINARY_DIR}/etc"
    "${FOAM_INSTALL_CONFIG_PATH}"
  FOAM_CMAKECONFIG_DIR
    "${CMAKE_BINARY_DIR}/CMake"
    "${FOAM_INSTALL_CMAKE_PATH}"
  FOAM_PYTHON_DIR
    "${CMAKE_BINARY_DIR}/data/python"
    "${FOAM_INSTALL_PYTHON_PATH}"
  FOAM_IS_INSTALLED
    "FALSE"
    "TRUE"
  )
if(WIN32)
  list(APPEND FOAM_CONFIGURE_FILES_VARIABLES
    FOAM_PLUGIN_DIR
      "${CMAKE_BINARY_DIR}/lib/FreeFOAM-${FOAM_VERSION_FULL}"
      "${FOAM_INSTALL_LIBRARY_PATH}")
else()
  list(APPEND FOAM_CONFIGURE_FILES_VARIABLES
    FOAM_PLUGIN_DIR
      "${CMAKE_BINARY_DIR}/lib/FreeFOAM-${FOAM_VERSION_FULL}/plugins"
      "${FOAM_INSTALL_PLUGIN_PATH}")
endif()
if(FOAM_USE_LOCAL_DOXYGEN_DOCS)
  list(APPEND FOAM_CONFIGURE_FILES_VARIABLES
    FOAM_DOC_DIR "${CMAKE_BINARY_DIR}/doc" "${FOAM_INSTALL_DOC_PATH}")
else()
  set(_sf_doc "http://freefoam.sf.net/doc/${FOAM_VERSION_FULL}")
  list(APPEND FOAM_CONFIGURE_FILES_VARIABLES
    FOAM_DOC_DIR "${_sf_doc}" "${_sf_doc}")
endif()

# thirdparty libraries
foam_thirdparty_option(Metis
  "Required by the metis decomposition method"
  Metis TRUE ON)
if(FOAM_ENABLE_METIS)
  if(FOAM_ENABLE_METIS AND METIS_REQUIRES_MPI AND NOT FOAM_USE_MPI)
    message(SEND_ERROR
      "Your metis implementation requires FOAM_USE_MPI to be enabled."
      "If you don't have/want MPI, enable FOAM_BUILD_PRIVATE_METIS instead.")
  endif()
endif()
foam_thirdparty_option(ParMetis
  "Required by the parmetis decomposition method"
  ParMetis TRUE ${FOAM_USE_MPI}
  PARMETIS_metis_LIBRARY PARMETIS_parmetis_LIBRARY)
if(FOAM_ENABLE_PARMETIS AND NOT FOAM_USE_MPI)
  message(SEND_ERROR
    "ParMetis requires FOAM_USE_MPI to be enabled.")
endif()
if(FOAM_ENABLE_PARMETIS AND NOT FOAM_ENABLE_METIS)
  message(SEND_ERROR
    "ParMetis requires FOAM_ENABLE_METIS to be enabled.")
endif()
set(SCOTCH_USE_ERREXIT TRUE)
foam_thirdparty_option(SCOTCH "" SCOTCH FALSE ON SCOTCH_scotch_LIBRARY
  SCOTCH_scotcherr_LIBRARY SCOTCH_scotcherrexit_LIBRARY)
# do not enable mgridgen by default (licensing issues)
if(NOT FOAM_DOUBLE_PRECISION)
  set(MGRIDGEN_USE_REAL ON)
endif()
foam_thirdparty_option(MGRIDGEN
  "Required by the MGridGen GAMG agglomerator. LICENSE UNCLEAR"
  MGRIDGEN TRUE OFF)
# do not enable libccmio by default (licensing issues)
foam_thirdparty_option(ccmio
  "Required by ccm26ToFoam. REQUIRES PERMISSION BY CDADAPCO!"
  Ccmio TRUE OFF)
foam_thirdparty_option(zlib "" ZLIB FALSE ON)

# figure out default Pstream library
if(FOAM_USE_MPI)
  set(_FOAM_DEFAULT_PSTREAM mpi)
else()
  set(_FOAM_DEFAULT_PSTREAM dummy)
endif()
set(FOAM_DEFAULT_PSTREAM ${_FOAM_DEFAULT_PSTREAM} CACHE STRING
  "Default Pstream library implementation [dummy|mpi]")
mark_as_advanced(FOAM_DEFAULT_PSTREAM)

# find m4 macro processor
find_program(M4_EXECUTABLE m4 DOC "Path to the m4 macro processor")
mark_as_advanced(M4_EXECUTABLE)
if(NOT M4_EXECUTABLE)
  message("WARNING: Failed to find M4 macro processor.\n"
    "Some of the tutorials will fail if it can't be found.")
  set(M4_EXECUTABLE m4)
endif()

# on APPLE use cp -R -P -p, otherwise use cp -a
if(APPLE)
  set(FOAM_CP_A_FLAGS "-R -P -p")
else()
  set(FOAM_CP_A_FLAGS "-a")
endif()

# execinfo.h and cxxabi.h only work using GNU gcc and Debug config
# assume that if we have execinfo.h, cxxabi.h is also present.
if(CMAKE_COMPILER_IS_GNUCXX AND CMAKE_BUILD_TYPE STREQUAL Debug)
  find_package(Execinfo)
endif()

# create the FOAMConfig.h file
configure_file(${CMAKE_SOURCE_DIR}/FOAMConfig.h.in
  ${CMAKE_BINARY_DIR}/include/FOAMConfig.h @ONLY)

# on Solaris/SunOS fix up the shebangs
if(CMAKE_SYSTEM_NAME STREQUAL SunOS AND
    NOT EXISTS ${CMAKE_BINARY_DIR}/replaceAllShellSun.run)
  message(STATUS "Fixing shell-interpreter for SunOS and Solaris")
  execute_process(
    COMMAND ${CMAKE_SOURCE_DIR}/data/utilities/replaceAllShellSun bin
    COMMAND ${CMAKE_SOURCE_DIR}/data/utilities/replaceAllShellSun data
    COMMAND ${CMAKE_SOURCE_DIR}/data/utilities/replaceAllShellSun tutorials
    COMMAND ${CMAKE_SOURCE_DIR}/data/utilities/replaceAllShellSun doc
    COMMAND ${CMAKE_COMMAND} -E touch${CMAKE_BINARY_DIR}/replaceAllShellSun.run
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
endif()

# set up defines
set(FOAM_COMPILE_DEFINITIONS
  -D${FOAM_PRECISION}
  -DNoRepository
  -D${FOAM_OS}
  )
if(APPLE)
  list(APPEND FOAM_COMPILE_DEFINITIONS -Ddarwin)
endif()
add_definitions(${FOAM_COMPILE_DEFINITIONS})

# set up include-directories for own headers
include_directories(${CMAKE_BINARY_DIR}/include)

# set up version info checks and updating of global.C
set(FOAM_HAVE_GIT FALSE)
if(EXISTS "${CMAKE_SOURCE_DIR}/.git/config")
  find_package(Git)
  if(GIT_FOUND)
    set(FOAM_HAVE_GIT TRUE)
    option(FOAM_VERSION_CHECK_WARN_ONLY
      "Only warn if the version numbers are wrong" FALSE)
    mark_as_advanced(FOAM_VERSION_CHECK_WARN_ONLY)
    configure_file(CMake/ConfigureGlobalC.cmake.in
      "${CMAKE_BINARY_DIR}/CMake/ConfigureGlobalC.cmake" @ONLY)
    add_custom_target(version_check ALL
      COMMAND "${PYTHON_EXECUTABLE}"
        "${CMAKE_BINARY_DIR}/data/utilities/checkVersionInfo.py"
        ${_CHECK_VERSION_INFO_ARGS}
      DEPENDS "${CMAKE_BINARY_DIR}/data/utilities/checkVersionInfo.py"
      COMMENT "Checking version information"
      VERBATIM)
  else()
    message(WARNING
      "Not performing version checks because GIT_EXECUTABLE is missing")
  endif()
else()
  message(STATUS
    "Not performing version checks because not in a Git checkout")
endif()

if(NOT FOAM_HAVE_GIT)
  if(NOT EXISTS ${CMAKE_SOURCE_DIR}/.build.cmake)
    message(SEND_ERROR "If not in a Git checkout, .build.cmake is required")
  endif()
  include(${CMAKE_SOURCE_DIR}/.build.cmake)
endif()

# helper variables to force linking on some systems
set(_TURBULENCE_MODELS ${PROJECT_SOURCE_DIR}/src/turbulenceModels)
set(FORCE_LINK_COMPRESSIBLE_RAS_MODELS
  ${_TURBULENCE_MODELS}/compressible/RAS/RASModel/forceLink.C)
set(FORCE_LINK_COMPRESSIBLE_LES_MODELS
  ${_TURBULENCE_MODELS}/compressible/LES/LESModel/forceLink.C)
set(FORCE_LINK_INCOMPRESSIBLE_RAS_MODELS
  ${_TURBULENCE_MODELS}/incompressible/RAS/RASModel/forceLink.C)
set(FORCE_LINK_INCOMPRESSIBLE_LES_MODELS
  ${_TURBULENCE_MODELS}/incompressible/LES/LESModel/forceLink.C)
set(FORCE_LINK_GENERIC_PATCH_FIELDS
  ${PROJECT_SOURCE_DIR}/src/genericPatchFields/include/forceLink.C)
set(FORCE_LINK_RADIATION
  ${PROJECT_SOURCE_DIR}/src/thermophysicalModels/radiation/radiationModel/radiationModel/forceLink.C)
set(FORCE_LINK_COAL_COMBUSTION
  ${PROJECT_SOURCE_DIR}/src/lagrangian/coalCombustion/include/forceLink.C)
set(FORCE_LINK_INTERFACE_PROPERTIES
  ${PROJECT_SOURCE_DIR}/src/transportModels/interfaceProperties/forceLink.C)

# descend into the sources...
add_subdirectory(bin)
add_subdirectory(etc)
add_subdirectory(data)
add_subdirectory(src)
add_subdirectory(applications)
add_subdirectory(tutorials)
# doc *must* be last, else manpage and Doxygen generation fails
add_subdirectory(doc)

# export the library dependencies to the build tree
foam_export_targets_to_build_tree(${PROJECT_NAME}LibraryDepends)
export(PACKAGE ${PROJECT_NAME})

# write the doc index file and install it
foam_write_doc_index()
install(FILES
  ${CMAKE_BINARY_DIR}/InstallFiles/data/DoxyDocIndex
  DESTINATION ${FOAM_INSTALL_DATA_PATH}
  COMPONENT data
  )

# create ${PROJECT_NAME}Config.cmake ${PROJECT_NAME}Use.cmake,
# ${PROJECT_NAME}Utilities.cmake and ${PROJECT_NAME}WmakeCompatibility.cmake
# for the build and install tree
foam_configure_files(ConfigInstallFiles
  "CMake/FOAMConfig.cmake.in==CMake/${PROJECT_NAME}Config.cmake"
  "CMake/FOAMUse.cmake.in==CMake/${PROJECT_NAME}Use.cmake"
  "CMake/FOAMWmakeCompatibility.cmake.in==CMake/${PROJECT_NAME}WmakeCompatibility.cmake"
  COPYONLY
  "CMake/FOAMUtilities.cmake==CMake/${PROJECT_NAME}Utilities.cmake"
  )

# install the CMake config files
install(FILES
  ${ConfigInstallFiles}
  DESTINATION ${FOAM_INSTALL_CMAKE_PATH}
  COMPONENT dev
  )

# install the ${PROJECT_NAME}LibraryDepends.cmake file
install(EXPORT ${PROJECT_NAME}LibraryDepends
  DESTINATION ${FOAM_INSTALL_CMAKE_PATH}
  NAMESPACE FOAM_
  COMPONENT dev
  )

# uninstall target
configure_file(
  "${CMAKE_SOURCE_DIR}/CMake/Modules/cmake_uninstall.cmake.in"
  "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake"
  @ONLY
  )

add_custom_target(uninstall
  "${CMAKE_COMMAND}" -P "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake"
  )

# print cool feature summary
foam_print_feature_summary()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
