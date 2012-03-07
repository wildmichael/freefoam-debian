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

set(FOAM_APP_SECTION util_data_conv)
add_subdirectory(dataConversion)

foam_add_app_section(util_post_proc "=== Post-Processing ===")
set(FOAM_APP_SECTION util_post_proc)
add_subdirectory(foamCalc)

foam_add_app_section(util_data_conv "==== Data Conversion ====")

add_subdirectory(graphics)

foam_add_app_section(util_post_misc "==== Miscellaneous ====")
set(FOAM_APP_SECTION util_post_misc)
add_subdirectory(miscellaneous)

foam_add_app_section(util_sample
  "==== Data Sampling, Averaging and Integration ====")
set(FOAM_APP_SECTION util_sample)
add_subdirectory(patch)
add_subdirectory(sampling)
add_subdirectory(scalarField)

foam_add_app_section(util_stress "==== Stress Analysis ====")
set(FOAM_APP_SECTION util_stress)
add_subdirectory(stressField)

foam_add_app_section(util_turb "==== Turbulence Quantities ====")
set(FOAM_APP_SECTION util_turb)
add_subdirectory(turbulence)

foam_add_app_section(util_flow "==== Flow Field Quantities ====")
set(FOAM_APP_SECTION util_flow)
add_subdirectory(velocityField)

foam_add_app_section(util_wall "==== Wall Quantities ====")
set(FOAM_APP_SECTION util_wall)
add_subdirectory(wall)
set(FOAM_APP_SECTION util_post_proc)
add_subdirectory(lagrangian)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
