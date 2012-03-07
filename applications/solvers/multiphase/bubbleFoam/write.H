    if (runTime.outputTime())
    {
        volVectorField Ur
        (
            IOobject
            (
                "Ur",
                runTime.timeName(),
                mesh,
                IOobject::NO_READ,
                IOobject::AUTO_WRITE
            ),
            Ua - Ub
        );

        runTime.write();
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
