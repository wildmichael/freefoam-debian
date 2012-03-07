// check convergence

if (maxResidual < convergenceCriterion)
{
    Info<< "reached convergence criterion: " << convergenceCriterion << endl;
    runTime.writeAndEnd();
    Info<< "latestTime = " << runTime.timeName() << endl;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
