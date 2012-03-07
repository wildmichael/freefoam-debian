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

Application
    equilibriumCO
    freefoam-equilibriumCO

Description
    Calculates the equilibrium level of carbon monoxide

Usage

    - equilibriumCO [OPTIONS]

    @param -case \<dir\>\n
    Case directory.

    @param -parallel \n
    Run in parallel.

    @param -help \n
    Display help message.

    @param -doc \n
    Display Doxygen API documentation page for this application.

    @param -srcDoc \n
    Display Doxygen source documentation page for this application.

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/argList.H>
#include <OpenFOAM/Time.H>
#include <OpenFOAM/dictionary.H>
#include <OpenFOAM/IFstream.H>
#include <OpenFOAM/OSspecific.H>
#include <OpenFOAM/IOmanip.H>

#include <specie/specieThermo.H>
#include <specie/janafThermo.H>
#include <specie/perfectGas.H>
#include <OpenFOAM/SLPtrList.H>

using namespace Foam;

typedef specieThermo<janafThermo<perfectGas> > thermo;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{

#   include <OpenFOAM/setRootCase.H>

#   include <OpenFOAM/createTime.H>

    Info<< nl << "Reading Burcat data IOdictionary" << endl;

    IOdictionary CpData
    (
        IOobject
        (
            "BurcatCpData",
            runTime.constant(),
            runTime,
            IOobject::MUST_READ,
            IOobject::NO_WRITE,
            false
        )
    );



    scalar T = 3000.0;

    SLPtrList<thermo> EQreactions;

    EQreactions.append
    (
        new thermo
        (
            thermo(CpData.lookup("CO2"))
         ==
            thermo(CpData.lookup("CO"))
          + 0.5*thermo(CpData.lookup("O2"))
        )
    );

    EQreactions.append
    (
        new thermo
        (
            thermo(CpData.lookup("O2"))
         ==
            2.0*thermo(CpData.lookup("O"))
        )
    );

    EQreactions.append
    (
        new thermo
        (
            thermo(CpData.lookup("H2O"))
         ==
            thermo(CpData.lookup("H2"))
          + 0.5*thermo(CpData.lookup("O2"))
        )
    );

    EQreactions.append
    (
        new thermo
        (
            thermo(CpData.lookup("H2O"))
         ==
            thermo(CpData.lookup("H"))
          + thermo(CpData.lookup("OH"))
        )
    );


    for
    (
        SLPtrList<thermo>::iterator EQreactionsIter = EQreactions.begin();
        EQreactionsIter != EQreactions.end();
        ++EQreactionsIter
    )
    {
        Info<< "Kc(EQreactions) = " << EQreactionsIter().Kc(T) << endl;
    }


    Info<< nl << "end" << endl;

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //


