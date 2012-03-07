{
    solve
    (
        fvm::ddt(rho, h)
      + fvm::div(phi, h)
      - fvm::laplacian(turbulence->alphaEff(), h)
     ==
        DpDt
    );

    thermo.correct();
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
