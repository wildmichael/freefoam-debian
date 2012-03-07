IOobject ioPoints
(
    "points", 
    runTime.timeName(),
    mesh.name(),
    mesh
);

if (ioPoints.headerOk())
{
    Info << "new points available" << endl;
    // Reading new points
    pointIOField newPoints
    (
        IOobject
        (
            "points",
            runTime.timeName(),
            mesh.name(),
            mesh,
            IOobject::MUST_READ,
            IOobject::NO_WRITE
        )
    );
    
    mesh.movePoints(newPoints);
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
