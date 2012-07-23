
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
#   Functions to configure build and install FOAM libraries and executables.
#   Refer to FOAMUse.cmake for the documentation of these functions.
#
#   THE FIRST LINE OF THIS FILE IS INTENTIONALLY LEFT BLANK!
#
#-------------------------------------------------------------------------------

# CAUTION: Include this file only once!
#
# include-guard
if(NOT __FOAMADDTARGET_INCLUDED)
set(__FOAMADDTARGET_INCLUDED DEFINED)

# helper to set defaults for a variable
function(_foam_set_default var defvar def)
  if(DEFINED ${defvar})
    set(val ${${defvar}})
  else()
    set(val ${def})
  endif()
  set(${var} ${val} PARENT_SCOPE)
endfunction()

function(foam_parse_arguments prefix arg_specs option_names)
  # initialize
  set(DEFAULT_ARGS)
  set(maxcount_DEFAULT_ARGS -1)
  set(arg_names)
  foreach(arg_spec ${arg_specs})
    set(arg_name ${arg_spec})
    set(arg_maxcount -1)
    if(arg_spec MATCHES "^([^:]+)(:([0-9]+))?$")
      set(arg_name ${CMAKE_MATCH_1})
      if(CMAKE_MATCH_2)
        set(arg_maxcount ${CMAKE_MATCH_3})
      endif()
    endif()
    set(result_${arg_name})
    set(maxcount_${arg_name} ${arg_maxcount})
    list(APPEND arg_names ${arg_name})
  endforeach()
  foreach(option ${option_names})
    set(result_${option} FALSE)
  endforeach()

  # parse
  set(current_arg_name DEFAULT_ARGS)
  set(current_arg_count 0)
  foreach(arg IN LISTS ARGN)
    if(arg STREQUAL "")
      set(is_arg_name -1)
    else()
      list(FIND arg_names "${arg}" is_arg_name)
    endif()
    if(is_arg_name GREATER -1)
      set(current_arg_name ${arg})
      set(current_arg_count 0)
    else()
      if(arg STREQUAL "")
        set(is_option -1)
      else()
        list(FIND option_names "${arg}" is_option)
      endif()
      if(is_option GREATER -1)
        set(result_${arg} TRUE)
      elseif(maxcount_${current_arg_name} LESS 0 OR
          current_arg_count LESS ${maxcount_${current_arg_name}})
        list(APPEND result_${current_arg_name} "${arg}")
        math(EXPR current_arg_count "${current_arg_count} + 1")
      else()
        list(APPEND result_DEFAULT_ARGS "${arg}")
      endif()
    endif()
  endforeach()
  # propagate to caller scope
  foreach(arg_name DEFAULT_ARGS ${arg_names})
    set(${prefix}_${arg_name} "${result_${arg_name}}" PARENT_SCOPE)
  endforeach()
  foreach(option ${option_names})
    set(${prefix}_${option} "${result_${option}}" PARENT_SCOPE)
  endforeach()
endfunction()

function(foam_add_library name)
  # defaults
  _foam_set_default(export_set_name FOAM_EXPORT_SET_NAME ${PROJECT_NAME}LibraryDepends)
  _foam_set_default(enable_export_set FOAM_ENABLE_EXPORT_SET TRUE)
  _foam_set_default(build_framework FOAM_BUILD_FRAMEWORKS FALSE)
  _foam_set_default(create_include_wrappers FOAM_CREATE_INCLUDE_WRAPPERS FALSE)
  # argument parsing
  foam_parse_arguments(_fal "PUBLIC_HEADERS;EXPORT:1" "SKIP_EXPORT" ${ARGN})
  # check arguments
  if(_fal_EXPORT AND _fal_SKIP_EXPORT)
    message(FATAL_ERROR "Cannot specify both EXPORT and SKIP_EXPORT")
  endif()
  list(GET _fal_DEFAULT_ARGS 0 lib_type)
  if(lib_type MATCHES "^(STATIC|SHARED|MODULE)$")
    list(REMOVE_AT _fal_DEFAULT_ARGS 0)
  else()
    set(lib_type)
  endif()
  # check SRCS
  set(SRCS ${_fal_DEFAULT_ARGS})
  set(HDRS ${_fal_PUBLIC_HEADERS})
  if(NOT SRCS AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/files.cmake)
    include(${CMAKE_CURRENT_SOURCE_DIR}/files.cmake)
  endif()
  if(NOT SRCS)
    message(FATAL_ERROR "At least one source file required")
  endif()
  if(FOAM_HAS_FLEX_SOURCES)
    # check for .L sources
    foam_check_and_compile_flex(SRCS)
  endif()
  if(create_include_wrappers AND HDRS)
    # create the include wrappers
    foam_create_include_wrappers(${name} ${HDRS})
  endif()
  # add library
  add_library(${name} ${lib_type} ${SRCS})
  # set properties
  set_target_properties(${name} PROPERTIES
    FRAMEWORK ${build_framework}
    )
  if(NOT APPLE AND NOT lib_type STREQUAL MODULE)
    if(DEFINED FOAM_VERSION_FULL)
      set_target_properties(${name} PROPERTIES
        VERSION ${FOAM_VERSION_FULL})
    endif()
    if(DEFINED FOAM_SOVERSION)
      set_target_properties(${name} PROPERTIES
        SOVERSION ${FOAM_SOVERSION}
        FRAMEWORK_VERSION ${FOAM_SOVERSION})
    endif()
  endif()
  if(DEFINED FOAM_FRAMEWORK_INSTALL_NAME_DIR)
    set_target_properties(${name} PROPERTIES
      INSTALL_NAME_DIR "${FOAM_FRAMEWORK_INSTALL_NAME_DIR}")
  endif()
  get_target_property(_VER ${name} VERSION)
  get_target_property(_SOVER ${name} SOVERSION)
  if(HDRS)
    set_target_properties(${name} PROPERTIES
      PUBLIC_HEADER "${HDRS}"
      )
  endif()
  # add to build-tree export
  if(NOT _fal_SKIP_EXPORT AND enable_export_set)
    foam_add_target_to_build_tree_export(${export_set_name} ${name})
  endif()
  # set properties for Doxygen filtering
  set_property(GLOBAL APPEND PROPERTY FOAM_DOXYGEN_LIBRARIES "${name}")
  set_property(GLOBAL PROPERTY FOAM_DOXYGEN_${name}_LIBRARY_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}")
  # depend on version_check if enabled
  if(FOAM_HAVE_GIT)
    add_dependencies(${name} version_check)
  endif()
