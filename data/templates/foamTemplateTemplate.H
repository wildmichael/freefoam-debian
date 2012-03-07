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

Class
    Foam::ClassName

Description

SourceFiles
    ClassNameI.H
    ClassName.C
    ClassNameIO.C

\*---------------------------------------------------------------------------*/

#ifndef ClassName_H
#define ClassName_H

#include </.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// Forward declaration of classes
class someClass;


// Forward declaration of friend functions and operators

template<TemplateClassArgument>
class ClassName;

template<TemplateClassArgument>
Istream& operator>>(Istream&, ClassName<TemplateArgument>&);

template<TemplateClassArgument>
Ostream& operator<<(Ostream&, const ClassName<TemplateArgument>&);


/*---------------------------------------------------------------------------*\
                         Class ClassName Declaration
\*---------------------------------------------------------------------------*/

template<TemplateClassArgument>
class ClassName
:
    public baseClassName
{
    // Private data

        dataType data_;


    // Private Member Functions

        //- Disallow default bitwise copy construct
        ClassName(const ClassName<TemplateArgument>&);

        //- Disallow default bitwise assignment
        void operator=(const ClassName<TemplateArgument>&);


public:

    // Static data members

        //- Static data someStaticData
        static const dataType staticData;


    // Constructors

        //- Construct null
        ClassName();

        //- Construct from components
        ClassName(const dataType& data);

        //- Construct from Istream
        ClassName(Istream&);

        //- Construct as copy
        ClassName(const ClassName<TemplateArgument>&);


    // Selectors

        //- Select null constructed
        static autoPtr<ClassName<TemplateArgument> > New();


    //- Destructor
    ~ClassName();


    // Member Functions

    // Member Operators

        void operator=(const ClassName<TemplateArgument>&);


    // Friend Functions

    // Friend Operators

    // IOstream Operators

        friend Istream& operator>> <TemplateArgument>
        (Istream&, ClassName<TemplateArgument>&);

        friend Ostream& operator<< <TemplateArgument>
        (Ostream&, const ClassName<TemplateArgument>&);
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#include <LibName/ClassNameI.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#ifdef NoRepository
#   include <LibName/ClassName.C>
#endif

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
