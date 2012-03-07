/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 1991-2011 OpenCFD Ltd.
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

Class
    Foam::tableReader

Description
    Base class to read table data for the interpolationTable

SourceFiles
    tableReader.C

\*---------------------------------------------------------------------------*/

#ifndef tableReader_H
#define tableReader_H

#include <OpenFOAM/fileName.H>
#include <OpenFOAM/wordList.H>
#include <OpenFOAM/vector.H>
#include <OpenFOAM/tensor.H>
#include <OpenFOAM/typeInfo.H>
#include <OpenFOAM/runTimeSelectionTables.H>
#include <OpenFOAM/autoPtr.H>
#include <OpenFOAM/dictionary.H>
#include <OpenFOAM/Tuple2.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class tableReader Declaration
\*---------------------------------------------------------------------------*/

template<class Type>
class tableReader
{

public:

    //- Runtime type information
    TypeName("tableReader");

    // Declare run-time constructor selection table

        declareRunTimeSelectionTable
        (
            autoPtr,
            tableReader,
            dictionary,
            (const dictionary& dict),
            (dict)
        );


    // Constructors

        //- Construct from dictionary
        tableReader(const dictionary& dict);

        //- Construct and return a clone
        virtual autoPtr<tableReader<Type> > clone() const = 0;


    // Selectors

        //- Return a reference to the selected tableReader
        static autoPtr<tableReader> New(const dictionary& spec);


    //- Destructor

        virtual ~tableReader();


    // Member functions

        //- Read the table
        virtual void operator()
        (
            const fileName&,
            List<Tuple2<scalar, Type> >&
        ) = 0;

        //- Write additional information
        virtual void write(Ostream& os) const;

};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#ifdef NoRepository
#   include "tableReader.C"
#endif


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
