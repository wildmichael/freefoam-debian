    Info << "\nCreate databases as time" << endl;

    Time runTimeSource
    (
        Time::controlDictName,
        rootDirSource,
        caseDirSource
    );

    Time runTimeTarget
    (
        Time::controlDictName,
        rootDirTarget,
        caseDirTarget
    );

// ************************ vim: set sw=4 sts=4 et: ************************ //
