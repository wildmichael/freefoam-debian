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
  forces/forces.C
  forces/forcesFunctionObject.C
  forceCoeffs/forceCoeffs.C
  forceCoeffs/forceCoeffsFunctionObject.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotion.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionIO.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionState.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionStateIO.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/sixDoFRigidBodyMotionRestraint/sixDoFRigidBodyMotionRestraint.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/sixDoFRigidBodyMotionRestraint/newSixDoFRigidBodyMotionRestraint.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/linearAxialAngularSpring/linearAxialAngularSpring.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/linearSpring/linearSpring.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/sphericalAngularSpring/sphericalAngularSpring.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/tabulatedAxialAngularSpring/tabulatedAxialAngularSpring.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/sixDoFRigidBodyMotionConstraint/sixDoFRigidBodyMotionConstraint.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/sixDoFRigidBodyMotionConstraint/newSixDoFRigidBodyMotionConstraint.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedAxis/fixedAxis.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedLine/fixedLine.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedOrientation/fixedOrientation.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedPlane/fixedPlane.C
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedPoint/fixedPoint.C
  pointPatchFields/derived/sixDoFRigidBodyDisplacement/sixDoFRigidBodyDisplacementPointPatchVectorField.C
  pointPatchFields/derived/uncoupledSixDoFRigidBodyDisplacement/uncoupledSixDoFRigidBodyDisplacementPointPatchVectorField.C
  ${FORCE_LINK_INCOMPRESSIBLE_LES_MODELS}
  ${FORCE_LINK_INCOMPRESSIBLE_RAS_MODELS}
  ${FORCE_LINK_COMPRESSIBLE_LES_MODELS}
  ${FORCE_LINK_COMPRESSIBLE_RAS_MODELS})

set(HDRS
  forceCoeffs/IOforceCoeffs.H
  forceCoeffs/forceCoeffs.H
  forceCoeffs/forceCoeffsFunctionObject.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotion.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionI.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionState.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionStateI.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/sixDoFRigidBodyMotionRestraint/sixDoFRigidBodyMotionRestraint.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/linearAxialAngularSpring/linearAxialAngularSpring.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/linearSpring/linearSpring.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/sphericalAngularSpring/sphericalAngularSpring.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionRestraint/tabulatedAxialAngularSpring/tabulatedAxialAngularSpring.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/sixDoFRigidBodyMotionConstraint/sixDoFRigidBodyMotionConstraint.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedAxis/fixedAxis.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedLine/fixedLine.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedOrientation/fixedOrientation.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedPlane/fixedPlane.H
  pointPatchFields/derived/sixDoFRigidBodyMotion/sixDoFRigidBodyMotionConstraint/fixedPoint/fixedPoint.H
  forces/IOforces.H
  forces/forces.H
  forces/forcesFunctionObject.H
  pointPatchFields/derived/sixDoFRigidBodyDisplacement/sixDoFRigidBodyDisplacementPointPatchVectorField.H
  pointPatchFields/derived/uncoupledSixDoFRigidBodyDisplacement/uncoupledSixDoFRigidBodyDisplacementPointPatchVectorField.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
