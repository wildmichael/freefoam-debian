autoPtr<hCombustionThermo> thermo
(
    hCombustionThermo::New(mesh)
);

const volScalarField& h = thermo->h();

volScalarField rho
(
    IOobject
    (
        "rho",
        runTime.timeName(),
        mesh
    ),
    thermo->rho()
);

volVectorField U
(
    IOobject
    (
        "U",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

#include <finiteVolume/compressibleCreatePhi.H>

autoPtr<compressible::RASModel> RASModel
(
    compressible::RASModel::New
    (
        rho,
        U,
        phi,
        thermo()
    )
);

// ************************ vim: set sw=4 sts=4 et: ************************ //
