# - Internal function for FreeFOAM
#
#  FOAM_OPTION(<var> <short> <description> <value>)
#
# Like OPTION(<var> <description> <value>), but also adds the variable <var>
# with the short description <short> to the feature-summary table.
#
#  FOAM_INSTALLATION_PATH(<var> <path> <short> <description>)
#
# Like SET(<var> <path> CACHE PATH <description>), but also adds the variable
# <var> with the short description <short> to the feature-summary table.
# Further if the value of <var> is not an absolute path, it computes the
# absolute path and assigns it to the <var> in the parent scope.
#
#  FOAM_CONDITIONAL_COMPONENT(<name> <enabled> <subdir> <reason>)
#
# Like ADD_SUBDIRECTORY(<subdir>) but if <enabled> evaulates to FALSE, <name>
# is entered as being disabled because of <reason> into the feature-summary
# table.
#
#  FOAM_PRINT_FEATURE_SUMMARY()
#
# Prints summaries of enabled/disabled features, installation paths and
# disabled components.
#
#  FOAM_TARGET_LINK_LIBRARIES(<target> item1 [item2 [...]]
#                             [[debug|optimized|general] <item>] ...)
#
# Like target_link_libraries() but explicitly sets the LINK_INTERFACE_LIBRARIES
# property to exclude the third-party libraries.
#
#  FOAM_ADD_TUTORIAL_TESTS()
#
# Adds the individual cases of the tutorial in the current source directory as
# tests. It runs the configured Allrun script in the directory with the --cases
# option to obtain a list of cases, and adds each of them as a test. Each case
# depends on its predecessor.
#
#  FOAM_DETERMINE_PYTHON_VERSION(<VERSION_VAR> <PYTHON_EXECUTABLE>)
#
# Determines the version of the Python interpreter in <PYTHON_EXECUTABLE> and
# returns the result in the variable <VERSION_VAR>.
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
#   Internal CMake functions for FreeFOAM
#
#-------------------------------------------------------------------------------

function(foam_option var short description value)
  _foam_set_feature_property("OPTION" ${var} "${short}")
  option(${var} "${description}" ${value})
endfunction()

function(foam_installation_path var value short description)
  _foam_set_feature_property("PATH" ${var} "${short}")
  set(${var} ${value} CACHE PATH "${description}")
  mark_as_advanced(${var})
  set(${var}_ORIG ${${var}} PARENT_SCOPE)
  # make absolute path
  if(NOT IS_ABSOLUTE "${${var}}")
    set(${var} "${CMAKE_INSTALL_PREFIX}/${${var}}" PARENT_SCOPE)
  endif()
endfunction()

macro(foam_conditional_component name enabled subdir description)
  if(${enabled})
    add_subdirectory(${subdir})
  else()
    _foam_set_feature_property("COMPONENT" ${name} "${description}")
  endif()
endmacro()

function(_foam_set_feature_property type var short)
  set_property(GLOBAL APPEND PROPERTY FOAM_FEATURES ${var})
  set_property(GLOBAL PROPERTY FOAM_FEATURES_${var}_COMMENT "${short}")
  set_property(GLOBAL PROPERTY FOAM_FEATURES_${var}_TYPE "${type}")
endfunction()

