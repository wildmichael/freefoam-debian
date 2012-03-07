/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2008-2010 OpenCFD Ltd.
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "BasicReactingMultiphaseParcel.H"

// Kinematic
#include <lagrangianIntermediate/makeReactingParcelDispersionModels.H>
#include <lagrangianIntermediate/makeReactingParcelDragModels.H>
#include <lagrangianIntermediate/makeReactingMultiphaseParcelInjectionModels.H> // MP variant
#include <lagrangianIntermediate/makeReactingParcelPatchInteractionModels.H>
#include <lagrangianIntermediate/makeReactingParcelPostProcessingModels.H>

// Thermodynamic
#include <lagrangianIntermediate/makeReactingParcelHeatTransferModels.H>

// Reacting
#include <lagrangianIntermediate/makeReactingMultiphaseParcelCompositionModels.H> // MP variant
#include <lagrangianIntermediate/makeReactingParcelPhaseChangeModels.H>

// Reacting multiphase
#include <lagrangianIntermediate/makeReactingMultiphaseParcelDevolatilisationModels.H>
#include <lagrangianIntermediate/makeReactingMultiphaseParcelSurfaceReactionModels.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
    // Kinematic sub-models
    makeReactingDispersionModels(BasicReactingMultiphaseParcel);
    makeReactingDragModels(BasicReactingMultiphaseParcel);
    makeReactingMultiphaseInjectionModels(BasicReactingMultiphaseParcel);
    makeReactingPatchInteractionModels(BasicReactingMultiphaseParcel);
    makeReactingPostProcessingModels(BasicReactingMultiphaseParcel);

    // Thermo sub-models
    makeReactingHeatTransferModels(BasicReactingMultiphaseParcel);

    // Reacting sub-models
    makeReactingMultiphaseCompositionModels(BasicReactingMultiphaseParcel);
    makeReactingPhaseChangeModels(BasicReactingMultiphaseParcel);

    // Reacting multiphase sub-models
    makeReactingMultiphaseDevolatilisationModels
    (
        BasicReactingMultiphaseParcel
    );
    makeReactingMultiphaseSurfaceReactionModels
    (
        BasicReactingMultiphaseParcel
    );
};


// ************************ vim: set sw=4 sts=4 et: ************************ //
