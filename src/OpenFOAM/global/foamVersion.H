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

Namespace
    Foam

Description
    Namespace for OpenFOAM

    @var Foam::FOAMversion
    Short version number string

    @var Foam::FOAMfullVersion
    Full version number string

    @var Foam::FOAMConfigDir
    Directory in the installation containing the configuration files

    @var Foam::FOAMbuild
    Build identifier (the short SHA1-hash of the last git commit)

    @var Foam::FOAMupstreamVersion
    Version number of upstream OpenFOAM project

SourceFiles
    global.C.in

\*---------------------------------------------------------------------------*/

#ifndef foamVersion_H
#define foamVersion_H

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
    extern const char* const FOAMversion;
    extern const char* const FOAMfullVersion;
    extern const char* const FOAMConfigDir;
    extern const char* const FOAMbuild;
    extern const char* const FOAMupstreamVersion;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