function(foam_print_feature_summary)
  set(OPTION_msg "Feature Summary:")
  set(PATH_msg "Installation Directories:")
  set(COMPONENT_msg "Disabled Components:")
  get_property(features GLOBAL PROPERTY FOAM_FEATURES)
  set(OPTION_len 0)
  set(OPTION_space)
  set(PATH_len 0)
  set(PATH_space)
  set(COMPONENT_len 0)
  set(COMPONENT_space)
  foreach(f ${features})
    get_property(desc GLOBAL PROPERTY FOAM_FEATURES_${f}_COMMENT)
    get_property(type GLOBAL PROPERTY FOAM_FEATURES_${f}_TYPE)
    if(NOT type STREQUAL "COMPONENT")
      string(LENGTH "${desc}" l)
    else()
      string(LENGTH "${f}" l)
    endif()
    if(l GREATER ${${type}_len})
      set(${type}_len ${l})
      set(${type}_space "${desc}")
    endif()
  endforeach()
  string(REGEX REPLACE "." " " OPTION_space "${OPTION_space}")
  string(REGEX REPLACE "." " " PATH_space "${PATH_space}")
  string(REGEX REPLACE "." " " COMPONENT_space "${COMPONENT_space}")
  foreach(f ${features})
    get_property(desc GLOBAL PROPERTY FOAM_FEATURES_${f}_COMMENT)
    get_property(type GLOBAL PROPERTY FOAM_FEATURES_${f}_TYPE)
    if(NOT type STREQUAL "COMPONENT")
      string(LENGTH "${desc}" l)
    else()
      string(LENGTH "${f}" l)
    endif()
    math(EXPR l "${${type}_len} - ${l}")
    string(SUBSTRING "${${type}_space}" 0 ${l} s)
    if(type STREQUAL "OPTION")
      if(${${f}})
        set(value ON)
      else()
        set(value OFF)
      endif()
    else()
      set(value "${${f}}")
    endif()
    if(NOT type STREQUAL "COMPONENT")
      set(${type}_msg "${${type}_msg}\n     ${desc}${s}  ${value}")
    else()
      set(${type}_msg "${${type}_msg}\n     ${f}${s}  ${desc}")
    endif()
  endforeach()
  message(STATUS "${OPTION_msg}\n")
  message(STATUS "${PATH_msg}\n")
  message(STATUS "${COMPONENT_msg}\n")
endfunction()

function(foam_target_link_libraries target)
  set(libs "${ARGN}")
  target_link_libraries(${target} ${libs})
  get_property(tp_libs GLOBAL PROPERTY FOAM_THIRDPARTY_LIBRARIES)
  if(tp_libs)
    list(REMOVE_ITEM libs ${tp_libs})
    set_target_properties(${target} PROPERTIES
      LINK_INTERFACE_LIBRARIES "${libs}")
  endif()
endfunction()

function(foam_add_tutorial_tests)
  if(NOT BUILD_TESTING)
    return()
  endif()
  set(allrun_script
    "${CMAKE_CURRENT_BINARY_DIR}/Allrun${FOAM_PY_SCRIPT_SUFFIX}")
  if(NOT EXISTS ${allrun_script})
    message(FATAL_ERROR
      "No Allrun script configured in ${CMAKE_CURRENT_SOURCE_DIR}")
    return()
  endif()
  execute_process(
    COMMAND "${PYTHON_EXECUTABLE}" "${allrun_script}" --cases
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    RESULT_VARIABLE result
    OUTPUT_VARIABLE cases
    ERROR_VARIABLE errmsg
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  if(result)
    message(SEND_ERROR "Error running Allrun --cases:\n${errmsg}")
    return()
  endif()
  string(REPLACE "\n" ";" cases "${cases}")
  set(last_c)
  if(NOT FOAM_ENABLE_FULL_TUTORIAL_TESTS)
    set(testarg --test)
  else()
    set(testarg)
  endif()
  foreach(c ${cases})
    add_test(NAME ${c} COMMAND ${PYTHON_EXECUTABLE} ${allrun_script}
      ${testarg} --verbose ${c})
    if(last_c)
      set_tests_properties(${c} PROPERTIES DEPENDS ${last_c})
    endif()
    set(last_c ${c})
  endforeach()
  foreach(c ${cases})
    add_test(NAME ${c}_clean COMMAND ${PYTHON_EXECUTABLE} ${allrun_script}
      --clean)
    set_tests_properties(${c}_clean PROPERTIES DEPENDS ${last_c})
  endforeach()
endfunction()

function(foam_determine_python_version VERSION_VAR EXECUTABLE)
  execute_process(
    COMMAND ${EXECUTABLE} -c
    "import sys; sys.stdout.write('%s.%s.%s\\n'%sys.version_info[0:3])"
    RESULT_VARIABLE version_result
    OUTPUT_VARIABLE version_output
    ERROR_VARIABLE version_output
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  if(NOT version_result)
    string(REGEX MATCH "([0-9]+\\.)+[0-9]+" version
      "${version_output}")
    message(STATUS "Python version ${version} found")
  else()
    set(version ${VERSION_VAR}-NOTFOUND)
    message(SEND_ERROR
      "Failed to determine the python version: ${version_output}")
  endif()
  set(${VERSION_VAR} ${version} PARENT_SCOPE)
endfunction()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
