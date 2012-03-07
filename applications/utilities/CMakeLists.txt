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

add_subdirectory(mesh)

foam_add_app_section(util_error_est "=== Error Estimation ===")
set(FOAM_APP_SECTION util_error_est)
add_subdirectory(errorEstimation)

foam_add_app_section(util_misc "=== Miscellaneous Utilities ===")
set(FOAM_APP_SECTION util_misc)
add_subdirectory(miscellaneous)

foam_add_app_section(util_parallel "=== Parallel Processing ===")
set(FOAM_APP_SECTION util_parallel)
add_subdirectory(parallelProcessing)

add_subdirectory(postProcessing)

foam_add_app_section(util_pre_proc "=== Pre-Processing ===")
set(FOAM_APP_SECTION util_pre_proc)
add_subdirectory(preProcessing)

foam_add_app_section(util_surf "=== Surface File Manipulation ===")
set(FOAM_APP_SECTION util_surf)
add_subdirectory(surface)

foam_add_app_section(util_thermo "=== Thermophysical Utilities ===")
set(FOAM_APP_SECTION util_thermo)
add_subdirectory(thermophysical)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
