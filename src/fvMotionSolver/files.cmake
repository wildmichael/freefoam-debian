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
  fvMotionSolvers/fvMotionSolver/fvMotionSolver.C
  fvMotionSolvers/velocity/laplacian/velocityLaplacianFvMotionSolver.C
  fvMotionSolvers/displacement/displacementFvMotionSolver/displacementFvMotionSolver.C
  fvMotionSolvers/displacement/interpolation/displacementInterpolationFvMotionSolver.C
  fvMotionSolvers/displacement/laplacian/displacementLaplacianFvMotionSolver.C
  fvMotionSolvers/displacement/SBRStress/displacementSBRStressFvMotionSolver.C
  fvMotionSolvers/velocity/componentLaplacian/velocityComponentLaplacianFvMotionSolver.C
  fvMotionSolvers/displacement/componentLaplacian/displacementComponentLaplacianFvMotionSolver.C
  motionDiffusivity/motionDiffusivity/motionDiffusivity.C
  motionDiffusivity/uniform/uniformDiffusivity.C
  motionDiffusivity/inverseDistance/inverseDistanceDiffusivity.C
  motionDiffusivity/inverseFaceDistance/inverseFaceDistanceDiffusivity.C
  motionDiffusivity/inversePointDistance/inversePointDistanceDiffusivity.C
  motionDiffusivity/inverseVolume/inverseVolumeDiffusivity.C
  motionDiffusivity/directional/directionalDiffusivity.C
  motionDiffusivity/motionDirectional/motionDirectionalDiffusivity.C
  motionDiffusivity/file/fileDiffusivity.C
  motionDiffusivity/manipulators/quadratic/quadraticDiffusivity.C
  motionDiffusivity/manipulators/exponential/exponentialDiffusivity.C
  fvPatchFields/derived/cellMotion/cellMotionFvPatchFields.C
  fvPatchFields/derived/surfaceSlipDisplacement/surfaceSlipDisplacementFvPatchFields.C
  pointPatchFields/derived/oscillatingVelocity/oscillatingVelocityPointPatchVectorField.C
  pointPatchFields/derived/angularOscillatingVelocity/angularOscillatingVelocityPointPatchVectorField.C
  pointPatchFields/derived/oscillatingDisplacement/oscillatingDisplacementPointPatchVectorField.C
  pointPatchFields/derived/angularOscillatingDisplacement/angularOscillatingDisplacementPointPatchVectorField.C
  pointPatchFields/derived/surfaceSlipDisplacement/surfaceSlipDisplacementPointPatchVectorField.C
  pointPatchFields/derived/surfaceDisplacement/surfaceDisplacementPointPatchVectorField.C
  )

set(HDRS
  fvMotionSolvers/displacement/SBRStress/displacementSBRStressFvMotionSolver.H
  fvMotionSolvers/displacement/componentLaplacian/displacementComponentLaplacianFvMotionSolver.H
  fvMotionSolvers/displacement/displacementFvMotionSolver/displacementFvMotionSolver.H
  fvMotionSolvers/displacement/interpolation/displacementInterpolationFvMotionSolver.H
  fvMotionSolvers/displacement/laplacian/displacementLaplacianFvMotionSolver.H
  fvMotionSolvers/fvMotionSolver/fvMotionSolver.H
  fvMotionSolvers/fvMotionSolver/fvMotionSolverTemplates.C
  fvMotionSolvers/velocity/componentLaplacian/velocityComponentLaplacianFvMotionSolver.H
  fvMotionSolvers/velocity/laplacian/velocityLaplacianFvMotionSolver.H
  fvPatchFields/derived/cellMotion/cellMotionFvPatchField.C
  fvPatchFields/derived/cellMotion/cellMotionFvPatchField.H
  fvPatchFields/derived/cellMotion/cellMotionFvPatchFields.H
  fvPatchFields/derived/cellMotion/cellMotionFvPatchFieldsFwd.H
  fvPatchFields/derived/surfaceSlipDisplacement/surfaceSlipDisplacementFvPatchField.H
  fvPatchFields/derived/surfaceSlipDisplacement/surfaceSlipDisplacementFvPatchFields.H
  fvPatchFields/derived/surfaceSlipDisplacement/surfaceSlipDisplacementFvPatchFieldsFwd.H
  motionDiffusivity/directional/directionalDiffusivity.H
  motionDiffusivity/file/fileDiffusivity.H
  motionDiffusivity/inverseDistance/inverseDistanceDiffusivity.H
  motionDiffusivity/inverseFaceDistance/inverseFaceDistanceDiffusivity.H
  motionDiffusivity/inversePointDistance/inversePointDistanceDiffusivity.H
  motionDiffusivity/inverseVolume/inverseVolumeDiffusivity.H
  motionDiffusivity/manipulators/exponential/exponentialDiffusivity.H
  motionDiffusivity/manipulators/quadratic/quadraticDiffusivity.H
  motionDiffusivity/motionDiffusivity/motionDiffusivity.H
  motionDiffusivity/motionDirectional/motionDirectionalDiffusivity.H
  motionDiffusivity/uniform/uniformDiffusivity.H
  pointPatchFields/derived/angularOscillatingDisplacement/angularOscillatingDisplacementPointPatchVectorField.H
  pointPatchFields/derived/angularOscillatingVelocity/angularOscillatingVelocityPointPatchVectorField.H
  pointPatchFields/derived/oscillatingDisplacement/oscillatingDisplacementPointPatchVectorField.H
  pointPatchFields/derived/oscillatingVelocity/oscillatingVelocityPointPatchVectorField.H
  pointPatchFields/derived/surfaceDisplacement/surfaceDisplacementPointPatchVectorField.H
  pointPatchFields/derived/surfaceSlipDisplacement/surfaceSlipDisplacementPointPatchVectorField.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
