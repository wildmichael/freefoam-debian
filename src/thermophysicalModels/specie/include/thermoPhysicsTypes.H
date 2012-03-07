/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 1991-2010 OpenCFD Ltd.
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

Typedefs
    Foam::thermoPhysicsTypes

Description
    Type definitions for thermo-physics models

\*---------------------------------------------------------------------------*/

#ifndef thermoPhysicsTypes_H
#define thermoPhysicsTypes_H

#include <specie/perfectGas.H>
#include <specie/hConstThermo.H>
#include <specie/janafThermo.H>
#include <specie/specieThermo.H>
#include <specie/sutherlandTransport.H>
#include <specie/constTransport.H>

#include <specie/icoPolynomial.H>
#include <specie/hPolynomialThermo.H>
#include <specie/polynomialTransport.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
    typedef sutherlandTransport<specieThermo<janafThermo<perfectGas> > >
        gasThermoPhysics;

    typedef constTransport<specieThermo<hConstThermo<perfectGas> > >
        constGasThermoPhysics;

    typedef polynomialTransport
    <
        specieThermo
        <
            hPolynomialThermo
            <
                icoPolynomial<8>,
                8
            >
        >,
        8
    > icoPoly8ThermoPhysics;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //