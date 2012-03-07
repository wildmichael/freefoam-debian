    Info<< "Create mesh for time = "
        << runTime.timeName() << nl << endl;

    autoPtr<dynamicFvMesh> meshPtr
    (
        dynamicFvMesh::New
        (
            IOobject
            (
                dynamicFvMesh::defaultRegion,
                runTime.timeName(),
                runTime
            )
        )
    );

    dynamicFvMesh& mesh = meshPtr();

// ************************ vim: set sw=4 sts=4 et: ************************ //
