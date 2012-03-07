# - Utilities to build Third-Party libraries.
#
#  FOAM_THIRDPARTY_OPTION(<name> <description> <pkgname> <optional> <enabled>)
#
# Offers the user with options related to a third-party library. If <optional>
# is TRUE, the option FOAM_<UPPER_name>_ENABLED is created with the initial
# value <enabled> and the description given in <description>. If <optional>
# is FALSE, the option is not generated, and <description> can be the empty
# string and the value of <enabled> is meaningless. The function then first
# tries to find the package <pkgname> using FIND_PACKAGE(). Depending on the
# result, the function creates the option FOAM_BUILD_PRIVATE_<UPPER_name>
# with the default value set to FALSE if FIND_PACKAGE() found <pkgname>,
# or TRUE otherwise. Lastly an entry in the feature-summary table is made.
# All remaining arguments are considered to be variables that have to be
# purged using FOAM_DEPENDENT_VARIABLES() when FOAM_BUILD_PRIVATE_<UPPER_name>
# changes its value.
#
#  FOAM_EXTERNAL_PROJECT_ADD(<name> [options ...])
#
# Like ExternalProject_Add() with simplified patching, MD5 checking and cache
# initialization. You can use the PATCH_FILE <patch> option to specify one
# patch file which is to be applied to the sources. Note that patch must apply
# with the patch-option -p1.  If you want to compare a download against an MD5
# sum, use the URL_MD5 <sum> option to specify a file to check and the
# check-sum. CACHE_INIT can be used to specify a cache-initialization script.
#
#  FOAM_WRITE_CACHE_INIT(<fname> [<varname1> ...])
#
# Write a cache initializer file <fname> that can be used for external
# projects. The file will contain SET() commands that pre-populate the cache of
# the external project with the variables <varname1>...
#

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
#
# Description
#   Functions to build thirdparty libraries
#
#-------------------------------------------------------------------------------

# helper variables
set(_foam_sf_master "http://master.dl.sourceforge.net/project")
set(_foam_sf_url "${_foam_sf_master}/freefoam")

macro(foam_thirdparty_option name description
    pkgname optional enable)
  set(_tpo_name "${name}")
  set(_tpo_description "${description}")
  set(_tpo_pkgname "${pkgname}")
  set(_tpo_optional "${optional}")
  set(_tpo_enable "${enable}")
  string(TOUPPER ${_tpo_name} _tpo_upper_name)
  string(TOUPPER ${_tpo_pkgname} _tpo_upper_pkgname)
  if(_tpo_optional)
    foam_option(FOAM_ENABLE_${_tpo_upper_name} "Enable ${_tpo_name}"
      "${_tpo_description}" ${_tpo_enable})
  endif()
  if(FOAM_ENABLE_${_tpo_upper_name} OR NOT _tpo_optional)
    if(NOT FOAM_BUILD_PRIVATE_${_tpo_upper_name})
      find_package(${_tpo_pkgname} QUIET)
      if(${_tpo_upper_pkgname}_FOUND)
        set(_tpo_private OFF)
      else()
        set(_tpo_private ON)
      endif()
    else()
      set(_tpo_private ON)
    endif()
    foam_option(FOAM_BUILD_PRIVATE_${_tpo_upper_name}
      "Build private ${_tpo_name}"
      "Download and compile ${_tpo_name} instead of searching in on the system"
      ${_tpo_private})
    foam_dependent_variables(FOAM_BUILD_PRIVATE_${_tpo_upper_name}
      ${_tpo_upper_name}_INCLUDE_DIR ${_tpo_upper_name}_LIBRARY ${ARGN})
    if(FOAM_BUILD_PRIVATE_${_tpo_upper_name})
      foam_build_thirdparty(${_tpo_upper_name})
    elseif(NOT ${_tpo_upper_pkgname}_FOUND)
      # just to get the not-found-message on the screen
      find_package(${_tpo_pkgname})
      set(_tpo_msg
        " If you have ${_tpo_name} installed, edit the variables beginning"
        " with ${_tpo_upper_name}_ to refer to the installation or enable the"
        " setting FOAM_BUILD_PRIVATE_${_tpo_upper_name} in the cache.\n"
        )
      if(_tpo_optional)
        message(SEND_ERROR
          "FOAM_ENABLE_${_tpo_upper_name} is TRUE, but ${_tpo_name} cannot be"
          " found." ${_tpo_msg}
          )
      else()
        message(SEND_ERROR
          "${_tpo_name} is required but cannot be found.\n"
          ${_tpo_msg}
          )
      endif()
    else()
      # just to get the found-message on the screen
      find_package(${_tpo_pkgname})
    endif()
    mark_as_advanced(FOAM_BUILD_PRIVATE_${_tpo_upper_name})
  endif()
