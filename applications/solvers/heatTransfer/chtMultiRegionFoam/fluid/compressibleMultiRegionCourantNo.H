    scalar CoNum = -GREAT;

    forAll(fluidRegions, regionI)
    {
        CoNum = max
        (
            compressibleCourantNo
            (
                fluidRegions[regionI],
                runTime,
                rhoFluid[regionI],
                phiFluid[regionI]
            ),
            CoNum
        );
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
