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


foam_add_app_section(sol_dns "== SOLVERS ==\n=== DNS ===")
set(FOAM_APP_SECTION sol_dns)
add_subdirectory(DNS)

foam_add_app_section(sol_basic "=== Basic Solvers ===")
set(FOAM_APP_SECTION sol_basic)
add_subdirectory(basic)

foam_add_app_section(sol_combustion "=== Combustion Solvers ===")
set(FOAM_APP_SECTION sol_combustion)
add_subdirectory(combustion)

foam_add_app_section(sol_compressible "=== Compressible Flow Solvers ===")
set(FOAM_APP_SECTION sol_compressible)
add_subdirectory(compressible)

foam_add_app_section(sol_electromag "=== Electromagnetic Solvers ===")
set(FOAM_APP_SECTION sol_electromag)
add_subdirectory(electromagnetics)

foam_add_app_section(sol_financial "=== Financial Solvers ===")
set(FOAM_APP_SECTION sol_financial)
add_subdirectory(financial)

foam_add_app_section(sol_heattran "=== Heat Transfer Solvers ===")
set(FOAM_APP_SECTION sol_heattran)
add_subdirectory(heatTransfer)

foam_add_app_section(sol_incompressible "=== Incompressible Flow Solvers ===")
set(FOAM_APP_SECTION sol_incompressible)
add_subdirectory(incompressible)

foam_add_app_section(sol_discrete "=== Discrete Methods Solvers ===")
set(FOAM_APP_SECTION sol_discrete)
add_subdirectory(discreteMethods)

foam_add_app_section(sol_lagrangian "=== Lagrangian Solvers ===")
set(FOAM_APP_SECTION sol_lagrangian)
add_subdirectory(lagrangian)

foam_add_app_section(sol_multiphase "=== Multiphase Solvers ===")
set(FOAM_APP_SECTION sol_multiphase)
add_subdirectory(multiphase)

foam_add_app_section(sol_stress "=== Stress-Analysis ===")
set(FOAM_APP_SECTION sol_stress)
add_subdirectory(stressAnalysis)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
