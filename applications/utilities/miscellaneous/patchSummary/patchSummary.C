/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 1991-2010 OpenCFD Ltd.
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

Application
    patchSummary

Description
    Writes fields and boundary condition info for each patch at each requested
    time instance.

Usage

    - patchSummary [OPTIONS]

    @param -noZero \n
    Ignore timestep 0.

    @param -constant \n
    Include the constant directory.

    @param -time \<time\>\n
    Apply only to specific time.

    @param -latestTime \n
    Only apply to latest time step.

    @param -case \<dir\>\n
    Case directory.

    @param -parallel \n
    Run in parallel.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <finiteVolume/fvCFD.H>
#include <finiteVolume/volFields.H>
#include <OpenFOAM/IOobjectList.H>
#include "patchSummaryTemplates.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    timeSelector::addOptions();

#   include <OpenFOAM/addRegionOption.H>
#   include <OpenFOAM/setRootCase.H>
#   include <OpenFOAM/createTime.H>

    instantList timeDirs = timeSelector::select0(runTime, args);

#   include <OpenFOAM/createNamedMesh.H>

    forAll(timeDirs, timeI)
    {
        runTime.setTime(timeDirs[timeI], timeI);

        Info<< "Time = " << runTime.timeName() << nl << endl;

        const IOobjectList fieldObjs(mesh, runTime.timeName());
        const wordList objNames = fieldObjs.names();

        PtrList<volScalarField> vsf(objNames.size());
        PtrList<volVectorField> vvf(objNames.size());
        PtrList<volSphericalTensorField> vsptf(objNames.size());
        PtrList<volSymmTensorField> vsytf(objNames.size());
        PtrList<volTensorField> vtf(objNames.size());

        Info<< "Valid fields:" << endl;

        forAll(objNames, objI)
        {
            IOobject obj
            (
                objNames[objI],
                runTime.timeName(),
                mesh,
                IOobject::MUST_READ
            );

            if (obj.headerOk())
            {
                addToFieldList<scalar>(vsf, obj, objI, mesh);
                addToFieldList<vector>(vvf, obj, objI, mesh);
                addToFieldList<sphericalTensor>(vsptf, obj, objI, mesh);
                addToFieldList<symmTensor>(vsytf, obj, objI, mesh);
                addToFieldList<tensor>(vtf, obj, objI, mesh);
            }
        }

        Info<< endl;

        const polyBoundaryMesh& bm = mesh.boundaryMesh();
        forAll(bm, patchI)
        {
            Info<< bm[patchI].type() << ": " << bm[patchI].name() << nl;
            outputFieldList<scalar>(vsf, patchI);
            outputFieldList<vector>(vvf, patchI);
            outputFieldList<sphericalTensor>(vsptf, patchI);
            outputFieldList<symmTensor>(vsytf, patchI);
            outputFieldList<tensor>(vtf, patchI);
            Info << endl;
        }
    }

    Info << "End\n" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
