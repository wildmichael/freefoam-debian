#   include <finiteVolume/readTimeControls.H>
#   include <finiteVolume/readPISOControls.H>

    bool correctPhi = true;
    if (piso.found("correctPhi"))
    {
        correctPhi = Switch(piso.lookup("correctPhi"));
    }

    bool checkMeshCourantNo = false;
    if (piso.found("checkMeshCourantNo"))
    {
        checkMeshCourantNo = Switch(piso.lookup("checkMeshCourantNo"));
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
