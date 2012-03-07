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
  potential/potential.C
  pairPotential/pairPotentialList/pairPotentialList.C
  pairPotential/basic/pairPotential.C
  pairPotential/basic/pairPotentialIO.C
  pairPotential/basic/newPairPotential.C
  pairPotential/derived/lennardJones/lennardJones.C
  pairPotential/derived/maitlandSmith/maitlandSmith.C
  pairPotential/derived/azizChen/azizChen.C
  pairPotential/derived/exponentialRepulsion/exponentialRepulsion.C
  pairPotential/derived/coulomb/coulomb.C
  pairPotential/derived/dampedCoulomb/dampedCoulomb.C
  pairPotential/derived/noInteraction/noInteraction.C
  energyScalingFunction/basic/energyScalingFunction.C
  energyScalingFunction/basic/newEnergyScalingFunction.C
  energyScalingFunction/derived/shifted/shifted.C
  energyScalingFunction/derived/shiftedForce/shiftedForce.C
  energyScalingFunction/derived/noScaling/noScaling.C
  energyScalingFunction/derived/sigmoid/sigmoid.C
  energyScalingFunction/derived/doubleSigmoid/doubleSigmoid.C
  tetherPotential/tetherPotentialList/tetherPotentialList.C
  tetherPotential/basic/tetherPotential.C
  tetherPotential/basic/newTetherPotential.C
  tetherPotential/derived/harmonicSpring/harmonicSpring.C
  tetherPotential/derived/restrainedHarmonicSpring/restrainedHarmonicSpring.C
  tetherPotential/derived/pitchForkRing/pitchForkRing.C
  electrostaticPotential/electrostaticPotential.C
  )

set(HDRS
  electrostaticPotential/electrostaticPotential.H
  energyScalingFunction/basic/energyScalingFunction.H
  energyScalingFunction/derived/doubleSigmoid/doubleSigmoid.H
  energyScalingFunction/derived/noScaling/noScaling.H
  energyScalingFunction/derived/shifted/shifted.H
  energyScalingFunction/derived/shiftedForce/shiftedForce.H
  energyScalingFunction/derived/sigmoid/sigmoid.H
  pairPotential/basic/pairPotential.H
  pairPotential/basic/pairPotentialI.H
  pairPotential/derived/azizChen/azizChen.H
  pairPotential/derived/coulomb/coulomb.H
  pairPotential/derived/dampedCoulomb/dampedCoulomb.H
  pairPotential/derived/exponentialRepulsion/exponentialRepulsion.H
  pairPotential/derived/lennardJones/lennardJones.H
  pairPotential/derived/maitlandSmith/maitlandSmith.H
  pairPotential/derived/noInteraction/noInteraction.H
  pairPotential/pairPotentialList/pairPotentialList.H
  pairPotential/pairPotentialList/pairPotentialListI.H
  potential/potential.H
  potential/potentialI.H
  tetherPotential/basic/tetherPotential.H
  tetherPotential/derived/harmonicSpring/harmonicSpring.H
  tetherPotential/derived/pitchForkRing/pitchForkRing.H
  tetherPotential/derived/restrainedHarmonicSpring/restrainedHarmonicSpring.H
  tetherPotential/tetherPotentialList/tetherPotentialList.H
  tetherPotential/tetherPotentialList/tetherPotentialListI.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
