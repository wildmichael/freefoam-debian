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
  parcel/parcel.C
  parcel/parcelFunctions.C
  parcel/parcelIO.C
  parcel/setRelaxationTimes.C
  spray/spray.C
  spray/sprayOps.C
  spray/sprayInject.C
  spray/sprayFunctions.C
  injector/injector/injector.C
  injector/injector/injectorIO.C
  injector/injectorType/injectorType.C
  injector/unitInjector/unitInjector.C
  injector/multiHoleInjector/multiHoleInjector.C
  injector/commonRailInjector/commonRailInjector.C
  injector/swirlInjector/swirlInjector.C
  injector/definedInjector/definedInjector.C
  spraySubModels/atomizationModel/atomizationModel/atomizationModel.C
  spraySubModels/atomizationModel/atomizationModel/newAtomizationModel.C
  spraySubModels/atomizationModel/LISA/LISA.C
  spraySubModels/atomizationModel/noAtomization/noAtomization.C
  spraySubModels/atomizationModel/blobsSheetAtomization/blobsSheetAtomization.C
  spraySubModels/breakupModel/breakupModel/newBreakupModel.C
  spraySubModels/breakupModel/breakupModel/breakupModel.C
  spraySubModels/breakupModel/noBreakup/noBreakup.C
  spraySubModels/breakupModel/reitzDiwakar/reitzDiwakar.C
  spraySubModels/breakupModel/reitzKHRT/reitzKHRT.C
  spraySubModels/breakupModel/SHF/SHF.C
  spraySubModels/breakupModel/TAB/TAB.C
  spraySubModels/breakupModel/ETAB/ETAB.C
  spraySubModels/dragModel/dragModel/newDragModel.C
  spraySubModels/dragModel/dragModel/dragModel.C
  spraySubModels/dragModel/noDragModel/noDragModel.C
  spraySubModels/dragModel/standardDragModel/standardDragModel.C
  spraySubModels/evaporationModel/evaporationModel/newEvaporationModel.C
  spraySubModels/evaporationModel/evaporationModel/evaporationModel.C
  spraySubModels/evaporationModel/noEvaporation/noEvaporation.C
  spraySubModels/evaporationModel/RutlandFlashBoil/RutlandFlashBoil.C
  spraySubModels/evaporationModel/standardEvaporationModel/standardEvaporationModel.C
  spraySubModels/evaporationModel/saturateEvaporationModel/saturateEvaporationModel.C
  spraySubModels/heatTransferModel/heatTransferModel/newHeatTransferModel.C
  spraySubModels/heatTransferModel/heatTransferModel/heatTransferModel.C
  spraySubModels/heatTransferModel/noHeatTransfer/noHeatTransfer.C
  spraySubModels/heatTransferModel/RanzMarshall/RanzMarshall.C
  spraySubModels/injectorModel/injectorModel/newInjectorModel.C
  spraySubModels/injectorModel/injectorModel/injectorModel.C
  spraySubModels/injectorModel/constant/constInjector.C
  spraySubModels/injectorModel/Chomiak/Chomiak.C
  spraySubModels/injectorModel/hollowCone/hollowCone.C
  spraySubModels/injectorModel/pressureSwirl/pressureSwirlInjector.C
  spraySubModels/injectorModel/definedHollowCone/definedHollowCone.C
  spraySubModels/injectorModel/definedPressureSwirl/definedPressureSwirl.C
  spraySubModels/injectorModel/blobsSwirl/blobsSwirlInjector.C
  spraySubModels/wallModel/wallModel/newWallModel.C
  spraySubModels/wallModel/wallModel/wallModel.C
  spraySubModels/wallModel/removeParcel/removeParcel.C
  spraySubModels/wallModel/reflectParcel/reflectParcel.C
  spraySubModels/collisionModel/collisionModel/collisionModel.C
  spraySubModels/collisionModel/collisionModel/newCollisionModel.C
  spraySubModels/collisionModel/noCollision/noCollision.C
  spraySubModels/collisionModel/ORourke/ORourkeCollisionModel.C
  spraySubModels/collisionModel/trajectoryModel/trajectoryModel.C
  spraySubModels/dispersionModel/dispersionModel/dispersionModel.C
  spraySubModels/dispersionModel/dispersionModel/newDispersionModel.C
  spraySubModels/dispersionModel/dispersionRASModel/dispersionRASModel.C
  spraySubModels/dispersionModel/dispersionLESModel/dispersionLESModel.C
  spraySubModels/dispersionModel/noDispersion/noDispersion.C
  spraySubModels/dispersionModel/gradientDispersionRAS/gradientDispersionRAS.C
  spraySubModels/dispersionModel/stochasticDispersionRAS/stochasticDispersionRAS.C
  ${FORCE_LINK_COMPRESSIBLE_LES_MODELS}
  ${FORCE_LINK_COMPRESSIBLE_RAS_MODELS})

