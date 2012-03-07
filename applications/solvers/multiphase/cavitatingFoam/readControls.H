#include <finiteVolume/readTimeControls.H>

scalar maxAcousticCo
(
    readScalar(runTime.controlDict().lookup("maxAcousticCo"))
);


#include <finiteVolume/readPISOControls.H>
