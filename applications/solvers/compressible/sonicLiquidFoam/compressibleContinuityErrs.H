{
#   include <finiteVolume/rhoEqn.H>
}
{
    scalar sumLocalContErr =
        (sum(mag(rho - rho0 - psi*(p - p0)))/sum(rho)).value();

    scalar globalContErr = (sum(rho - rho0 - psi*(p - p0))/sum(rho)).value();

    cumulativeContErr += globalContErr;

    Info<< "time step continuity errors : sum local = " << sumLocalContErr
         << ", global = " << globalContErr
         << ", cumulative = " << cumulativeContErr << endl;
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
