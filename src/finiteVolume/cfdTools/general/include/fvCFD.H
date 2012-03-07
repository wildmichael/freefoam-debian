#ifndef fvCFD_H
#define fvCFD_H

#include <OpenFOAM/parRun.H>

#include <OpenFOAM/Time.H>
#include <finiteVolume/fvMesh.H>
#include <finiteVolume/fvc.H>
#include <finiteVolume/fvMatrices.H>
#include <finiteVolume/fvm.H>
#include <finiteVolume/linear.H>
#include <OpenFOAM/uniformDimensionedFields.H>
#include <finiteVolume/calculatedFvPatchFields.H>
#include <finiteVolume/fixedValueFvPatchFields.H>
#include <finiteVolume/adjustPhi.H>
#include <finiteVolume/findRefCell.H>
#include <OpenFOAM/mathematicalConstants.H>

#include <OpenFOAM/OSspecific.H>
#include <OpenFOAM/argList.H>
#include <OpenFOAM/timeSelector.H>

#ifndef namespaceFoam
#define namespaceFoam
    using namespace Foam;
#endif

#endif