set(HDRS
  injector/commonRailInjector/commonRailInjector.H
  injector/definedInjector/definedInjector.H
  injector/injector/injector.H
  injector/injector/injectorI.H
  injector/injectorType/injectorType.H
  injector/multiHoleInjector/multiHoleInjector.H
  injector/swirlInjector/swirlInjector.H
  injector/unitInjector/unitInjector.H
  parcel/boundaryTreatment.H
  parcel/parcel.H
  parcel/parcelI.H
  spray/findInjectorCell.H
  spray/spray.H
  spray/sprayI.H
  spraySubModels/atomizationModel/LISA/LISA.H
  spraySubModels/atomizationModel/atomizationModel/atomizationModel.H
  spraySubModels/atomizationModel/blobsSheetAtomization/blobsSheetAtomization.H
  spraySubModels/atomizationModel/noAtomization/noAtomization.H
  spraySubModels/breakupModel/ETAB/ETAB.H
  spraySubModels/breakupModel/SHF/SHF.H
  spraySubModels/breakupModel/TAB/TAB.H
  spraySubModels/breakupModel/breakupModel/breakupModel.H
  spraySubModels/breakupModel/noBreakup/noBreakup.H
  spraySubModels/breakupModel/reitzDiwakar/reitzDiwakar.H
  spraySubModels/breakupModel/reitzKHRT/reitzKHRT.H
  spraySubModels/collisionModel/ORourke/ORourkeCollisionModel.H
  spraySubModels/collisionModel/ORourke/sameCell.H
  spraySubModels/collisionModel/collisionModel/collisionModel.H
  spraySubModels/collisionModel/noCollision/noCollision.H
  spraySubModels/collisionModel/trajectoryModel/trajectoryCM.H
  spraySubModels/collisionModel/trajectoryModel/trajectoryModel.H
  spraySubModels/dispersionModel/dispersionLESModel/dispersionLESModel.H
  spraySubModels/dispersionModel/dispersionModel/dispersionModel.H
  spraySubModels/dispersionModel/dispersionRASModel/dispersionRASModel.H
  spraySubModels/dispersionModel/gradientDispersionRAS/gradientDispersionRAS.H
  spraySubModels/dispersionModel/noDispersion/noDispersion.H
  spraySubModels/dispersionModel/stochasticDispersionRAS/stochasticDispersionRAS.H
  spraySubModels/dragModel/dragModel/dragModel.H
  spraySubModels/dragModel/noDragModel/noDragModel.H
  spraySubModels/dragModel/standardDragModel/standardDragModel.H
  spraySubModels/evaporationModel/RutlandFlashBoil/RutlandFlashBoil.H
  spraySubModels/evaporationModel/evaporationModel/evaporationModel.H
  spraySubModels/evaporationModel/noEvaporation/noEvaporation.H
  spraySubModels/evaporationModel/saturateEvaporationModel/saturateEvaporationModel.H
  spraySubModels/evaporationModel/standardEvaporationModel/standardEvaporationModel.H
  spraySubModels/heatTransferModel/RanzMarshall/RanzMarshall.H
  spraySubModels/heatTransferModel/heatTransferModel/heatTransferModel.H
  spraySubModels/heatTransferModel/noHeatTransfer/noHeatTransfer.H
  spraySubModels/injectorModel/Chomiak/Chomiak.H
  spraySubModels/injectorModel/blobsSwirl/blobsSwirlInjector.H
  spraySubModels/injectorModel/constant/constInjector.H
  spraySubModels/injectorModel/definedHollowCone/definedHollowCone.H
  spraySubModels/injectorModel/definedPressureSwirl/definedPressureSwirl.H
  spraySubModels/injectorModel/hollowCone/hollowCone.H
  spraySubModels/injectorModel/injectorModel/injectorModel.H
  spraySubModels/injectorModel/pressureSwirl/pressureSwirlInjector.H
  spraySubModels/wallModel/reflectParcel/reflectParcel.H
  spraySubModels/wallModel/removeParcel/removeParcel.H
  spraySubModels/wallModel/wallModel/wallModel.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
