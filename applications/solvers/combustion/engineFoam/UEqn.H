    fvVectorMatrix UEqn
    (
        fvm::ddt(rho, U)
      + fvm::div(phi, U)
      + turbulence->divDevRhoReff(U)
    );

    if (momentumPredictor)
    {
        solve(UEqn == -fvc::grad(p));
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