endfunction()

function(foam_add_executable name)
  # defaults
  _foam_set_default(do_doc_index FOAM_ENABLE_DOC_INDEX TRUE)
  set(do_manpage TRUE)
  # argument parsing
  foam_parse_arguments(_fae
    "OUTPUT_NAME:1;DOC_SRC:1;APP_SECTION:1"
    "SKIP_DOC_INDEX;SKIP_MANPAGE"
    ${ARGN})
  # find output name
  if(NOT _fae_OUTPUT_NAME)
    set(_fae_OUTPUT_NAME ${FOAM_EXE_PREFIX}${name})
  endif()
  # find application section
  if(NOT _fae_APP_SECTION AND DEFINED FOAM_APP_SECTION)
    set(_fae_APP_SECTION ${FOAM_APP_SECTION})
  endif()
  # check SKIP_DOC_INDEX
  if(_fae_SKIP_DOC_INDEX)
    set(do_doc_index FALSE)
  endif()
  # check SKIP_MANPAGE
  if(_fae_SKIP_MANPAGE)
    set(do_manpage FALSE)
  endif()
  set(SRCS ${_fae_DEFAULT_ARGS})
  # check SRCS
  if(NOT SRCS AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/files.cmake)
    include(${CMAKE_CURRENT_SOURCE_DIR}/files.cmake)
  endif()
  if(NOT SRCS)
    message(FATAL_ERROR "At least one source file required")
  endif()
  # find doc source
  if(NOT _fae_DOC_SRC)
    list(GET SRCS 0 _fae_DOC_SRC)
  endif()

  if(FOAM_HAS_FLEX_SOURCES)
    # check for .L sources
    foam_check_and_compile_flex(SRCS)
  endif()
  # add executable
  add_executable(${name} ${SRCS})
  # set output name
  set_target_properties(${name} PROPERTIES
    OUTPUT_NAME ${_fae_OUTPUT_NAME}
    )
  # add to index
  if(do_doc_index)
    foam_add_executable_to_doc_index(${_fae_OUTPUT_NAME} ${_fae_DOC_SRC})
  endif()
  # create brief description
  if(_fae_APP_SECTION)
    foam_create_app_brief(${name} ${_fae_APP_SECTION} "${_fae_DOC_SRC}")
  endif()
  # create man page
  if(do_manpage)
    foam_queue_manpage(${_fae_OUTPUT_NAME} ${_fae_DOC_SRC})
  endif()
  # set properties for Doxygen filtering
  set_property(GLOBAL APPEND PROPERTY FOAM_DOXYGEN_EXECUTABLES "${name}")
  set_property(GLOBAL PROPERTY FOAM_DOXYGEN_${name}_EXECUTABLE_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}")
  # depend on version_check if enabled
  if(FOAM_HAVE_GIT)
    add_dependencies(${name} version_check)
  endif()
endfunction()

# purge all export lists...
if(DEFINED __FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_SET_NAMES)
  list(REMOVE_DUPLICATES __FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_SET_NAMES)
  foreach(e ${__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_SET_NAMES})
    unset(__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_${e}_targets CACHE)
  endforeach()
  unset(__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_SET_NAMES CACHE)
endif()

function(foam_add_target_to_build_tree_export export_set_name)
  set(__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_${export_set_name}_targets
    ${__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_${export_set_name}_targets}
    ${ARGN}
    CACHE INTERNAL
    "Targets to export to the build tree for ${export_set_name}"
    )
  set(__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_SET_NAMES
    ${__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_SET_NAMES}
    ${export_set_name}
    CACHE INTERNAL
    "Build-tree export set names"
    )
endfunction()

function(foam_export_targets_to_build_tree export_set)
  if(ARGC GREATER 1)
    set(namespace ${ARGV1})
  elseif(DEFINED FOAM_EXPORT_NAMESPACE)
    set(namespace ${FOAM_EXPORT_NAMESPACE})
  else()
    set(namespace FOAM_)
  endif()
  string(REPLACE ";" " " _tmp "${__FOAM_ADD_TARGET_TO_BUILD_TREE_EXPORT_${export_set}_targets}")
  separate_arguments(_tmp)
  export(TARGETS ${_tmp}
    NAMESPACE ${namespace}
    FILE ${PROJECT_BINARY_DIR}/CMake/${export_set}.cmake
    )
endfunction()

