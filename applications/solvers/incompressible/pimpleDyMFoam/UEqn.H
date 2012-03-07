    fvVectorMatrix UEqn
    (
        fvm::ddt(U)
      + fvm::div(phi, U)
      + turbulence->divDevReff(U)
    );

    if (ocorr != nOuterCorr-1)
    {
        UEqn.relax();
    }

    if (momentumPredictor)
    {
        solve(UEqn == -fvc::grad(p));
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