endmacro()

include(ExternalProject)

find_program(PATCH_EXECUTABLE patch)
mark_as_advanced(PATCH_EXECUTABLE)
configure_file("${CMAKE_SOURCE_DIR}/CMake/foam_apply_patch.cmake.in"
  "${CMAKE_BINARY_DIR}/CMake/foam_apply_patch.cmake" @ONLY)

function(foam_external_project_add name)
  # argument parsing
  foam_parse_arguments(_fepa
    "CMAKE_ARGS;CACHE_INIT:1;PATCH_FILE:1" "" "${ARGN}")
  set(args "${_fepa_DEFAULT_ARGS}")
  if(_fepa_PATCH_FILE)
    if(NOT PATCH_EXECUTABLE)
      message(SEND_ERROR "Required program `patch' not found")
    endif()
    list(APPEND args PATCH_COMMAND "${CMAKE_COMMAND}"
      -DPATCH_FILE=${_fepa_PATCH_FILE}
      -P "${CMAKE_BINARY_DIR}/CMake/foam_apply_patch.cmake")
  endif()
  if(_fepa_CMAKE_ARGS OR _fepa_CACHE_INIT)
    list(APPEND args CMAKE_ARGS)
    if(_fepa_CACHE_INIT)
      list(APPEND args -C ${_fepa_CACHE_INIT})
    endif()
    list(APPEND args ${_fepa_CMAKE_ARGS})
  endif()
  ExternalProject_Add(${name} "${args}")
endfunction()

function(_foam_append_init_var strvar)
  foreach(varname ${ARGN})
    get_property(type CACHE ${varname} PROPERTY TYPE)
    get_property(help CACHE ${varname} PROPERTY HELPSTRING)
    if(NOT type)
      set(type STRING)
    endif()
    if(NOT help)
      set(help "Set by CMake")
    endif()
    set(${strvar}
      "${${strvar}}\nset(${varname} \"${${varname}}\" CACHE ${type} \"${help}\")")
  endforeach()
  set(${strvar} "${${strvar}}" PARENT_SCOPE)
endfunction()

