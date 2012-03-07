/*----------------------------------------------------------------------------*\
                ______                _     ____          __  __
               |  ____|             _| |_  / __ \   /\   |  \/  |
               | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
               |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
               | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
               |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|

                    FreeFOAM: The Cross-Platform CFD Toolkit

  Copyright (C) 2008-2012 Michael Wild <themiwi@users.sf.net>
                          Gerber van der Graaf <gerber_graaf@users.sf.net>
--------------------------------------------------------------------------------
License
    This file is part of FreeFOAM.

    FreeFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include <LibName/ClassName.H>
#include <OpenFOAM/IOstreams.H>

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

template<TemplateClassArgument>
Foam::ClassName<TemplateArgument>::ClassName(Istream& is)
:
    base1(is),
    base2(is),
    member1(is),
    member2(is)
{
    // Check state of Istream
    is.check("Foam::ClassName<TemplateArgument>::ClassName(Foam::Istream&)");
}


// * * * * * * * * * * * * * * * IOstream Operators  * * * * * * * * * * * * //

template<TemplateClassArgument>
Foam::Istream& Foam::operator>>
(
    Istream& is,
    ClassName<TemplateArgument>&
)
{
    // Check state of Istream
    is.check
    (
        "Foam::Istream& Foam::operator>>"
        "(Foam::Istream&, Foam::ClassName<TemplateArgument>&)"
    );

    return is;
}


template<TemplateClassArgument>
Foam::Ostream& Foam::operator<<
(
    Ostream& os,
    const ClassName<TemplateArgument>&
)
{
    // Check state of Ostream
    os.check
    (
        "Foam::Ostream& Foam::operator<<"
        "(Ostream&, const ClassName<TemplateArgument>&)"
    );

    return os;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
