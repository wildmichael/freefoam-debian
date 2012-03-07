{
    IOobject io
    (
        "points",
        runTime.timeName(),
        polyMesh::meshSubDir,
        mesh
    );

    if (io.headerOk())
    {
        // Read new points
        io.readOpt() = IOobject::MUST_READ;
        mesh.movePoints(pointIOField(io));
    }
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
