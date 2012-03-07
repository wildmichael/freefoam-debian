#include <OpenFOAM/List.H>
#include <OpenFOAM/scalar.H>

using namespace Foam;

void func
(
    List<scalar>& l1,
    const List<scalar>& l2,
    const List<label>& a1,
    const List<label>& a2
)
{
    forAll(l1, i)
    {
        l1[a1[i]] -= l2[a2[i]];
    }
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
