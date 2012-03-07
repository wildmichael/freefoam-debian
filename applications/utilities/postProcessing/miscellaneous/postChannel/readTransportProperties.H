    Info<< nl << "Reading transportProperties" << endl;

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

// ************************ vim: set sw=4 sts=4 et: ************************ //
