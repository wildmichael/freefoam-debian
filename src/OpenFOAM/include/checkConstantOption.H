//
// checkConstantOption.H
// ~~~~~~~~~~~~~~~~~~~~~
// unless -constant is present, skip startTime if it is "constant"

    if
    (
        !args.optionFound("constant")
     && (startTime < Times.size()-1)
     && (Times[startTime].name() == "constant")
    )
    {
        startTime++;
    }

// ************************ vim: set sw=4 sts=4 et: ************************ //
