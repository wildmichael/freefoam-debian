const dictionary& stressControl = mesh.solutionDict().subDict("stressAnalysis");

scalar accFac(readScalar(stressControl.lookup("accelerationFactor")));

// ************************ vim: set sw=4 sts=4 et: ************************ //
