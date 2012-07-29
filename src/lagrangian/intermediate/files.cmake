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
  parcels/baseClasses/reactingParcel/reactingParcel.C
  clouds/baseClasses/kinematicCloud/kinematicCloud.C
  clouds/baseClasses/thermoCloud/thermoCloud.C
  clouds/baseClasses/reactingCloud/reactingCloud.C
  clouds/baseClasses/reactingMultiphaseCloud/reactingMultiphaseCloud.C
  parcels/derived/basicKinematicParcel/basicKinematicParcel.C
  parcels/derived/basicKinematicParcel/defineBasicKinematicParcel.C
  parcels/derived/basicKinematicParcel/makeBasicKinematicParcelSubmodels.C
  parcels/derived/basicThermoParcel/basicThermoParcel.C
  parcels/derived/basicThermoParcel/defineBasicThermoParcel.C
  parcels/derived/basicThermoParcel/makeBasicThermoParcelSubmodels.C
  parcels/derived/BasicReactingParcel/defineBasicReactingParcel.C
  parcels/derived/BasicReactingParcel/makeBasicReactingParcelSubmodels.C
  parcels/derived/BasicReactingMultiphaseParcel/defineBasicReactingMultiphaseParcel.C
  parcels/derived/BasicReactingMultiphaseParcel/makeBasicReactingMultiphaseParcelSubmodels.C
  submodels/addOns/radiation/absorptionEmission/cloudAbsorptionEmission/cloudAbsorptionEmission.C
  submodels/addOns/radiation/scatter/cloudScatter/cloudScatter.C
  submodels/Kinematic/PatchInteractionModel/LocalInteraction/patchInteractionData.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/kinematicParcelInjectionData.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/kinematicParcelInjectionDataIO.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/kinematicParcelInjectionDataIOList.C
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/thermoParcelInjectionData.C
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/thermoParcelInjectionDataIO.C
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/thermoParcelInjectionDataIOList.C
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/reactingParcelInjectionData.C
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/reactingParcelInjectionDataIO.C
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/reactingParcelInjectionDataIOList.C
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/reactingMultiphaseParcelInjectionData.C
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/reactingMultiphaseParcelInjectionDataIO.C
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/reactingMultiphaseParcelInjectionDataIOList.C
  submodels/IO/DataEntry/makeDataEntries.C
  submodels/IO/DataEntry/polynomial/polynomial.C
  submodels/IO/DataEntry/polynomial/polynomialIO.C
  IntegrationScheme/makeIntegrationSchemes.C
  particleForces/particleForces.C
  phaseProperties/phaseProperties/phaseProperties.C
  phaseProperties/phaseProperties/phasePropertiesIO.C
  phaseProperties/phasePropertiesList/phasePropertiesList.C
  ${FORCE_LINK_COMPRESSIBLE_LES_MODELS}
  ${FORCE_LINK_COMPRESSIBLE_RAS_MODELS}
  ${FORCE_LINK_RADIATION})

set(HDRS
  IntegrationScheme/Analytical/Analytical.C
  IntegrationScheme/Analytical/Analytical.H
  IntegrationScheme/Euler/Euler.C
  IntegrationScheme/Euler/Euler.H
  IntegrationScheme/IntegrationScheme/IntegrationScheme.C
  IntegrationScheme/IntegrationScheme/IntegrationScheme.H
  IntegrationScheme/IntegrationScheme/IntegrationSchemesFwd.H
  IntegrationScheme/IntegrationScheme/newIntegrationScheme.C
  clouds/Templates/KinematicCloud/KinematicCloudI_.H
  clouds/Templates/KinematicCloud/KinematicCloud_.C
  clouds/Templates/KinematicCloud/KinematicCloud_.H
  clouds/Templates/ReactingCloud/ReactingCloudI_.H
  clouds/Templates/ReactingCloud/ReactingCloud_.C
  clouds/Templates/ReactingCloud/ReactingCloud_.H
  clouds/Templates/ReactingMultiphaseCloud_/ReactingMultiphaseCloudI_.H
  clouds/Templates/ReactingMultiphaseCloud_/ReactingMultiphaseCloud_.C
  clouds/Templates/ReactingMultiphaseCloud_/ReactingMultiphaseCloud_.H
  clouds/Templates/ThermoCloud/ThermoCloudI_.H
  clouds/Templates/ThermoCloud/ThermoCloud_.C
  clouds/Templates/ThermoCloud/ThermoCloud_.H
  clouds/baseClasses/kinematicCloud/kinematicCloud.H
  clouds/baseClasses/reactingCloud/reactingCloud.H
  clouds/baseClasses/reactingMultiphaseCloud/reactingMultiphaseCloud.H
  clouds/baseClasses/thermoCloud/thermoCloud.H
  clouds/derived/BasicReactingCloud/BasicReactingCloud.H
  clouds/derived/BasicReactingMultiphaseCloud/BasicReactingMultiphaseCloud.H
  clouds/derived/basicKinematicCloud/basicKinematicCloud.H
  clouds/derived/basicThermoCloud/basicThermoCloud.H
  parcels/Templates/KinematicParcel/KinematicParcel.C
  parcels/Templates/KinematicParcel/KinematicParcel.H
  parcels/Templates/KinematicParcel/KinematicParcelI.H
  parcels/Templates/KinematicParcel/KinematicParcelIO.C
  parcels/Templates/ReactingMultiphaseParcel/ReactingMultiphaseParcel.C
  parcels/Templates/ReactingMultiphaseParcel/ReactingMultiphaseParcel.H
  parcels/Templates/ReactingMultiphaseParcel/ReactingMultiphaseParcelI.H
  parcels/Templates/ReactingMultiphaseParcel/ReactingMultiphaseParcelIO.C
  parcels/Templates/ReactingParcel_/ReactingParcelIO.C
  parcels/Templates/ReactingParcel_/ReactingParcelI_.H
  parcels/Templates/ReactingParcel_/ReactingParcel_.C
  parcels/Templates/ReactingParcel_/ReactingParcel_.H
  parcels/Templates/ThermoParcel/ThermoParcel.C
  parcels/Templates/ThermoParcel/ThermoParcel.H
  parcels/Templates/ThermoParcel/ThermoParcelI.H
  parcels/Templates/ThermoParcel/ThermoParcelIO.C
  parcels/baseClasses/reactingParcel/reactingParcel.H
  parcels/derived/BasicReactingMultiphaseParcel/BasicReactingMultiphaseParcel.C
  parcels/derived/BasicReactingMultiphaseParcel/BasicReactingMultiphaseParcel.H
  parcels/derived/BasicReactingParcel/BasicReactingParcel.C
  parcels/derived/BasicReactingParcel/BasicReactingParcel.H
  parcels/derived/basicKinematicParcel/basicKinematicParcel.H
  parcels/derived/basicThermoParcel/basicThermoParcel.H
  parcels/include/createReactingMultiphaseParcelTypes.H
  parcels/include/createReactingParcelTypes.H
  parcels/include/makeParcelDispersionModels.H
  parcels/include/makeParcelDragModels.H
  parcels/include/makeParcelHeatTransferModels.H
  parcels/include/makeParcelInjectionModels.H
  parcels/include/makeParcelPatchInteractionModels.H
  parcels/include/makeParcelPostProcessingModels.H
  parcels/include/makeReactingMultiphaseParcelCompositionModels.H
  parcels/include/makeReactingMultiphaseParcelDevolatilisationModels.H
  parcels/include/makeReactingMultiphaseParcelInjectionModels.H
  parcels/include/makeReactingMultiphaseParcelSurfaceReactionModels.H
  parcels/include/makeReactingParcelCompositionModels.H
  parcels/include/makeReactingParcelDispersionModels.H
  parcels/include/makeReactingParcelDragModels.H
  parcels/include/makeReactingParcelHeatTransferModels.H
  parcels/include/makeReactingParcelInjectionModels.H
  parcels/include/makeReactingParcelPatchInteractionModels.H
  parcels/include/makeReactingParcelPhaseChangeModels.H
  parcels/include/makeReactingParcelPostProcessingModels.H
  particleForces/particleForces.H
  phaseProperties/phaseProperties/phaseProperties.H
  phaseProperties/phasePropertiesList/phasePropertiesList.H
  submodels/IO/DataEntry/Constant/Constant.C
  submodels/IO/DataEntry/Constant/Constant.H
  submodels/IO/DataEntry/Constant/ConstantIO.C
  submodels/IO/DataEntry/DataEntry/DataEntry.C
  submodels/IO/DataEntry/DataEntry/DataEntry.H
  submodels/IO/DataEntry/DataEntry/DataEntryIO.C
  submodels/IO/DataEntry/DataEntry/NewDataEntry.C
  submodels/IO/DataEntry/Table/Table.C
  submodels/IO/DataEntry/Table/Table.H
  submodels/IO/DataEntry/Table/TableIO.C
  submodels/IO/DataEntry/polynomial/polynomial.H
  submodels/Kinematic/DispersionModel/DispersionModel/DispersionModel.C
  submodels/Kinematic/DispersionModel/DispersionModel/DispersionModel.H
  submodels/Kinematic/DispersionModel/DispersionModel/NewDispersionModel.C
  submodels/Kinematic/DispersionModel/DispersionRASModel/DispersionRASModel.C
  submodels/Kinematic/DispersionModel/DispersionRASModel/DispersionRASModel.H
  submodels/Kinematic/DispersionModel/GradientDispersionRAS/GradientDispersionRAS.C
  submodels/Kinematic/DispersionModel/GradientDispersionRAS/GradientDispersionRAS.H
  submodels/Kinematic/DispersionModel/NoDispersion/NoDispersion.C
  submodels/Kinematic/DispersionModel/NoDispersion/NoDispersion.H
  submodels/Kinematic/DispersionModel/StochasticDispersionRAS/StochasticDispersionRAS.C
  submodels/Kinematic/DispersionModel/StochasticDispersionRAS/StochasticDispersionRAS.H
  submodels/Kinematic/DragModel/DragModel/DragModel.C
  submodels/Kinematic/DragModel/DragModel/DragModel.H
  submodels/Kinematic/DragModel/DragModel/NewDragModel.C
  submodels/Kinematic/DragModel/NoDrag/NoDrag.C
  submodels/Kinematic/DragModel/NoDrag/NoDrag.H
  submodels/Kinematic/DragModel/SphereDrag/SphereDrag.C
  submodels/Kinematic/DragModel/SphereDrag/SphereDrag.H
  submodels/Kinematic/InjectionModel/ConeInjection/ConeInjection.C
  submodels/Kinematic/InjectionModel/ConeInjection/ConeInjection.H
  submodels/Kinematic/InjectionModel/ConeInjectionMP/ConeInjectionMP.C
  submodels/Kinematic/InjectionModel/ConeInjectionMP/ConeInjectionMP.H
  submodels/Kinematic/InjectionModel/FieldActivatedInjection/FieldActivatedInjection.C
  submodels/Kinematic/InjectionModel/FieldActivatedInjection/FieldActivatedInjection.H
  submodels/Kinematic/InjectionModel/InjectionModel/InjectionModel.C
  submodels/Kinematic/InjectionModel/InjectionModel/InjectionModel.H
  submodels/Kinematic/InjectionModel/InjectionModel/InjectionModelI.H
  submodels/Kinematic/InjectionModel/InjectionModel/NewInjectionModel.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/KinematicLookupTableInjection.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/KinematicLookupTableInjection.H
  submodels/Kinematic/InjectionModel/ManualInjection/ManualInjection.C
  submodels/Kinematic/InjectionModel/ManualInjection/ManualInjection.H
  submodels/Kinematic/InjectionModel/NoInjection/NoInjection.C
  submodels/Kinematic/InjectionModel/NoInjection/NoInjection.H
  submodels/Kinematic/InjectionModel/PatchInjection/PatchInjection.C
  submodels/Kinematic/InjectionModel/PatchInjection/PatchInjection.H
  submodels/Kinematic/PatchInteractionModel/LocalInteraction/LocalInteraction.C
  submodels/Kinematic/PatchInteractionModel/LocalInteraction/LocalInteraction.H
  submodels/Kinematic/PatchInteractionModel/PatchInteractionModel/NewPatchInteractionModel.C
  submodels/Kinematic/PatchInteractionModel/PatchInteractionModel/PatchInteractionModel.C
  submodels/Kinematic/PatchInteractionModel/PatchInteractionModel/PatchInteractionModel.H
  submodels/Kinematic/PatchInteractionModel/Rebound/Rebound.C
  submodels/Kinematic/PatchInteractionModel/Rebound/Rebound.H
  submodels/Kinematic/PatchInteractionModel/StandardWallInteraction/StandardWallInteraction.C
  submodels/Kinematic/PatchInteractionModel/StandardWallInteraction/StandardWallInteraction.H
  submodels/Kinematic/PostProcessingModel/NoPostProcessing/NoPostProcessing.C
  submodels/Kinematic/PostProcessingModel/NoPostProcessing/NoPostProcessing.H
  submodels/Kinematic/PostProcessingModel/PatchPostProcessing/PatchPostProcessing.C
  submodels/Kinematic/PostProcessingModel/PatchPostProcessing/PatchPostProcessing.H
  submodels/Kinematic/PostProcessingModel/PatchPostProcessing/PatchPostProcessingI.H
  submodels/Kinematic/PostProcessingModel/PostProcessingModel/NewPostProcessingModel.C
  submodels/Kinematic/PostProcessingModel/PostProcessingModel/PostProcessingModel.C
  submodels/Kinematic/PostProcessingModel/PostProcessingModel/PostProcessingModel.H
  submodels/Kinematic/PostProcessingModel/PostProcessingModel/PostProcessingModelI.H
  submodels/Reacting/CompositionModel/CompositionModel/CompositionModel.C
  submodels/Reacting/CompositionModel/CompositionModel/CompositionModel.H
  submodels/Reacting/CompositionModel/CompositionModel/NewCompositionModel.C
  submodels/Reacting/CompositionModel/SingleMixtureFraction/SingleMixtureFraction.C
  submodels/Reacting/CompositionModel/SingleMixtureFraction/SingleMixtureFraction.H
  submodels/Reacting/CompositionModel/SinglePhaseMixture/SinglePhaseMixture.C
  submodels/Reacting/CompositionModel/SinglePhaseMixture/SinglePhaseMixture.H
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/ReactingLookupTableInjection.C
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/ReactingLookupTableInjection.H
  submodels/Reacting/PhaseChangeModel/LiquidEvaporation/LiquidEvaporation.C
  submodels/Reacting/PhaseChangeModel/LiquidEvaporation/LiquidEvaporation.H
  submodels/Reacting/PhaseChangeModel/NoPhaseChange/NoPhaseChange.C
  submodels/Reacting/PhaseChangeModel/NoPhaseChange/NoPhaseChange.H
  submodels/Reacting/PhaseChangeModel/PhaseChangeModel/NewPhaseChangeModel.C
  submodels/Reacting/PhaseChangeModel/PhaseChangeModel/PhaseChangeModel.C
  submodels/Reacting/PhaseChangeModel/PhaseChangeModel/PhaseChangeModel.H
  submodels/ReactingMultiphase/DevolatilisationModel/ConstantRateDevolatilisation/ConstantRateDevolatilisation.C
  submodels/ReactingMultiphase/DevolatilisationModel/ConstantRateDevolatilisation/ConstantRateDevolatilisation.H
  submodels/ReactingMultiphase/DevolatilisationModel/DevolatilisationModel/DevolatilisationModel.C
  submodels/ReactingMultiphase/DevolatilisationModel/DevolatilisationModel/DevolatilisationModel.H
  submodels/ReactingMultiphase/DevolatilisationModel/DevolatilisationModel/NewDevolatilisationModel.C
  submodels/ReactingMultiphase/DevolatilisationModel/NoDevolatilisation/NoDevolatilisation.C
  submodels/ReactingMultiphase/DevolatilisationModel/NoDevolatilisation/NoDevolatilisation.H
  submodels/ReactingMultiphase/DevolatilisationModel/SingleKineticRateDevolatilisation/SingleKineticRateDevolatilisation.C
  submodels/ReactingMultiphase/DevolatilisationModel/SingleKineticRateDevolatilisation/SingleKineticRateDevolatilisation.H
  submodels/ReactingMultiphase/SurfaceReactionModel/NoSurfaceReaction/NoSurfaceReaction.C
  submodels/ReactingMultiphase/SurfaceReactionModel/NoSurfaceReaction/NoSurfaceReaction.H
  submodels/ReactingMultiphase/SurfaceReactionModel/SurfaceReactionModel/NewSurfaceReactionModel.C
  submodels/ReactingMultiphase/SurfaceReactionModel/SurfaceReactionModel/SurfaceReactionModel.C
  submodels/ReactingMultiphase/SurfaceReactionModel/SurfaceReactionModel/SurfaceReactionModel.H
  submodels/Thermodynamic/HeatTransferModel/HeatTransferModel/HeatTransferModel.C
  submodels/Thermodynamic/HeatTransferModel/HeatTransferModel/HeatTransferModel.H
  submodels/Thermodynamic/HeatTransferModel/HeatTransferModel/NewHeatTransferModel.C
  submodels/Thermodynamic/HeatTransferModel/NoHeatTransfer/NoHeatTransfer.C
  submodels/Thermodynamic/HeatTransferModel/NoHeatTransfer/NoHeatTransfer.H
  submodels/Thermodynamic/HeatTransferModel/RanzMarshall/RanzMarshall.C
  submodels/Thermodynamic/HeatTransferModel/RanzMarshall/RanzMarshall.H
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/ThermoLookupTableInjection.C
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/ThermoLookupTableInjection.H
  submodels/addOns/radiation/absorptionEmission/cloudAbsorptionEmission/cloudAbsorptionEmission.H
  submodels/addOns/radiation/scatter/cloudScatter/cloudScatter.H
  submodels/Kinematic/PatchInteractionModel/LocalInteraction/LocalInteraction.C
  submodels/Kinematic/PatchInteractionModel/LocalInteraction/LocalInteraction.H
  submodels/Kinematic/PatchInteractionModel/LocalInteraction/patchInteractionData.H
  submodels/Kinematic/InjectionModel/ConeInjection/ConeInjection.C
  submodels/Kinematic/InjectionModel/ConeInjection/ConeInjection.H
  submodels/Kinematic/InjectionModel/ConeInjectionMP/ConeInjectionMP.C
  submodels/Kinematic/InjectionModel/ConeInjectionMP/ConeInjectionMP.H
  submodels/Kinematic/InjectionModel/FieldActivatedInjection/FieldActivatedInjection.C
  submodels/Kinematic/InjectionModel/FieldActivatedInjection/FieldActivatedInjection.H
  submodels/Kinematic/InjectionModel/InjectionModel/InjectionModel.C
  submodels/Kinematic/InjectionModel/InjectionModel/InjectionModel.H
  submodels/Kinematic/InjectionModel/InjectionModel/InjectionModelI.H
  submodels/Kinematic/InjectionModel/InjectionModel/NewInjectionModel.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/KinematicLookupTableInjection.C
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/KinematicLookupTableInjection.H
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/kinematicParcelInjectionData.H
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/kinematicParcelInjectionDataI.H
  submodels/Kinematic/InjectionModel/KinematicLookupTableInjection/kinematicParcelInjectionDataIOList.H
  submodels/Kinematic/InjectionModel/ManualInjection/ManualInjection.C
  submodels/Kinematic/InjectionModel/ManualInjection/ManualInjection.H
  submodels/Kinematic/InjectionModel/NoInjection/NoInjection.C
  submodels/Kinematic/InjectionModel/NoInjection/NoInjection.H
  submodels/Kinematic/InjectionModel/PatchInjection/PatchInjection.C
  submodels/Kinematic/InjectionModel/PatchInjection/PatchInjection.H
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/ThermoLookupTableInjection.C
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/ThermoLookupTableInjection.H
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/thermoParcelInjectionData.H
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/thermoParcelInjectionDataI.H
  submodels/Thermodynamic/InjectionModel/ThermoLookupTableInjection/thermoParcelInjectionDataIOList.H
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/ReactingLookupTableInjection.C
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/ReactingLookupTableInjection.H
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/reactingParcelInjectionData.H
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/reactingParcelInjectionDataI.H
  submodels/Reacting/InjectionModel/ReactingLookupTableInjection/reactingParcelInjectionDataIOList.H
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/ReactingMultiphaseLookupTableInjection.C
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/ReactingMultiphaseLookupTableInjection.H
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/reactingMultiphaseParcelInjectionData.H
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/reactingMultiphaseParcelInjectionDataI.H
  submodels/ReactingMultiphase/InjectionModel/ReactingMultiphaseLookupTableInjection/reactingMultiphaseParcelInjectionDataIOList.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file