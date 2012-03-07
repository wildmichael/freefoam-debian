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

# Do feature detection
# ~~~~~~~~~~~~~~~~~~~~

include(CheckCXXSourceCompiles)
include(CheckVariableExists)
include(CheckIncludeFile)
include(CheckFunctionExists)

# look for __malloc_hook
check_variable_exists(__malloc_hook FOAM_HAVE_MALLOC_HOOK)

# look for fenv.h
check_include_file(fenv.h FOAM_HAVE_FENV_H)

# look for feenableexcept
check_function_exists(feenableexcept FOAM_HAVE_FEENABLEEXCEPT)

# look for sigfpe.h
check_include_file(sigfpe.h FOAM_HAVE_SIGFPE_H)

# look for handle_sigfpes
check_function_exists(handle_sigfpes FOAM_HAVE_HANDLE_SIGFPES)

# OS specific strings
# ~~~~~~~~~~~~~~~~~~~

# file suffix for python executables
if(WIN32)
  set(FOAM_PY_SCRIPT_SUFFIX ".py")
else(WIN32)
  set(FOAM_PY_SCRIPT_SUFFIX "")
endif(WIN32)

# Do system detection
# ~~~~~~~~~~~~~~~~~~~
if(UNIX)
  execute_process(COMMAND uname -s OUTPUT_VARIABLE FOAM_OSNAME OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process(COMMAND uname -m OUTPUT_VARIABLE FOAM_CPUNAME OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
  message(FATAL_ERROR "${CMAKE_PROJECT_NAME} only runs under UNIX-like systems (Linux, Solaris, Mac OS X,...)")
endif()

# 64 bit possible?
set(FOAM_DEFAULT_64_BIT OFF)
if(FOAM_CPUNAME MATCHES ".*64" OR FOAM_OSNAME MATCHES ".*64")
  set(FOAM_DEFAULT_64_BIT ON)
  option(FOAM_64_BIT "Compile ${CMAKE_PROJECT_NAME} in 64 bit." ${FOAM_DEFAULT_64_BIT})
  mark_as_advanced(FOAM_64_BIT)
else()
  set(FOAM_64_BIT ${FOAM_DEFAULT_64_BIT})
endif()


# linux
#~~~~~~
if(FOAM_OSNAME STREQUAL Linux)
  if(FOAM_CPUNAME STREQUAL i686)
    set(FOAM_OS linux)
  elseif(FOAM_CPUNAME STREQUAL x86_64)
    if(FOAM_64_BIT)
      set(FOAM_OS linux64)
    else()
      set(FOAM_OS linux)
    endif()
  elseif(FOAM_CPUNAME STREQUAL ia64)
    set(FOAM_OS linuxIA64)
  elseif(FOAM_CPUNAME STREQUAL mips64)
    set(FOAM_OS SiCortex64)
  else()
    message(STATUS  Unknown processor type ${FOAM_CPUNAME} for Linux)
  endif()

  set(LINUX_LINK_OPTS)
  if(FOAM_OS STREQUAL linux)
    set(LINUX_COMPILE_OPTS -m32)
  elseif(FOAM_OS STREQUAL linux64)
    set(LINUX_COMPILE_OPTS -m64)
  elseif(FOAM_OS STREQUAL SiCortex64)
    set(LINUX_COMPILE_OPTS -mabi=64)
    set(LINUX_LINK_OPTS  -G0)
  else()
    set(LINUX_COMPILE_OPTS)
  endif()

  set(CMAKE_C_FLAGS ${LINUX_COMPILE_OPTS} ${LINUX_LINK_OPTS} CACHE STRING
    "Flags for C compiler.")
  set(CMAKE_CXX_FLAGS ${LINUX_COMPILE_OPTS} ${LINUX_LINK_OPTS} CACHE STRING
    "Flags used by the compiler during all build types.")
  set(CMAKE_SHARED_LINKER_FLAGS ${LINUX_COMPILE_OPTS} ${LINUX_LINK_OPTS} CACHE STRING
    "Flags used by the linker during the creation of shared libs.")

# SUN workstation
# ~~~~~~~~~~~~~~~
elseif(FOAM_OSNAME STREQUAL SunOS)
  set(FOAM_OS SunOS64)
  set(SUNOS_COMPILE_FLAGS -mabi=64)
  set(CMAKE_C_FLAGS ${SUNOS_COMPILE_OPTS} CACHE STRING
    "Flags for C compiler.")
  set(CMAKE_CXX_FLAGS ${SUNOS_COMPILE_OPTS} CACHE STRING
    "Flags used by the compiler during all build types.")
  set(CMAKE_SHARED_LINKER_FLAGS ${SUNOS_COMPILE_OPTS} -G0 CACHE STRING
    "Flags used by the linker during the creation of shared libs.")

# Silicon Graphics workstation
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
elseif(FOAM_OSNAME STREQUAL IRIX OR FOAM_OSNAME STREQUAL IRIX64)

  if(FOAM_64_BIT)
    set(FOAM_OS sgi64)
  else()
    set(FOAM_OS sgiN32)
  endif()

  set(FOAM_DEFAULT_MPLIB_NAME MPICH-GM)

# Mac OS X 10.4/5 Darwin
# ~~~~~~~~~~~~~~~~~~~~
elseif(FOAM_OSNAME STREQUAL Darwin)

  execute_process(COMMAND arch OUTPUT_VARIABLE FOAM_ARCH OUTPUT_STRIP_TRAILING_WHITESPACE)
  if(FOAM_ARCH STREQUAL i386)
    set(FOAM_ARCH Intel)
  elseif(FOAM_ARCH STREQUAL ppc)
    set(FOAM_ARCH Ppc)
  endif()
  set(FOAM_OS darwin${FOAM_ARCH})

  foam_fix_apple_gcc_bug()

# An unsupported operating system
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
else()

  message(STATUS "Your ${FOAM_OSNAME} operating system is not supported
  by this release of FreeFOAM. Things might work out of the box if you're
  lucky, require some tweaking or just blow up into your face. For further
  assistance please contact http://freefoam.sf.net.")

  set(FOAM_OS generic)

endif()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
