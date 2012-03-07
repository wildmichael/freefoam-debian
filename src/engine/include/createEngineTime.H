    Info<< "Create engine time\n" << endl;

    engineTime runTime
    (
        Time::controlDictName,
        args.rootPath(),
        args.caseName()
    );

// ************************ vim: set sw=4 sts=4 et: ************************ //
