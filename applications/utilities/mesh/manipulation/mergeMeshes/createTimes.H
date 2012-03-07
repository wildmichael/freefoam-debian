    Info<< nl << "Create Times" << endl;

    Time runTimeMaster
    (
        Time::controlDictName,
        rootDirMaster,
        caseDirMaster
    );

    Time runTimeToAdd
    (
        Time::controlDictName,
        rootDirToAdd,
        caseDirToAdd
    );

// ************************ vim: set sw=4 sts=4 et: ************************ //
