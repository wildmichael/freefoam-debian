    const dictionary& piso = solidRegions[i].solutionDict().subDict("PISO");

    int nNonOrthCorr = 0;
    if (piso.found("nNonOrthogonalCorrectors"))
    {
        nNonOrthCorr = readInt(piso.lookup("nNonOrthogonalCorrectors"));
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
