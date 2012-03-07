{
    solve
    (
        betav*fvm::ddt(rho, h)
      + mvConvection->fvmDiv(phi, h)
      - fvm::laplacian(Db, h)
     ==
        betav*DpDt
    );

    thermo.correct();
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
