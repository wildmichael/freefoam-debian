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

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

template<TemplateClassArgument>
const dataType Foam::ClassName<TemplateArgument>::staticData();


// * * * * * * * * * * * * Static Member Functions * * * * * * * * * * * * * //


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

template<TemplateClassArgument>
Foam::ClassName<TemplateArgument>::ClassName()
:
    baseClassName(),
    data_()
{}


template<TemplateClassArgument>
Foam::ClassName<TemplateArgument>::ClassName(const dataType& data)
:
    baseClassName(),
    data_(data)
{}


template<TemplateClassArgument>
Foam::ClassName<TemplateArgument>::ClassName
(
    const ClassName<TemplateArgument>&
)
:
    baseClassName(),
    data_()
{}


// * * * * * * * * * * * * * * * * Selectors * * * * * * * * * * * * * * * * //

template<TemplateClassArgument>
Foam::autoPtr<Foam::ClassName<TemplateArgument> >
Foam::ClassName<TemplateArgument>::New()
{
    return autoPtr<ClassName<TemplateArgument> >
    (
        new ClassName<TemplateArgument>
    );
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

template<TemplateClassArgument>
Foam::ClassName<TemplateArgument>::~ClassName()
{}


// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //


// * * * * * * * * * * * * Protected Member Functions  * * * * * * * * * * * //


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //


// * * * * * * * * * * * * * * Member Operators  * * * * * * * * * * * * * * //

template<TemplateClassArgument>
void Foam::ClassName<TemplateArgument>::operator=
(
    const ClassName<TemplateArgument>& rhs
)
{
    // Check for assignment to self
    if (this == &rhs)
    {
        FatalErrorIn
        (
            "Foam::ClassName<TemplateArgument>::operator="
            "(const Foam::ClassName<TemplateArgument>&)"
        )   << "Attempted assignment to self"
            << abort(FatalError);
    }
}


// * * * * * * * * * * * * * * Friend Functions * * * * * * * * * * * * * * //


// * * * * * * * * * * * * * * Friend Operators * * * * * * * * * * * * * * //


// *********************** vim: set sw=4 sts=4 et: ************************ //
