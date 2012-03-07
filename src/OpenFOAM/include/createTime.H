//
// createTime.H
// ~~~~~~~~~~~~

    Foam::Info<< "Create time\n" << Foam::endl;

    Foam::Time runTime
    (
        Foam::Time::controlDictName,
        args.rootPath(),
        args.caseName()
    );

// ************************ vim: set sw=4 sts=4 et: ************************ //