function(foam_write_cache_init fname)
  set(FOAM_CONFIGURABLE_CONTENT)
  if(CMAKE_CONFIGURATION_TYPES)
    string(TOUPPER "${CMAKE_CONFIGURATION_TYPES}" config_types)
  else()
    set(config_types DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
  endif()
  foreach(lang C CXX)
    # make sure that the static libraries are suitable to be used in shared
    # libraries
    set(CMAKE_${lang}_FLAGS "${CMAKE_SHARED_LIBRARY_${lang}_FLAGS}")
    _foam_append_init_var(FOAM_CONFIGURABLE_CONTENT
      CMAKE_${lang}_COMPILER CMAKE_${lang}_FLAGS)
    foreach(config ${config_types})
      _foam_append_init_var(FOAM_CONFIGURABLE_CONTENT
        CMAKE_${lang}_FLAGS_${config})
    endforeach()
  endforeach()
  foreach(type EXE MODULE SHARED)
    _foam_append_init_var(FOAM_CONFIGURABLE_CONTENT CMAKE_${type}_LINKER_FLAGS)
    foreach(config ${config_types})
      _foam_append_init_var(FOAM_CONFIGURABLE_CONTENT
        CMAKE_${type}_LINKER_FLAGS_${config})
    endforeach()
  endforeach()
  _foam_append_init_var(FOAM_CONFIGURABLE_CONTENT
    A2X_EXECUTABLE ASCIIDOC_EXECUTABLE BISON_EXECUTABLE CMAKE_AR
    CMAKE_BUILD_TYPE CMAKE_COLOR_MAKEFILE CMAKE_HAVE_HP_CMA CMAKE_HAVE_SPROC_H
    CMAKE_HAVE_THR_CREATE CMAKE_INSTALL_NAME_TOOL CMAKE_LINKER
    CMAKE_MAKE_PROGRAM CMAKE_NM CMAKE_OBJCOPY CMAKE_OBJDUMP
    CMAKE_OSX_ARCHITECTURES CMAKE_OSX_DEPLOYMENT_TARGET CMAKE_OSX_SYSROOT
    CMAKE_RANLIB CMAKE_SKIP_RPATH CMAKE_STRIP CMAKE_USE_RELATIVE_PATHS
    CMAKE_VERBOSE_MAKEFILE FLEX_CXX_FLAGS FLEX_EXECUTABLE FL_LIBRARY MPIEXEC
    MPIEXEC_MAX_NUMPROCS MPIEXEC_NUMPROC_FLAG MPIEXEC_POSTFLAGS
    MPIEXEC_PREFLAGS MPI_COMPILER MPI_COMPILE_FLAGS MPI_EXTRA_LIBRARY
    MPI_INCLUDE_PATH MPI_LIBRARY MPI_LINK_FLAGS ZLIB_INCLUDE_DIR ZLIB_LIBRARY)
  configure_file(
    "${CMAKE_SOURCE_DIR}/CMake/FOAMConfigurableFile.in" "${fname}" @ONLY)
endfunction()

# build metis
function(foam_build_metis)
  find_package(Threads REQUIRED)
  _foam_ep_download_if_required(download_opts
    "http://freefoam.sf.net/nonfree/metis-5.0.1.tar.gz"
    "6daba5e64ed86d46e038437eda720532"
    )
  foam_write_cache_init("${CMAKE_BINARY_DIR}/ThirdParty/METIS/metis_init.cmake")
  foam_external_project_add(METIS
    PREFIX ${CMAKE_BINARY_DIR}/ThirdParty/METIS
    ${download_opts}
    CACHE_INIT "${CMAKE_BINARY_DIR}/ThirdParty/METIS/metis_init.cmake"
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/ThirdParty/METIS"
       "-DGKLIB_PATH:PATH=<SOURCE_DIR>/GKlib"
    )
  # create imported library
  ExternalProject_Get_Property(METIS prefix)
  add_library(foam_metis STATIC IMPORTED)
  set_target_properties(foam_metis PROPERTIES
    IMPORTED_LOCATION
    "${prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}metis${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  # FindMETIS compatibility
  set(METIS_INCLUDE_DIRS
    ${CMAKE_BINARY_DIR}/ThirdParty/METIS/include PARENT_SCOPE)
  set(METIS_LIBRARIES foam_metis PARENT_SCOPE)
  set(METIS_LINK_FLAGS PARENT_SCOPE)
  set(METIS_NEW_API TRUE PARENT_SCOPE)
  # mark it for removal from the interface libraries by foam_install_targets
  set_property(GLOBAL APPEND PROPERTY FOAM_THIRDPARTY_LIBRARIES foam_metis)
endfunction()

# build parmetis
function(foam_build_parmetis)
  find_package(Threads REQUIRED)
  _foam_ep_download_if_required(download_opts
    "http://freefoam.sf.net/nonfree/ParMetis-3.1.tar.gz"
    "15f252eabc397a8c2f56fa1f5ed91354"
    )
  foam_write_cache_init("${CMAKE_BINARY_DIR}/ThirdParty/ParMetis/parmetis_init.cmake")
  foam_external_project_add(ParMetis
    PREFIX ${CMAKE_BINARY_DIR}/ThirdParty/ParMetis
    ${download_opts}
    PATCH_FILE "${CMAKE_SOURCE_DIR}/ThirdParty/parmetis.patch"
    CACHE_INIT "${CMAKE_BINARY_DIR}/ThirdParty/ParMetis/parmetis_init.cmake"
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/ThirdParty/ParMetis"
    )
  # create imported library
  ExternalProject_Get_Property(ParMetis prefix)
  add_library(foam_parmetis STATIC IMPORTED)
  set_target_properties(foam_parmetis PROPERTIES
    IMPORTED_LOCATION
    "${prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}foam_parmetis${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  # FindPARMETIS compatibility
  set(PARMETIS_INCLUDE_DIRS
    ${CMAKE_BINARY_DIR}/ThirdParty/ParMetis/include PARENT_SCOPE)
  set(PARMETIS_LIBRARIES foam_parmetis ${MPI_LIBRARIES} PARENT_SCOPE)
  set(PARMETIS_COMPILE_FLAGS "${MPIL_COMPILE_FLAGS}" PARENT_SCOPE)
  set(PARMETIS_LINK_FLAGS "${MPIL_LINK_FLAGS}" PARENT_SCOPE)
  # mark it for removal from the interface libraries by foam_install_targets
  set_property(GLOBAL APPEND PROPERTY FOAM_THIRDPARTY_LIBRARIES foam_parmetis)
endfunction()

# build ccmio
function(foam_build_ccmio)
  set(filename libccmio-2.6.1.tar.gz)
  set(URL "http://freefoam.sf.net/nonfree/${filename}")
  _foam_ep_download_if_required(download_opts
    "${URL}"
    "f81fbdfb960b1a4f3bcc7feee491efe4"
    )
  list(FIND download_opts DOWNLOAD_COMMAND download_cmd)
  if(download_cmd EQUAL -1)
    # the file is not local, remove the URL
    set(is_local FALSE)
    list(REMOVE_AT download_opts 0 1)
    find_package(Wget)
    find_program(CURL_EXECUTABLE curl)
    mark_as_advanced(CURL_EXECUTABLE)
    set(filepath "${CMAKE_BINARY_DIR}/ThirdParty/ccmio/src/${filename}")
    if(WGET_FOUND)
      list(INSERT download_opts 0 DOWNLOAD_COMMAND
        "${WGET_EXECUTABLE}" --no-check-certificate -O "${filename}" ${URL})
    elseif(CURL_EXECUTABLE)
      list(INSERT download_opts 0 DOWNLOAD_COMMAND
        "${CURL_EXECUTABLE}" --insecure --location -o "${filename}" ${URL})
    else()
      message(SEND_ERROR "Cannot download ${URL}\n"
        "Please do so manually and place the file in\n"
        "${CMAKE_SOURCE_DIR}/ThirdParty/${filename}")
    endif()
  else()
    set(is_local TRUE)
    set(filepath "${CMAKE_SOURCE_DIR}/ThirdParty/${filename}")
  endif()
  foam_write_cache_init("${CMAKE_BINARY_DIR}/ThirdParty/ccmio/ccmio_init.cmake")
  foam_external_project_add(ccmio
    PREFIX ${CMAKE_BINARY_DIR}/ThirdParty/ccmio
    ${download_opts}
    PATCH_FILE "${CMAKE_SOURCE_DIR}/ThirdParty/ccmio.patch"
    CACHE_INIT "${CMAKE_BINARY_DIR}/ThirdParty/ccmio/ccmio_init.cmake"
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/ThirdParty/ccmio"
    )
  # have to manually unpack..
  ExternalProject_Get_Property(ccmio source_dir download_dir stamp_dir tmp_dir)
  file(WRITE "${stamp_dir}/extract-ccmio.cmake"
"# Make file names absolute:
#
get_filename_component(tmp_dir \"${tmp_dir}\" ABSOLUTE)
get_filename_component(source_dir \"${source_dir}\" ABSOLUTE)

message(STATUS \"extracting...
     src='${filepath}'
     dst='\${source_dir}'\")

# Prepare a space for extracting:
#
set(i 1)
while(EXISTS \"\${tmp_dir}/extract\${i}\")
  math(EXPR i \"\${i} + 1\")
endwhile()
set(ut_dir \"\${tmp_dir}/extract\${i}\")
file(MAKE_DIRECTORY \"\${ut_dir}\")

# Extract it:
#
message(STATUS \"extracting... [tar xzf]\")
execute_process(COMMAND \"\${CMAKE_COMMAND}\" -E tar xzf ${filepath}
  WORKING_DIRECTORY \${ut_dir}
  RESULT_VARIABLE rv)

if(NOT rv EQUAL 0)
  message(STATUS \"extracting... [error clean up]\")
  file(REMOVE_RECURSE \"\${ut_dir}\")
  message(FATAL_ERROR \"error: extract of '${filepath}' failed\")
endif()

# Analyze what came out of the tar file:
#
message(STATUS \"extracting... [analysis]\")
file(GLOB contents \"\${ut_dir}/*\")
list(LENGTH contents n)
if(NOT n EQUAL 1 OR NOT IS_DIRECTORY \"\${contents}\")
  set(contents \"\${ut_dir}\")
endif()

# Copy \"the one\" directory to the final directory:
#
message(STATUS \"extracting... [copy]\")
file(COPY \"\${contents}/\" DESTINATION \${source_dir})

# Clean up:
#
message(STATUS \"extracting... [clean up]\")
file(REMOVE_RECURSE \"\${ut_dir}\")

message(STATUS \"extracting... done\")
"
)
  ExternalProject_Add_Step(ccmio unpack
    COMMENT "Performing extraction step for 'ccmio'"
    COMMAND "${CMAKE_COMMAND}" -P "${stamp_dir}/extract-ccmio.cmake"
    WORKING_DIRECTORY ${download_dir}
    DEPENDEES download
    DEPENDERS patch
    )
  # create imported library
  ExternalProject_Get_Property(ccmio prefix)
  add_library(foam_ccmio STATIC IMPORTED)
  set_target_properties(foam_ccmio PROPERTIES
    IMPORTED_LOCATION
    "${prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}foam_ccmio${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  # FindCcmio compatibility
  set(CCMIO_INCLUDE_DIRS
    ${CMAKE_BINARY_DIR}/ThirdParty/ccmio/include PARENT_SCOPE)
  set(CCMIO_LIBRARIES foam_ccmio PARENT_SCOPE)
  # mark it for removal from the interface libraries by foam_install_targets
  set_property(GLOBAL APPEND PROPERTY FOAM_THIRDPARTY_LIBRARIES foam_ccmio)
endfunction()

# build mgridgen
function(foam_build_mgridgen)
  _foam_ep_download_if_required(download_opts
    "http://freefoam.sf.net/nonfree/ParMGridGen-1.0.tar.gz"
    "2872fa95b7fb91d6bd525490eed62038"
    )
  foam_write_cache_init("${CMAKE_BINARY_DIR}/ThirdParty/MGridGen/mgridgen_init.cmake")
  foam_external_project_add(MGridGen
    PREFIX ${CMAKE_BINARY_DIR}/ThirdParty/MGridGen
    ${download_opts}
    PATCH_FILE "${CMAKE_SOURCE_DIR}/ThirdParty/mgridgen.patch"
    CACHE_INIT "${CMAKE_BINARY_DIR}/ThirdParty/MGridGen/mgridgen_init.cmake"
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/ThirdParty/MGridGen"
    )
  # create imported library
  ExternalProject_Get_Property(MGridGen prefix)
  add_library(foam_mgridgen STATIC IMPORTED)
  set_target_properties(foam_mgridgen PROPERTIES
    IMPORTED_LOCATION
    "${prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}foam_mgridgen${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  # FindMGRIDGEN compatibility
  set(MGRIDGEN_INCLUDE_DIRS
    ${CMAKE_BINARY_DIR}/ThirdParty/MGridGen/include PARENT_SCOPE)
  set(MGRIDGEN_LIBRARIES foam_mgridgen PARENT_SCOPE)
  set(PARMETIS_LINK_FLAGS PARENT_SCOPE)
  # mark it for removal from the interface libraries by foam_install_targets
  set_property(GLOBAL APPEND PROPERTY FOAM_THIRDPARTY_LIBRARIES foam_mgridgen)
endfunction()

# build scotch
function(foam_build_scotch)
  find_package(BISON REQUIRED)
  find_package(FLEX REQUIRED)
  find_package(Threads)
  _foam_ep_download_if_required(download_opts
    "${_foam_sf_url}/ThirdParty/scotch/scotch_5.1.7.dfsg.orig.tar.gz"
    "53d9715e11ae8e4cec1a48e8859e817f"
    )
  foam_write_cache_init("${CMAKE_BINARY_DIR}/ThirdParty/scotch/scotch_init.cmake")
  foam_external_project_add(scotch
    PREFIX ${CMAKE_BINARY_DIR}/ThirdParty/scotch
    ${download_opts}
    PATCH_FILE "${CMAKE_SOURCE_DIR}/ThirdParty/scotch.patch"
    CACHE_INIT "${CMAKE_BINARY_DIR}/ThirdParty/scotch/scotch_init.cmake"
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/ThirdParty/scotch"
    )
  # create imported library
  ExternalProject_Get_Property(scotch prefix)
  add_library(foam_scotch STATIC IMPORTED)
  set_target_properties(foam_scotch PROPERTIES
    IMPORTED_LOCATION
    "${prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}foam_scotch${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  # FindSCOTCH compatibility
  set(SCOTCH_INCLUDE_DIRS
    ${CMAKE_BINARY_DIR}/ThirdParty/scotch/include PARENT_SCOPE)
  set(SCOTCH_LIBRARIES foam_scotch PARENT_SCOPE)
  # mark it for removal from the interface libraries by foam_install_targets
  set_property(GLOBAL APPEND PROPERTY FOAM_THIRDPARTY_LIBRARIES foam_scotch)
endfunction()

# build zlib
function(foam_build_zlib)
  _foam_ep_download_if_required(download_opts
    "${_foam_sf_url}/ThirdParty/zlib/zlib-1.2.5.tar.gz"
    "c735eab2d659a96e5a594c9e8541ad63"
    )
  foam_write_cache_init("${CMAKE_BINARY_DIR}/ThirdParty/zlib/zlib_init.cmake")
  foam_external_project_add(ZLIB
    PREFIX ${CMAKE_BINARY_DIR}/ThirdParty/zlib
    ${download_opts}
    PATCH_COMMAND "${CMAKE_COMMAND}" -E remove -f zconf.h
    CACHE_INIT "${CMAKE_BINARY_DIR}/ThirdParty/zlib/zlib_init.cmake"
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/ThirdParty/zlib"
               "-DBUILD_SHARED_LIBS=OFF"
    )
  # create imported library
  ExternalProject_Get_Property(ZLIB prefix)
  add_library(foam_zlib STATIC IMPORTED)
  set_target_properties(foam_zlib PROPERTIES
    IMPORTED_LOCATION
    "${prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}z${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  # FindZLIB compatibility
  set(ZLIB_INCLUDE_DIRS
    ${CMAKE_BINARY_DIR}/ThirdParty/zlib/include PARENT_SCOPE)
  set(ZLIB_LIBRARIES foam_zlib PARENT_SCOPE)
  # mark it for removal from the interface libraries by foam_install_targets
  set_property(GLOBAL APPEND PROPERTY FOAM_THIRDPARTY_LIBRARIES foam_zlib)
endfunction()

# build MathJax
function(foam_build_mathjax)
  set(install_dir ${CMAKE_BINARY_DIR}/doc/MathJax)
  _foam_ep_download_if_required(download_opts
    "${_foam_sf_master}/mathjax/MathJax/v1.0.1/MathJax-v1.0.1a.zip"
    "b93c1f1e26a898faee072ab7aec57251"
    )
  foam_external_project_add(MathJax-PreFontUpdate
    PREFIX "${CMAKE_BINARY_DIR}/ThirdParty/MathJax"
    ${download_opts}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_DIR "${install_dir}"
    INSTALL_COMMAND "${CMAKE_COMMAND}" -E copy_directory
      <SOURCE_DIR> <INSTALL_DIR>
    )
  ExternalProject_Add_Step(MathJax-PreFontUpdate fontCleanup
    COMMENT "Removing broken web fonts in MathJax"
    COMMAND "${CMAKE_COMMAND}" -E remove_directory
      "${install_dir}/MathJax/fonts/HTML-CSS/TeX/otf"
    DEPENDEES install
    )
  _foam_ep_download_if_required(download_opts
    "http://www.mathjax.org/dl/MathJax-Font-Update.zip"
    "03ce6b5a62cfb9a8a8d205aea2e6997e"
    )
  # download & install font update
  foam_external_project_add(MathJax-FontUpdate
    DEPENDS MathJax-PreFontUpdate
    PREFIX "${CMAKE_BINARY_DIR}/ThirdParty/MathJax-FontUpdate"
    ${download_opts}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_DIR "${install_dir}/fonts/HTML-CSS/TeX/otf"
    INSTALL_COMMAND "${CMAKE_COMMAND}" -E copy_directory
      <SOURCE_DIR>/MathJax-Font-Update/otf <INSTALL_DIR>
    )
  add_custom_target(MathJax)
  add_dependencies(MathJax MathJax-FontUpdate)
  # FindMathJax compatibility
  set(MATHJAX_DIR "${install_dir}" PARENT_SCOPE)
endfunction()

# build third-party library
macro(foam_build_thirdparty _btp_what)
  if(${_btp_what} STREQUAL METIS)
    foam_build_metis()
  elseif(${_btp_what} STREQUAL PARMETIS)
    foam_build_parmetis()
  elseif(${_btp_what} STREQUAL CCMIO)
    foam_build_ccmio()
  elseif(${_btp_what} STREQUAL MGRIDGEN)
    foam_build_mgridgen()
  elseif(${_btp_what} STREQUAL SCOTCH)
    foam_build_scotch()
  elseif(${_btp_what} STREQUAL ZLIB)
    foam_build_zlib()
  elseif(${_btp_what} STREQUAL MATHJAX)
    foam_build_mathjax()
  else()
    message(FATAL_ERROR "Unknown third-party package ${_btp_what}")
  endif()
endmacro()

# Assemble download options for foam_external_project_add.
# If the file already exists in ${CMAKE_SOURCE_DIR}/ThirdParty, don't download
# it.
function(_foam_ep_download_if_required var url md5sum)
  string(REGEX REPLACE "^.*/" "" filename "${url}")
  set(filepath "${CMAKE_SOURCE_DIR}/ThirdParty/${filename}")
  if(EXISTS "${filepath}")
    # it's already in ${CMAKE_SOURCE_DIR}/ThirdParty
    set(${var} URL "${filepath}" URL_MD5 "${md5sum}" DOWNLOAD_COMMAND ""
      PARENT_SCOPE)
  else()
    # use ExternalCommand to download it
    set(${var} URL "${url}" URL_MD5 "${md5sum}" PARENT_SCOPE)
  endif()
endfunction()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
