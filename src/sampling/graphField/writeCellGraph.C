#include "writeCellGraph.H"
#include <finiteVolume/volFields.H>
#include <finiteVolume/fvMesh.H>
#include <OpenFOAM/graph.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

void writeCellGraph
(
    const volScalarField& vsf,
    const word& graphFormat
)
{
    graph
    (
        vsf.name(),
        "x",
        vsf.name(),
        vsf.mesh().C().internalField().component(vector::X),
        vsf.internalField()
    ).write(vsf.time().timePath()/vsf.name(), graphFormat);
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
