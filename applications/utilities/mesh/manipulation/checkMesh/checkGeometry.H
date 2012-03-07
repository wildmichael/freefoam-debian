#include <OpenFOAM/label.H>
#include <OpenFOAM/HashSet.H>
#include <OpenFOAM/labelVector.H>

namespace Foam
{
    class polyMesh;
    class wedgePolyPatch;

    label findOppositeWedge(const polyMesh&, const wedgePolyPatch&);

    bool checkWedges
    (
        const polyMesh&,
        const bool report,
        const Vector<label>&,
        labelHashSet*
    );

    label checkGeometry(const polyMesh& mesh, const bool allGeometry);
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
