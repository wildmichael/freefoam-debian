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

set(SRCS
  dynamicFvMesh/dynamicFvMesh.C
  dynamicFvMesh/newDynamicFvMesh.C
  staticFvMesh/staticFvMesh.C
  dynamicMotionSolverFvMesh/dynamicMotionSolverFvMesh.C
  dynamicInkJetFvMesh/dynamicInkJetFvMesh.C
  dynamicRefineFvMesh/dynamicRefineFvMesh.C
  solidBodyMotionFvMesh/solidBodyMotionFvMesh.C
  solidBodyMotionFvMesh/solidBodyMotionFunctions/solidBodyMotionFunction/solidBodyMotionFunction.C
  solidBodyMotionFvMesh/solidBodyMotionFunctions/solidBodyMotionFunction/newSolidBodyMotionFunction.C
  solidBodyMotionFvMesh/solidBodyMotionFunctions/SDA/SDA.C
  solidBodyMotionFvMesh/solidBodyMotionFunctions/SKA/SKA.C
  )

set(HDRS
  dynamicFvMesh/dynamicFvMesh.H
  dynamicInkJetFvMesh/dynamicInkJetFvMesh.H
  dynamicMotionSolverFvMesh/dynamicMotionSolverFvMesh.H
  dynamicRefineFvMesh/dynamicRefineFvMesh.H
  include/createDynamicFvMesh.H
  include/meshCourantNo.H
  solidBodyMotionFvMesh/solidBodyMotionFunctions/SDA/SDA.H
  solidBodyMotionFvMesh/solidBodyMotionFunctions/SKA/SKA.H
  solidBodyMotionFvMesh/solidBodyMotionFunctions/solidBodyMotionFunction/solidBodyMotionFunction.H
  solidBodyMotionFvMesh/solidBodyMotionFvMesh.H
  staticFvMesh/staticFvMesh.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
