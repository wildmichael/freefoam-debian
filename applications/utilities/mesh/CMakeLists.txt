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

foam_add_app_section(util_mesh_adv
  "== UTILITIES ==\n=== Advanced Mesh Manipulation ===")
set(FOAM_APP_SECTION util_mesh_adv)
add_subdirectory(advanced)

foam_add_app_section(util_mesh_conv "=== Mesh Conversion ===")
set(FOAM_APP_SECTION util_mesh_conv)
add_subdirectory(conversion)

foam_add_app_section(util_mesh_gen "=== Mesh Generation ===")
set(FOAM_APP_SECTION util_mesh_gen)
add_subdirectory(generation)

foam_add_app_section(util_mesh_manip "=== Mesh Manipulation ===")
set(FOAM_APP_SECTION util_mesh_manip)
add_subdirectory(manipulation)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
