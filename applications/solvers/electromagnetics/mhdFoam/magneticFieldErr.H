Info<< "magnetic flux divergence error = "
    << runTime.deltaT().value()
      *mag(fvc::div(phiB))().weightedAverage(mesh.V()).value()
    << endl;

// ************************ vim: set sw=4 sts=4 et: ************************ //
