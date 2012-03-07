// initialize values for convergence checks

    scalar eqnResidual = 1, maxResidual = 0;
    scalar convergenceCriterion = 0;

    simple.readIfPresent("convergence", convergenceCriterion);


// ************************ vim: set sw=4 sts=4 et: ************************ //
