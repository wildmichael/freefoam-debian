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
  engineTime/engineTime.C
  ignition/ignition.C
  ignition/ignitionIO.C
  ignition/ignitionSite.C
  ignition/ignitionSiteIO.C
  engineValve/engineValve.C
  enginePiston/enginePiston.C
  engineMesh/engineMesh/engineMesh.C
  engineMesh/engineMesh/newEngineMesh.C
  engineMesh/staticEngineMesh/staticEngineMesh.C
  engineMesh/layeredEngineMesh/layeredEngineMesh.C
  engineMesh/fvMotionSolverEngineMesh/fvMotionSolverEngineMesh.C
  )

set(HDRS
  engineMesh/engineMesh/engineMesh.H
  engineMesh/fvMotionSolverEngineMesh/fvMotionSolverEngineMesh.H
  engineMesh/layeredEngineMesh/layeredEngineMesh.H
  engineMesh/staticEngineMesh/staticEngineMesh.H
  enginePiston/enginePiston.H
  engineTime/engineTime.H
  engineValve/engineValve.H
  engineValve/valveBank.H
  ignition/ignite.H
  ignition/ignition.H
  ignition/ignitionSite.H
  include/StCorr.H
  include/createEngineMesh.H
  include/createEngineTime.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
