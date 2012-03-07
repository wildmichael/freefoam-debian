    Info<< "Reading transportProperties\n" << endl;

    IOdictionary transportProperties
    (
        IOobject
        (
            "transportProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE
        )
    );

    dimensionedScalar mu
    (
        transportProperties.lookup("mu")
    );

// ************************ vim: set sw=4 sts=4 et: ************************ //
