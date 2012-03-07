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
  parcels/derived/dsmcParcel/dsmcParcel.C
  clouds/baseClasses/DsmcBaseCloud/DsmcBaseCloud.C
  parcels/derived/dsmcParcel/defineDsmcParcel.C
  parcels/derived/dsmcParcel/makeDsmcParcelBinaryCollisionModels.C
  parcels/derived/dsmcParcel/makeDsmcParcelWallInteractionModels.C
  parcels/derived/dsmcParcel/makeDsmcParcelInflowBoundaryModels.C
  )

set(HDRS
  clouds/Templates/DsmcCloud_/DsmcCloudI_.H
  clouds/Templates/DsmcCloud_/DsmcCloud_.C
  clouds/Templates/DsmcCloud_/DsmcCloud_.H
  clouds/baseClasses/DsmcBaseCloud/DsmcBaseCloud.H
  clouds/derived/dsmcCloud/dsmcCloud.H
  parcels/Templates/DsmcParcel_/DsmcParcelIO.C
  parcels/Templates/DsmcParcel_/DsmcParcelI_.H
  parcels/Templates/DsmcParcel_/DsmcParcel_.C
  parcels/Templates/DsmcParcel_/DsmcParcel_.H
  parcels/derived/dsmcParcel/dsmcParcel.H
  submodels/BinaryCollisionModel/BinaryCollisionModel/BinaryCollisionModel.C
  submodels/BinaryCollisionModel/BinaryCollisionModel/BinaryCollisionModel.H
  submodels/BinaryCollisionModel/BinaryCollisionModel/NewBinaryCollisionModel.C
  submodels/BinaryCollisionModel/LarsenBorgnakkeVariableHardSphere/LarsenBorgnakkeVariableHardSphere.C
  submodels/BinaryCollisionModel/LarsenBorgnakkeVariableHardSphere/LarsenBorgnakkeVariableHardSphere.H
  submodels/BinaryCollisionModel/VariableHardSphere/VariableHardSphere.C
  submodels/BinaryCollisionModel/VariableHardSphere/VariableHardSphere.H
  submodels/InflowBoundaryModel/FreeStream/FreeStream.C
  submodels/InflowBoundaryModel/FreeStream/FreeStream.H
  submodels/InflowBoundaryModel/InflowBoundaryModel/InflowBoundaryModel.C
  submodels/InflowBoundaryModel/InflowBoundaryModel/InflowBoundaryModel.H
  submodels/InflowBoundaryModel/InflowBoundaryModel/NewInflowBoundaryModel.C
  submodels/InflowBoundaryModel/NoInflow/NoInflow.C
  submodels/InflowBoundaryModel/NoInflow/NoInflow.H
  submodels/WallInteractionModel/MaxwellianThermal/MaxwellianThermal.C
  submodels/WallInteractionModel/MaxwellianThermal/MaxwellianThermal.H
  submodels/WallInteractionModel/SpecularReflection/SpecularReflection.C
  submodels/WallInteractionModel/SpecularReflection/SpecularReflection.H
  submodels/WallInteractionModel/WallInteractionModel/NewWallInteractionModel.C
  submodels/WallInteractionModel/WallInteractionModel/WallInteractionModel.C
  submodels/WallInteractionModel/WallInteractionModel/WallInteractionModel.H
  submodels/WallInteractionModel/MixedDiffuseSpecular/MixedDiffuseSpecular.C
  submodels/WallInteractionModel/MixedDiffuseSpecular/MixedDiffuseSpecular.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
