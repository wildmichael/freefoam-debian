Info<< nl << "Reading MD Equilibration Dictionary" << nl << endl;

IOdictionary mdEquilibrationDict
(
    IOobject
    (
        "mdEquilibrationDict",
        runTime.system(),
        mesh,
        IOobject::MUST_READ,
        IOobject::NO_WRITE
    )
);

scalar targetTemperature = readScalar
(
    mdEquilibrationDict.lookup("targetTemperature")
);

// ************************ vim: set sw=4 sts=4 et: ************************ //