function(foam_install_targets)
  # defaults
  _foam_set_default(export_set_name FOAM_EXPORT_SET_NAME ${PROJECT_NAME}LibraryDepends)
  _foam_set_default(enable_export_set FOAM_ENABLE_EXPORT_SET TRUE)
  _foam_set_default(export_executables FOAM_EXPORT_EXECUTABLES FALSE)
  _foam_set_default(ARCHIVE_destination FOAM_INSTALL_ARCHIVE_PATH lib/${PROJECT_NAME})
  _foam_set_default(LIBRARY_destination FOAM_INSTALL_LIBRARY_PATH lib/${PROJECT_NAME})
  _foam_set_default(RUNTIME_destination FOAM_INSTALL_RUNTIME_PATH libexec/${PROJECT_NAME})
  _foam_set_default(FRAMEWORK_destination FOAM_INSTALL_FRAMEWORK_PATH /Library/Frameworks)
  _foam_set_default(PRIVATE_HEADER_destination FOAM_INSTALL_HEADER_PATH include/${PROJECT_NAME})
  _foam_set_default(PUBLIC_HEADER_destination FOAM_INSTALL_HEADER_PATH include/${PROJECT_NAME})
  _foam_set_default(ARCHIVE_component FOAM_INSTALL_ARCHIVE_COMPONENT dev)
  _foam_set_default(LIBRARY_component FOAM_INSTALL_LIBRARY_COMPONENT shlibs)
  _foam_set_default(RUNTIME_component FOAM_INSTALL_RUNTIME_COMPONENT bin)
  _foam_set_default(FRAMEWORK_component FOAM_INSTALL_FRAMEWORK_COMPONENT shlibs)
  _foam_set_default(PRIVATE_HEADER_component FOAM_INSTALL_HEADER_COMPONENT dev)
  _foam_set_default(PUBLIC_HEADER_component FOAM_INSTALL_HEADER_COMPONENT dev)
  # argument parsing
  set(lib_targets)
  set(exe_targets)
  set(next_target TRUE)
  set(next_export FALSE)
  set(next_destination FALSE)
  set(next_component FALSE)
  set(PRIVATE_HEADER_is_default_dest TRUE)
  set(PUBLIC_HEADER_is_default_dest TRUE)
  set(install_type)
  foreach(a ${ARGN})
    if(a MATCHES
        "^(ARCHIVE|LIBRARY|RUNTIME|FRAMEWORK|(PUBLIC|PRIVATE)_HEADER)$")
      set(install_type ${a})
      set(next_target FALSE)
      if(a MATCHES "^(PUBLIC|PRIVATE)_HEADER$")
        set(${a}_is_default_dest FALSE)
      endif()
    # MUST be second after "a MATCHES ..."
    elseif(install_type)
      if(a STREQUAL DESTINATION)
        set(next_destination TRUE)
      elseif(a STREQUAL COMPONENT)
        set(next_component TRUE)
      elseif(next_destination)
        set(${install_type}_destination "${a}")
        set(${install_type}_is_default_dest FALSE)
        set(next_destination FALSE)
      elseif(next_component)
        set(${install_type}_component "${a}")
        set(next_component FALSE)
        set(install_type)
      else()
        message(FATAL_ERROR
          "Expected DESTINATION <dir> or COMPONENT <name> after ${install_type}")
      endif()
    elseif(a STREQUAL EXPORT)
      set(next_export TRUE)
      set(next_target FALSE)
    elseif(a STREQUAL SKIP_EXPORT)
      set(enable_export_set FALSE)
      set(next_target FALSE)
    elseif(a STREQUAL EXPORT_EXECUTABLES)
      set(export_executables TRUE)
      set(next_target FALSE)
    elseif(next_export)
      set(export_set_name ${a})
    elseif(next_target)
      # split targets into executables and others
      get_target_property(target_type ${a} TYPE)
      if(target_type STREQUAL EXECUTABLE)
        list(APPEND exe_targets ${a})
      else()
        list(APPEND lib_targets ${a})
      endif()
    else()
      message(FATAL_ERROR "Unexpected argument '${a}'")
    endif()
  endforeach()
  # set up "EXPORT <export-set>"
  if(NOT enable_export_set)
    set(lib_export_str)
  else()
    set(lib_export_str EXPORT ${export_set_name})
  endif()
  if(export_executables)
    set(exe_export_str ${lib_export_str})
  else()
    set(exe_export_str)
  endif()
  if(lib_targets)
    foreach(t ${lib_targets})
      # figure out installation directory of headers
      get_target_property(lib_name ${t} OUTPUT_NAME)
      if(NOT lib_name)
        set(lib_name ${t})
      endif()
      set(priv_hdr_dest "${PRIVATE_HEADER_destination}")
      if(NOT PRIVATE_HEADER_is_default_dest)
        set(priv_hdr_dest "${priv_hdr_dest}/${lib_name}")
      endif()
      set(pub_hdr_dest "${PUBLIC_HEADER_destination}")
      if(PUBLIC_HEADER_is_default_dest)
        set(pub_hdr_dest "${pub_hdr_dest}/${lib_name}")
      endif()
      # install the target
      install(TARGETS ${t}
        ${lib_export_str}
        ARCHIVE        DESTINATION ${ARCHIVE_destination}
                       COMPONENT ${ARCHIVE_component}
        LIBRARY        DESTINATION ${LIBRARY_destination}
                       COMPONENT ${LIBRARY_component}
        RUNTIME        DESTINATION ${RUNTIME_destination}
                       COMPONENT ${RUNTIME_component}
        FRAMEWORK      DESTINATION ${FRAMEWORK_destination}
                       COMPONENT ${FRAMEWORK_component}
        PRIVATE_HEADER DESTINATION ${priv_hdr_dest}
                       COMPONENT ${PRIVATE_HEADER_component}
        PUBLIC_HEADER  DESTINATION ${pub_hdr_dest}
                       COMPONENT ${PUBLIC_HEADER_component}
        )
    endforeach()
  endif()
  if(exe_targets)
    foreach(t ${exe_targets})
      install(TARGETS ${t}
        ${exe_export_str}
        ARCHIVE        DESTINATION ${ARCHIVE_destination}
                       COMPONENT ${ARCHIVE_component}
        LIBRARY        DESTINATION ${LIBRARY_destination}
                       COMPONENT ${LIBRARY_component}
        RUNTIME        DESTINATION ${RUNTIME_destination}
                       COMPONENT ${RUNTIME_component}
        FRAMEWORK      DESTINATION ${FRAMEWORK_destination}
                       COMPONENT ${FRAMEWORK_component}
        PRIVATE_HEADER DESTINATION ${priv_hdr_dest}
                       COMPONENT ${PRIVATE_HEADER_component}
        PUBLIC_HEADER  DESTINATION ${pub_hdr_dest}
                       COMPONENT ${PUBLIC_HEADER_component}
        )
    endforeach()
  endif()
endfunction()

