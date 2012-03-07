#include "writePatchGraph.H"
#include <finiteVolume/volFields.H>
#include <finiteVolume/fvMesh.H>
#include <OpenFOAM/graph.H>


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

void writePatchGraph
(
    const volScalarField& vsf,
    const label patchLabel,
    const direction d,
    const word& graphFormat
)
{
    graph
    (
        vsf.name(),
        "position",
        vsf.name(),
        vsf.mesh().boundary()[patchLabel].Cf().component(d),
        vsf.boundaryField()[patchLabel]
    ).write(vsf.time().timePath()/vsf.name(), graphFormat);
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
