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
  interactionLists/referralLists/sendingReferralList.C
  interactionLists/referralLists/receivingReferralList.C
  interactionLists/referredCellList/referredCellList.C
  interactionLists/referredCell/referredCell.C
  interactionLists/referredMolecule/referredMolecule.C
  interactionLists/directInteractionList/directInteractionList.C
  interactionLists/interactionLists.C
  reducedUnits/reducedUnits.C
  reducedUnits/reducedUnitsIO.C
  molecule/molecule.C
  molecule/moleculeIO.C
  moleculeCloud/moleculeCloud.C
  )

set(HDRS
  interactionLists/directInteractionList/directInteractionList.H
  interactionLists/directInteractionList/directInteractionListI.H
  interactionLists/interactionLists.H
  interactionLists/interactionListsI.H
  interactionLists/referralLists/receivingReferralList.H
  interactionLists/referralLists/receivingReferralListI.H
  interactionLists/referralLists/sendingReferralList.H
  interactionLists/referralLists/sendingReferralListI.H
  interactionLists/referredCell/referredCell.H
  interactionLists/referredCell/referredCellI.H
  interactionLists/referredCellList/referredCellList.H
  interactionLists/referredCellList/referredCellListI.H
  interactionLists/referredMolecule/referredMolecule.H
  interactionLists/referredMolecule/referredMoleculeI.H
  mdTools/averageMDFields.H
  mdTools/calculateAutoCorrelationFunctions.H
  mdTools/calculateMDFields.H
  mdTools/calculateTransportProperties.H
  mdTools/createAutoCorrelationFunctions.H
  mdTools/createMDFields.H
  mdTools/createRefUnits.H
  mdTools/md.H
  mdTools/meanMomentumEnergyAndNMols.H
  mdTools/resetMDFields.H
  mdTools/temperatureAndPressure.H
  mdTools/temperatureAndPressureVariables.H
  mdTools/temperatureEquilibration.H
  molecule/molecule.H
  molecule/moleculeI.H
  moleculeCloud/moleculeCloud.H
  moleculeCloud/moleculeCloudI.H
  reducedUnits/reducedUnits.H
  reducedUnits/reducedUnitsI.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