function(foam_create_include_wrappers libname)
  # destination directory
  set(d "${CMAKE_BINARY_DIR}/include/${libname}")
  # loop over headers
  foreach(h ${ARGN})
    # make absolute, with no symlinks (they tend to break things...)
    get_filename_component(ha "${h}" ABSOLUTE)
    if(EXISTS "${ha}")
      # basename
      get_filename_component(hb "${ha}" NAME)
      # full path of the include wrapper
      set(hl "${d}/${hb}")
      # relative path of the header w.r.t the destination directory
      file(RELATIVE_PATH CONFIG_HEADER_FILE "${d}" "${ha}")
      if(NOT EXISTS "${hl}" OR "${ha}" IS_NEWER_THAN "${hl}")
        file(WRITE "${hl}"
"/* THIS FILE WAS AUTOMATICALLY GENERATED BY ${PROJECT_NAME}.
 * DO NOT EDIT! YOUR CHANGES WILL BE LOST!
 *
 * No include guards used, some headers need to be included
 * multiple times (e.g. to #undef some helper macros).
 */
#include \"${CONFIG_HEADER_FILE}\"
")
      endif()
    else()
      message(SEND_ERROR "The file \"${ha}\" does not exist")
    endif()
  endforeach()
endfunction()

if(FOAM_HAS_FLEX_SOURCES)
  # find flex for foam_check_and_compile_flex
  find_package(FLEX REQUIRED)
  include_directories(${FLEX_INCLUDE_DIRS})
  set(FLEX_CXX_FLAGS "-+"
    CACHE STRING "Flags used by the flex compiler for flex++ targets.")
  mark_as_advanced(FLEX_CXX_FLAGS)
endif()

function(foam_check_and_compile_flex SRC_VAR)
  if(${SRC_VAR} MATCHES "\\.L")
    foreach(src ${${SRC_VAR}})
      if(src MATCHES "\\.L$")
        if(NOT FOAM_HAS_FLEX_SOURCES)
          message(SEND_ERROR
            "The list of source files contains flex++ sources"
            "Set FOAM_HAS_FLEX_SOURCES to TRUE")
        endif()
        # construct .C name
        get_filename_component(CXX_src "${src}" NAME)
        string(REGEX REPLACE "\\.L$" ".C" CXX_src ${CXX_src})
        set(CXX_src "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${CXX_src}")
        # construct target name
        get_filename_component(FLEX_target "${src}" NAME_WE)
        set(FLEX_target "${FLEX_target}_Lexer")
        # create flex target
        flex_target(${FLEX_target}
          "${CMAKE_CURRENT_SOURCE_DIR}/${src}" "${CXX_src}"
          COMPILE_FLAGS ${FLEX_CXX_FLAGS}
          )
        # replace flex source with output of flex target
        list(REMOVE_ITEM ${SRC_VAR} ${src})
        list(APPEND ${SRC_VAR} ${CXX_src})
      endif()
    endforeach()
    set(${SRC_VAR} "${${SRC_VAR}}" PARENT_SCOPE)
  endif()
endfunction()

function(foam_link_loadable_library TARGET)
  if(NOT WIN32)
    if(FOAM_BUILD_FRAMEWORKS AND APPLE)
      # make sure the target is a framework
      get_target_property(_framework ${TARGET} FRAMEWORK)
      if(NOT _framework)
        message(FATAL_ERROR "The target ${TARGET} is not a FRAMEWORK")
      endif()
      # get the output location
      get_target_property(_lib ${TARGET} LOCATION)
      # link location and target for build tree
      get_filename_component(_libname
        "${_lib}${CMAKE_SHARED_LIBRARY_SUFFIX}" NAME)
      set(_libname "${CMAKE_SHARED_LIBRARY_PREFIX}${_libname}")
      set(_buildLink "${FOAM_LIBRARY_OUTPUT_DIRECTORY}/plugins/${_libname}")
      file(RELATIVE_PATH _buildLinkTarget
        "${FOAM_LIBRARY_OUTPUT_DIRECTORY}/plugins" "${_lib}")
      # link target for install tree
      file(RELATIVE_PATH _installLinkTarget
        "${FOAM_FRAMEWORK_OUTPUT_DIRECTORY}" "${_lib}")
      set(_installLinkTarget
        "${FOAM_INSTALL_FRAMEWORK_PATH}/${_installLinkTarget}")
    else()
      # get the output location
      get_target_property(_lib ${TARGET} LOCATION)
      # link location and target for build tree
      get_filename_component(_libname ${_lib} NAME)
      set(_buildLink "${FOAM_LIBRARY_OUTPUT_DIRECTORY}/plugins/${_libname}")
      file(RELATIVE_PATH _buildLinkTarget
        "${FOAM_LIBRARY_OUTPUT_DIRECTORY}/plugins" "${_lib}")
      # link target for install tree
      file(RELATIVE_PATH _installLinkTarget
        "${FOAM_INSTALL_PLUGIN_PATH}"
        "${FOAM_INSTALL_LIBRARY_PATH}/${_libname}")
      if(DEFINED FOAM_SOVERSION)
        set(_installLinkTarget "${_installLinkTarget}.${FOAM_SOVERSION}")
      endif()
    endif()
    # link location for install tree
    set(_installLibDir
      "${CMAKE_BINARY_DIR}/InstallFiles/lib/FreeFOAM-${FOAM_VERSION_FULL}")
    set(_installLink "${_installLibDir}/plugins/${_libname}")
    # create the links
    file(MAKE_DIRECTORY "${_installLibDir}/plugins")
    file(MAKE_DIRECTORY "${FOAM_LIBRARY_OUTPUT_DIRECTORY}/plugins")
    add_custom_command(OUTPUT ${_buildLink} ${_installLink}
      COMMAND "${CMAKE_COMMAND}" -E remove -f "${_buildLink}" "${_installLink}"
      COMMAND "${CMAKE_COMMAND}" -E create_symlink
        ${_buildLinkTarget} "${_buildLink}"
      COMMAND "${CMAKE_COMMAND}" -E create_symlink
        ${_installLinkTarget} "${_installLink}"
      DEPENDS ${TARGET}
      COMMENT "Creating plugin links for ${TARGET}"
      VERBATIM)

    # install the link
    install(FILES ${_installLink}
      DESTINATION ${FOAM_INSTALL_PLUGIN_PATH}
      COMPONENT shlibs)

    # make the custom command run...
    add_custom_target(${TARGET}LoadableLinks ALL
      DEPENDS ${_buildLink} ${_installLink})
  endif()
endfunction()


# remove the list of documented apps from the cache
unset(__FOAM_ADD_EXECUTABLE_TO_DOC_INDEX_targets CACHE)

function(foam_add_executable_to_doc_index target source)
  get_filename_component(f ${source} NAME_WE)
  if(NOT DEFINED DOXYGEN_SOURCE_SEP)
    set(DOXYGEN_SOURCE_SEP _)
  endif()
  set(files "\"${f}_8C.html\" \"${f}_8C${DOXYGEN_SOURCE_SEP}source.html\"")
  set(__FOAM_ADD_EXECUTABLE_TO_DOC_INDEX_targets
    ${__FOAM_ADD_EXECUTABLE_TO_DOC_INDEX_targets} "${target} (${files})"
    CACHE INTERNAL "Files to include in the documentation index"
    )
endfunction()

function(foam_write_doc_index)
  # construct the list of files
  string(REPLACE ";"
    ";\n    " tmp "    ${__FOAM_ADD_EXECUTABLE_TO_DOC_INDEX_targets}")
  # get the version string right
  string(LENGTH ${FOAM_VERSION_FULL} verlength)
  set(verstr "                                                ")
  math(EXPR verspacelength "48-${verlength}")
  string(SUBSTRING "${verstr}" 0 ${verspacelength} verstr)
  set(verstr "${FOAM_VERSION_FULL}${verstr}")
  # write the doc index file
  file(WRITE ${CMAKE_BINARY_DIR}/data/DoxyDocIndex.in
"/*--------------------------------*- C++ -*----------------------------------*\\
|               ______                _     ____          __  __              |
|              |  ____|             _| |_  / __ \\   /\\   |  \\/  |             |
|              | |__ _ __ ___  ___ /     \\| |  | | /  \\  | \\  / |             |
|              |  __| '__/ _ \\/ _ ( (| |) ) |  | |/ /\\ \\ | |\\/| |             |
|              | |  | | |  __/  __/\\_   _/| |__| / ____ \\| |  | |             |
|              |_|  |_|  \\___|\\___|  |_|   \\____/_/    \\_\\_|  |_|             |
|                                                                             |
|                   FreeFOAM: The Cross-Platform CFD Toolkit                  |
|                   Version:  ${verstr}|
|                   Web:      http://freefoam.sourceforge.net                 |
\\*---------------------------------------------------------------------------*/
FoamFile
{
version     2.0;
format      ascii;
class       dictionary;
object      docIndex;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

docDir \"@FOAM_DOC_DIR@/API\";

docFiles {
${tmp};
};

// ********************* vim: set ft=cpp sw=4 sts=4 et: ******************** //
"
      )
  # binary tree
  set(FOAM_DOC_DIR "http://freefoam.sf.net/doc/${FOAM_VERSION_FULL}")
  set(FOAM_LOCAL_DOC_DIR ${CMAKE_BINARY_DIR}/doc)
  if(FOAM_USE_LOCAL_DOXYGEN_DOCS)
    set(FOAM_DOC_DIR ${FOAM_LOCAL_DOC_DIR})
  endif()
  configure_file(${CMAKE_BINARY_DIR}/data/DoxyDocIndex.in
    ${CMAKE_BINARY_DIR}/data/DoxyDocIndex @ONLY)
  # install tree
  set(FOAM_LOCAL_DOC_DIR ${FOAM_INSTALL_DOC_PATH})
  if(FOAM_USE_LOCAL_DOXYGEN_DOCS)
    set(FOAM_DOC_DIR ${FOAM_LOCAL_DOC_DIR})
  endif()
  configure_file(${CMAKE_BINARY_DIR}/data/DoxyDocIndex.in
    ${CMAKE_BINARY_DIR}/InstallFiles/data/DoxyDocIndex @ONLY)
endfunction()


add_custom_target(doc ALL)


function(foam_queue_manpage name source)
  if(NOT FOAM_MANPAGE_FORMATS)
    return()
  endif()
  # make source and deps into absolute paths
  if(NOT IS_ABSOLUTE "${source}")
    set(source "${CMAKE_CURRENT_SOURCE_DIR}/${source}")
  endif()
  set(deps)
  foreach(d IN LISTS ARGN)
    if(NOT IS_ABSOLUTE "${d}")
      set(source "${CMAKE_CURRENT_SOURCE_DIR}/${d}")
    endif()
    list(APPEND deps "${d}")
  endforeach()
  set_property(GLOBAL APPEND PROPERTY FOAM_QUEUED_MANPAGES ${name})
  set_property(GLOBAL PROPERTY FOAM_QUEUED_MANPAGE_${name}_SOURCE "${source}")
  set_property(GLOBAL PROPERTY FOAM_QUEUED_MANPAGE_${name}_DEPS "${deps}")
endfunction()


function(foam_create_manpages)
  if(NOT FOAM_MANPAGE_FORMATS)
    return()
  endif()
  get_property(have_queued GLOBAL PROPERTY FOAM_QUEUED_MANPAGES SET)
  if(NOT have_queued)
    return()
  endif()
  get_property(queued_manpages GLOBAL PROPERTY FOAM_QUEUED_MANPAGES)
  foreach(format ${FOAM_MANPAGE_FORMATS})
    # define output directory
    if(format STREQUAL "manpage")
      set(man_page_dir "${CMAKE_BINARY_DIR}/doc/man/man")
    elseif(format STREQUAL "xhtml")
      set(man_page_dir "${CMAKE_BINARY_DIR}/doc/html/man/man")
    else()
      message(FATAL_ERROR "ERROR: Unsupported manpage format '${format}'")
    endif()

    set(man_out_list)
    foreach(name IN LISTS queued_manpages)
      get_property(source GLOBAL PROPERTY FOAM_QUEUED_MANPAGE_${name}_SOURCE)
      get_property(deps GLOBAL PROPERTY FOAM_QUEUED_MANPAGE_${name}_DEPS)
      if(format STREQUAL xhtml)
        list(APPEND deps
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/xhtml.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-xhtml.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/common.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-common.xsl"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/custom.xsl")
      endif()
      # construct the relative path to the source file
      # and set up the section name
      get_filename_component(f ${source} ABSOLUTE)
      if(f MATCHES "\\.[0-9]+\\.in\\.txt$")
        # if it is a AsciiDoc source, configure it
        string(REGEX MATCH "\\.([0-9]+)\\.in\\.txt$" dummy ${f})
        set(sect ${CMAKE_MATCH_1})
        file(RELATIVE_PATH rel_f "${CMAKE_CURRENT_SOURCE_DIR}" "${f}")
        string(REGEX REPLACE "\\.in\\.txt$" ".txt" source
          "${CMAKE_CURRENT_BINARY_DIR}/${rel_f}")
        configure_file("${f}" "${source}" @ONLY)
      else()
        set(sect "1")
        set(source "${f}")
      endif()

      # create the output directory and construct the output name
      file(MAKE_DIRECTORY "${man_page_dir}${sect}")
      set(man_out "${man_page_dir}${sect}/${name}.${sect}")
      if(format STREQUAL xhtml)
        set(man_out "${man_out}.html")
      endif()

      # run through doxyToX
      if(WIN32)
        set(py_suffix .py)
      else()
        set(py_suffix)
      endif()
      get_filename_component(base_man_out "${man_out}" NAME)
      add_custom_command(
        OUTPUT "${man_out}"
        COMMAND "${PYTHON2_EXECUTABLE}"
          "${CMAKE_BINARY_DIR}/data/utilities/doxyToX${py_suffix}"
          -f ${format} -o "${man_page_dir}${sect}" "${name}" "${source}"
        DEPENDS "${source}"
          "${CMAKE_BINARY_DIR}/data/asciidoc/manpage.conf"
          "${CMAKE_BINARY_DIR}/data/asciidoc/common.conf"
          "${CMAKE_BINARY_DIR}/data/asciidoc/docbook.conf"
          "${CMAKE_SOURCE_DIR}/data/utilities/doxyToX.py.in"
          "${CMAKE_SOURCE_DIR}/data/python/FreeFOAM/doxyToAsciidoc.py"
          ${deps}
        WORKING_DIRECTORY "${man_page_dir}${sect}"
        COMMENT "Creating ${format} help ${base_man_out}"
        VERBATIM)
      # install the generated file
      if(format STREQUAL manpage)
        install(FILES ${man_out}
          DESTINATION ${FOAM_INSTALL_MAN_PATH}/man${sect}
          COMPONENT doc)
      else()
        install(FILES ${man_out}
          DESTINATION ${FOAM_INSTALL_DOC_PATH}/man/man${sect}
          COMPONENT doc)
      endif()
      list(APPEND man_out_list "${man_out}")
    endforeach()

    # add convenience targets
    if(format STREQUAL manpage)
      add_custom_target(man DEPENDS ${man_out_list})
      add_dependencies(doc man)
      # depend on version_check if enabled
      if(FOAM_HAVE_GIT)
        add_dependencies(man version_check)
      endif()
    else()
      add_custom_target(man-xhtml DEPENDS ${man_out_list})
      add_dependencies(doc man-xhtml)
      # depend on version_check if enabled
      if(FOAM_HAVE_GIT)
        add_dependencies(man-xhtml version_check)
      endif()
    endif()
  endforeach()
endfunction()


function(foam_dependent_variables VAR)
  # figure out a good cache name
  set(cacheName "_FOAM_DEPENDENT_VARIABLES__${VAR}")
  # if we're running the first time, initialise to the new value
  if(NOT DEFINED ${cacheName})
    set(${cacheName} "${${VAR}}")
  endif()
  # check for changes
  if(NOT "${${cacheName}}" STREQUAL "${${VAR}}")
    # if there are variables to purge, do so
    foreach(var ${ARGN})
      unset(${var})
      unset(${var} CACHE)
    endforeach()
  endif()
  # set the cache var to the old/new value
  set(${cacheName} "${${VAR}}"
    CACHE INTERNAL "FOAM_DEPENDENT_VARIABLES helper variable")
endfunction()

# helper function for FOAM_CONFIGURE_FILES
function(_set_config_files_variables installTree)
  list(LENGTH FOAM_CONFIGURE_FILES_VARIABLES n)
  math(EXPR n "${n} -1")
  set(offset 1)
  if(installTree)
    set(offset 2)
  endif()
  foreach(i RANGE 0 ${n} 3)
    math(EXPR j "${i}+${offset}")
    list(GET FOAM_CONFIGURE_FILES_VARIABLES ${i} varname)
    list(GET FOAM_CONFIGURE_FILES_VARIABLES ${j} varval)
    set(${varname} "${varval}" PARENT_SCOPE)
  endforeach()
endfunction()

function(foam_configure_files _config_files_installFilesVar)
  # USE MANGLED NAMES to avoid collisions with user-variables
  # in FOAM_CONFIGURE_FILES_VARIABLES.
  #
  # defaults
  set(_config_files_destDir)
  set(_config_files_basename FALSE)
  set(_config_files_copyonly FALSE)
  _foam_set_default(_config_files_strip_suffixes FOAM_STRIP_SUFFIXES "\\.in$")
  set(_config_files_next_destdir FALSE)
  set(_config_files_installFiles)
  # 2-tuples of src;dst
  set(_config_files_copyonly_files)
  set(_config_files_buildtree_files)
  set(_config_files_installtree_files)
  # argument parsing
  foreach(_config_files_a ${ARGN})
    if(_config_files_next_destdir)
      set(_config_files_destDir "${_config_files_a}")
      set(_config_files_next_destdir FALSE)
    elseif(_config_files_a STREQUAL COPYONLY)
      set(_config_files_copyonly TRUE)
      set(_config_files_basename FALSE)
    elseif(_config_files_a STREQUAL DESTDIR)
      set(_config_files_next_destdir TRUE)
      set(_config_files_basename FALSE)
    elseif(_config_files_a STREQUAL BASENAME)
      set(_config_files_basename TRUE)
    else()
      # this is not an option, so it must be a file
      # construct file names and sort into the lists
      if(_config_files_a MATCHES "(.*)==(.*)")
        set(_config_files_src "${CMAKE_MATCH_1}")
        set(_config_files_dst_base "${CMAKE_MATCH_2}")
      else()
        set(_config_files_src "${_config_files_a}")
        set(_config_files_dst_base "${_config_files_a}")
      endif()
      if(_config_files_basename)
        get_filename_component(_config_files_dst_base
          "${_config_files_dst_base}" NAME)
      endif()
      foreach(e ${_config_files_strip_suffixes})
        if("${_config_files_dst_base}" MATCHES "${e}")
          string(REGEX REPLACE "${e}" "" _config_files_dst_base "${_config_files_dst_base}")
          break()
        endif()
      endforeach()
      if(_config_files_destDir)
        set(_config_files_dst_base
          "${_config_files_destDir}/${_config_files_dst_base}")
      endif()
      set(_config_files_buildtree_name
        "${CMAKE_BINARY_DIR}/${_config_files_dst_base}")
      if(_config_files_copyonly)
        list(APPEND _config_files_copyonly_files "${_config_files_src}"
          "${_config_files_buildtree_name}")
      else()
        list(APPEND _config_files_buildtree_files "${_config_files_src}"
          "${_config_files_buildtree_name}")
        list(APPEND _config_files_installtree_files "${_config_files_src}"
          "${CMAKE_BINARY_DIR}/InstallFiles/${_config_files_dst_base}")
      endif()
    endif()
  endforeach()
  # do COPYONLY files
  set(_config_files_installFiles)
  list(LENGTH _config_files_copyonly_files _config_files_ncopyonly)
  math(EXPR _config_files_ncopyonly "${_config_files_ncopyonly} -1")
  if(_config_files_ncopyonly GREATER 0)
    foreach(_config_files_i RANGE 0 ${_config_files_ncopyonly} 2)
      math(EXPR _config_files_j "${_config_files_i}+1")
      list(GET _config_files_copyonly_files ${_config_files_i} _config_files_src)
      list(GET _config_files_copyonly_files ${_config_files_j} _config_files_dst)
      configure_file("${_config_files_src}" "${_config_files_dst}" COPYONLY)
      list(APPEND _config_files_installFiles "${_config_files_dst}")
    endforeach()
  endif()
  # do build-tree files
  _set_config_files_variables(FALSE)
  list(LENGTH _config_files_buildtree_files _config_files_nbuildtree)
  math(EXPR _config_files_nbuildtree "${_config_files_nbuildtree} -1")
  if(_config_files_nbuildtree GREATER 0)
    foreach(_config_files_i RANGE 0 ${_config_files_nbuildtree} 2)
      math(EXPR _config_files_j "${_config_files_i}+1")
      list(GET _config_files_buildtree_files ${_config_files_i} _config_files_src)
      list(GET _config_files_buildtree_files ${_config_files_j} _config_files_dst)
      configure_file("${_config_files_src}" "${_config_files_dst}" @ONLY)
    endforeach()
  endif()
  # do install-tree files
  _set_config_files_variables(TRUE)
  list(LENGTH _config_files_installtree_files _config_files_ninstalltree)
  math(EXPR _config_files_ninstalltree "${_config_files_ninstalltree} -1")
  if(_config_files_ninstalltree GREATER 0)
    foreach(_config_files_i RANGE 0 ${_config_files_ninstalltree} 2)
      math(EXPR _config_files_j "${_config_files_i}+1")
      list(GET _config_files_installtree_files ${_config_files_i} _config_files_src)
      list(GET _config_files_installtree_files ${_config_files_j} _config_files_dst)
      configure_file("${_config_files_src}" "${_config_files_dst}" @ONLY)
      list(APPEND _config_files_installFiles "${_config_files_dst}")
    endforeach()
  endif()
  # return list of names in the install-tree
  set(${_config_files_installFilesVar}
    "${_config_files_installFiles}" PARENT_SCOPE)
endfunction()

function(foam_install_configured_files install_type)
  if(NOT install_type MATCHES "^(FILES|PROGRAMS)$")
    message(FATAL_ERROR "Expected FILES or PROGRAMS")
  endif()
  # argument parsing
  foam_parse_arguments(_ficf "DESTINATION:1;COMPONENT:1" "" ${ARGN})
  # sanity check
  if(NOT _ficf_DEFAULT_ARGS)
    message(FATAL_ERROR "At least one file required")
  elseif(NOT _ficf_DESTINATION)
    message(FATAL_ERROR "DESTINATION <dir> required")
  endif()
  if(_ficf_COMPONENT)
    set(component COMPONENT ${_ficf_COMPONENT})
  else()
    set(component)
  endif()
  # process files
  foreach(f ${_ficf_DEFAULT_ARGS})
    # get subdirectory under InstallFiles
    file(RELATIVE_PATH rf "${CMAKE_BINARY_DIR}/InstallFiles" "${f}")
    # is it really a subdirectory?
    if(rf MATCHES "^\\.\\.")
      file(RELATIVE_PATH rf "${CMAKE_BINARY_DIR}" "${f}")
      if(rf MATCHES "^\\.\\.")
        message(FATAL_ERROR
          "${f} not in a subdirectory of ${CMAKE_BINARY_DIR}/InstallFiles or ${CMAKE_BINARY_DIR}")
      endif()
    endif()
    get_filename_component(p "${rf}" PATH)
    # do it
    install(${install_type} "${f}"
      DESTINATION "${_ficf_DESTINATION}/${p}"
      ${component}
      )
  endforeach()
endfunction()

function(foam_generate_doxygen)
  set(doxyfilters)
  set(noneVar "None")
  foreach(type LIBRARY EXECUTABLE)
    if(type STREQUAL LIBRARY)
      get_property(FOAM_DOXYGEN_TARGETS GLOBAL PROPERTY FOAM_DOXYGEN_LIBRARIES)
      set(var nameVar)
    else()
      get_property(FOAM_DOXYGEN_TARGETS GLOBAL PROPERTY FOAM_DOXYGEN_EXECUTABLES)
      set(var noneVar)
    endif()
    foreach(name ${FOAM_DOXYGEN_TARGETS})
      get_property(target_dir GLOBAL PROPERTY FOAM_DOXYGEN_${name}_${type}_DIR)
      set(nameVar "'${name}'")
      set(doxyfilters
        "${doxyfilters}'${target_dir}/.*': ${${var}},\n")
    endforeach()
  endforeach()
  set(doxyfilters "${doxyfilters}" PARENT_SCOPE)
endfunction()

function(foam_create_app_brief name section source)
  set_property(GLOBAL APPEND PROPERTY FOAM_APP_BRIEF_${section}_APPS ${name})
  if(NOT IS_ABSOLUTE "${source}")
    set(source "${CMAKE_CURRENT_SOURCE_DIR}/${source}")
  endif()
  set_property(GLOBAL PROPERTY FOAM_APP_BRIEF_${name}_SOURCE "${source}")
endfunction()

function(foam_add_app_section name string)
  set_property(GLOBAL APPEND PROPERTY FOAM_APP_BRIEF_SECTIONS ${name})
  set_property(GLOBAL PROPERTY FOAM_APP_BRIEF_${name}_SECTION_STRING
    "${string}")
endfunction()

function(foam_extract_brief_docs outfile)
  if(NOT FOAM_MANPAGE_FORMATS)
    return()
  endif()
  if(WIN32)
    set(py_suffix .py)
  else()
    set(py_suffix)
  endif()
  if(NOT IS_ABSOLUTE ${outfile})
    set(outfile "${CMAKE_CURRENT_BINARY_DIR}/${outfile}")
  endif()
  get_property(sections GLOBAL PROPERTY FOAM_APP_BRIEF_SECTIONS)
  set(sources)
  set(FOAM_CONFIGURABLE_CONTENT "set(FOAM_CONFIGURABLE_CONTENT)")
  foreach(section IN LISTS sections)
    get_property(section_string GLOBAL PROPERTY
      FOAM_APP_BRIEF_${section}_SECTION_STRING)
    # write section string
    set(FOAM_CONFIGURABLE_CONTENT "${FOAM_CONFIGURABLE_CONTENT}
set(FOAM_CONFIGURABLE_CONTENT \"\${FOAM_CONFIGURABLE_CONTENT}
${section_string}\n\")
")
    # iterate over apps in section
    get_property(apps GLOBAL PROPERTY FOAM_APP_BRIEF_${section}_APPS)
    foreach(app IN LISTS apps)
      get_property(source GLOBAL PROPERTY FOAM_APP_BRIEF_${app}_SOURCE)
      list(APPEND sources ${source})
      set(FOAM_CONFIGURABLE_CONTENT "${FOAM_CONFIGURABLE_CONTENT}\n
set(source \"${source}\")
execute_process(
  COMMAND \"${PYTHON_EXECUTABLE}\"
  \"${CMAKE_BINARY_DIR}/data/utilities/extractBrief${py_suffix}\"
  \"${FOAM_EXE_PREFIX}${app}\" \"\${source}\"
  WORKING_DIRECTORY \"${CMAKE_CURRENT_SOURCE_DIR}\"
  RESULT_VARIABLE result
  OUTPUT_VARIABLE brief
  ERROR_VARIABLE brief
  OUTPUT_STRIP_TRAILING_WHITESPACE)
if(NOT result)
  set(FOAM_CONFIGURABLE_CONTENT \"\${FOAM_CONFIGURABLE_CONTENT}\${brief}\\n\")
else()
  message(FATAL_ERROR \"Running extractBrief on '\${source}' failed:\\n\${brief}\")
endif()")
    endforeach()
  endforeach()
  set(FOAM_CONFIGURABLE_CONTENT "${FOAM_CONFIGURABLE_CONTENT}
configure_file(\"${CMAKE_SOURCE_DIR}/CMake/FOAMConfigurableFile.in\"
  \"${outfile}\" @ONLY)")
  configure_file(${CMAKE_SOURCE_DIR}/CMake/FOAMConfigurableFile.in
    ${CMAKE_CURRENT_BINARY_DIR}/ExtractBriefDocs.cmake @ONLY)
  add_custom_command(OUTPUT "${outfile}"
    COMMAND "${CMAKE_COMMAND}"
      -P ${CMAKE_CURRENT_BINARY_DIR}/ExtractBriefDocs.cmake
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/ExtractBriefDocs.cmake ${sources}
    COMMENT "Extracting brief application descriptions"
    VERBATIM)
endfunction()

function(foam_compile_asy outvar formats)
  if(NOT ASY_EXECUTABLE)
    message(SEND_ERROR "ASY_EXECUTABLE must be set")
  endif()
  set(output)
  foreach(f IN LISTS ARGN)
    if(IS_ABSOLUTE "${f}")
      file(RELATIVE_PATH f "${CMAKE_CURRENT_SOURCE_DIR}" "${f}")
    endif()
    get_filename_component(d "${f}" PATH)
    get_filename_component(ff "${f}" NAME_WE)
    foreach(fmt IN LISTS formats)
      string(REPLACE ".asy" ".${fmt}" o "${CMAKE_CURRENT_BINARY_DIR}/${f}")
      get_filename_component(bo "${o}" NAME)
      set(tmpdir
        "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${ff}_${fmt}.dir")
      if(NOT IS_DIRECTORY "${tmpdir}")
        file(MAKE_DIRECTORY "${tmpdir}")
      endif()
      get_source_file_property(deps ${f} OBJECT_DEPENDS)
      if(deps STREQUAL NOTFOUND)
        set(deps)
      endif()
      list(INSERT deps 0 ${f})
      foreach(dep IN LISTS deps)
        if(NOT IS_ABSOLUTE "${dep}")
          set(dep "${CMAKE_CURRENT_SOURCE_DIR}/${dep}")
        endif()
        file(RELATIVE_PATH rdep "${CMAKE_CURRENT_SOURCE_DIR}/${d}" "${dep}")
        configure_file("${dep}" "${tmpdir}/${rdep}" COPYONLY)
      endforeach()
      add_custom_command(OUTPUT "${o}"
        COMMAND "${ASY_EXECUTABLE}" -f${fmt} -tex pdflatex "${ff}"
        COMMAND "${CMAKE_COMMAND}" -E rename
          ${bo} "${o}"
        DEPENDS ${deps}
        WORKING_DIRECTORY "${tmpdir}"
        COMMENT "Creating Asymptote graphics ${bo}"
        VERBATIM)
      list(APPEND output "${o}")
    endforeach()
  endforeach()
  set(${outvar} "${output}" PARENT_SCOPE)
endfunction()

function(foam_fix_apple_gcc_bug)
  if(APPLE AND CMAKE_COMPILER_IS_GNUCXX AND NOT DEFINED _FOAM_APPLE_GCC_BUGFIX)
    set(_FOAM_APPLE_GCC_BUGFIX TRUE CACHE INTERNAL "Apple GCC bug checked")
    execute_process(COMMAND "${CMAKE_CXX_COMPILER}" --version
      OUTPUT_VARIABLE output
      ERROR_VARIABLE  output
      )
    if(output MATCHES "4\\.2\\.1 \\(Apple Inc\\.")
      # only override if not changed by user
      if(CMAKE_CXX_FLAGS_RELEASE STREQUAL "${CMAKE_CXX_FLAGS_RELEASE_INIT}")
        message(WARNING
          "Apple GCC-4.2.1 detected\n"
          "Replacing -O3 by -O2 in CMAKE_CXX_FLAGS_RELEASE")
        string(REPLACE "-O3" "-O2" CMAKE_CXX_FLAGS_RELEASE
          "${CMAKE_CXX_FLAGS_RELEASE}")
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}" CACHE STRING
          "Flags used by the compiler during release builds" FORCE)
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}" PARENT_SCOPE)
      endif()
    endif()
  endif()
endfunction()

endif()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
