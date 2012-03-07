    Info<< "Reading combustion properties\n" << endl;

    IOdictionary combustionProperties
    (
        IOobject
        (
            "combustionProperties",
            runTime.constant(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE
        )
    );

    ignition ign(combustionProperties, runTime, mesh);

// ************************ vim: set sw=4 sts=4 et: ************************ //
