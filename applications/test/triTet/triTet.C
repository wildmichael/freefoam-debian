#include <OpenFOAM/point.H>
#include <OpenFOAM/triangle.H>
#include <OpenFOAM/tetrahedron.H>
#include <OpenFOAM/IOstreams.H>

using namespace Foam;

int main()
{
    triangle<point, point> tri
    (
        vector(0, 0, 0),
        vector(1, 0, 0),
        vector(1, 1, 0)
    );

    Info<< "tri circumCentre = " << tri.circumCentre() << endl;
    Info<< "tri circumRadius = " << tri.circumRadius() << endl;

    tetrahedron<point, point> tet
    (
        vector(1, 0, 0),
        vector(0, 1, 0),
        vector(0, 0, 1),
        vector(0.5773502, 0.5773502, 0.5773502)
    );

    Info<< "tet circumCentre = " << tet.circumCentre() << endl;
    Info<< "tet circumRadius = " << tet.circumRadius() << endl;

    vector a(Sin);
    vector b(Sin);
    vector c(Sin);
    vector d(Sin);

    Info<< "tet circumRadius = "
        << tetrahedron<point, point>(a, b, c, d).circumRadius() << endl;

    return 0;
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
