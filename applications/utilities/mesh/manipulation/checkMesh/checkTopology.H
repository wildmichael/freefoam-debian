#include <OpenFOAM/label.H>
#include <OpenFOAM/wordList.H>

namespace Foam
{
    class polyMesh;

    bool checkSync(const wordList& names);

    label checkTopology(const polyMesh&, const bool, const bool);
}
