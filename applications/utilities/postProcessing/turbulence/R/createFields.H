    Info<< "Reading field U\n" << endl;
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

#   include <finiteVolume/createPhi.H>

    singlePhaseTransportModel laminarTransport(U, phi);

    autoPtr<incompressible::RASModel> RASModel
    (
        incompressible::RASModel::New(U, phi, laminarTransport)
    );

// ************************ vim: set sw=4 sts=4 et: ************************ //
