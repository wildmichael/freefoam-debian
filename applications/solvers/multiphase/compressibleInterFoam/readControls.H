   #include <finiteVolume/readPISOControls.H>
   #include <finiteVolume/readTimeControls.H>

    label nAlphaCorr
    (
        readLabel(piso.lookup("nAlphaCorr"))
    );

    label nAlphaSubCycles
    (
        readLabel(piso.lookup("nAlphaSubCycles"))
    );

    if (nAlphaSubCycles > 1 && nOuterCorr != 1)
    {
        FatalErrorIn(args.executable())
            << "Sub-cycling alpha is only allowed for PISO, "
               "i.e. when the number of outer-correctors = 1"
            << exit(FatalError);
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
