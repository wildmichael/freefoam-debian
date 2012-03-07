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
  chemistryModel/basicChemistryModel/basicChemistryModel.C
  chemistryModel/psiChemistryModel/psiChemistryModel.C
  chemistryModel/psiChemistryModel/newPsiChemistryModel.C
  chemistryModel/psiChemistryModel/psiChemistryModels.C
  chemistryModel/rhoChemistryModel/rhoChemistryModel.C
  chemistryModel/rhoChemistryModel/newRhoChemistryModel.C
  chemistryModel/rhoChemistryModel/rhoChemistryModels.C
  chemistrySolver/chemistrySolver/makeChemistrySolvers.C
  )

set(HDRS
  chemistryModel/ODEChemistryModel/ODEChemistryModel.C
  chemistryModel/ODEChemistryModel/ODEChemistryModel.H
  chemistryModel/ODEChemistryModel/ODEChemistryModelI.H
  chemistryModel/basicChemistryModel/basicChemistryModel.H
  chemistryModel/basicChemistryModel/basicChemistryModelI.H
  chemistryModel/basicChemistryModel/makeChemistryModel.H
  chemistryModel/psiChemistryModel/psiChemistryModel.H
  chemistryModel/psiChemistryModel/psiChemistryModelI.H
  chemistryModel/rhoChemistryModel/rhoChemistryModel.H
  chemistryModel/rhoChemistryModel/rhoChemistryModelI.H
  chemistrySolver/EulerImplicit/EulerImplicit.C
  chemistrySolver/EulerImplicit/EulerImplicit.H
  chemistrySolver/chemistrySolver/chemistrySolver.C
  chemistrySolver/chemistrySolver/chemistrySolver.H
  chemistrySolver/chemistrySolver/newChemistrySolver.C
  chemistrySolver/ode/ode.C
  chemistrySolver/ode/ode.H
  chemistrySolver/sequential/sequential.C
  chemistrySolver/sequential/sequential.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
