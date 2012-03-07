const dictionary& Bpiso = mesh.solutionDict().subDict("BPISO");

int nBcorr(readInt(Bpiso.lookup("nCorrectors")));

// ************************ vim: set sw=4 sts=4 et: ************************ //
