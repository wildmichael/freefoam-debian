Info<< "Total cylinder mass: " << fvc::domainIntegrate(rho).value() << endl;

OFstream logSummaryFile
(
    runTime.path()/("logSummary." + runTime.timeName() + ".dat")
);

logSummaryFile
    << "# CA" << "      p" << "        T" << "       u'" << endl;

// ************************ vim: set sw=4 sts=4 et: ************************ //
