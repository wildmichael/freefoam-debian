#   include <finiteVolume/readPISOControls.H>

    int nAlphaCorr(readInt(piso.lookup("nAlphaCorr")));

    Switch correctAlpha(piso.lookup("correctAlpha"));

// ************************ vim: set sw=4 sts=4 et: ************************ //
