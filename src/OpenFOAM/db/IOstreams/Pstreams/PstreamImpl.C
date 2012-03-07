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
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*----------------------------------------------------------------------------*/

#include <OpenFOAM/PstreamImpl.H>
#include <OpenFOAM/Pstream.H>
#include <OpenFOAM/debug.H>
#include <OpenFOAM/OSspecific.H>
#include <OpenFOAM/dictionary.H>
#include <OpenFOAM/dlLibraryTable.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

defineTypeNameAndDebug(Foam::PstreamImpl, 0);
defineRunTimeSelectionTable(Foam::PstreamImpl, dictionary);

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

Foam::autoPtr<Foam::PstreamImpl> Foam::PstreamImpl::instance_;

// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

void Foam::PstreamImpl::setParRun(bool& isParallel)
{
    isParallel = true;

    Pout.prefix() = '[' +  name(Pstream::myProcNo()) + "] ";
    Perr.prefix() = '[' +  name(Pstream::myProcNo()) + "] ";
}


void Foam::PstreamImpl::initCommunicationSchedule()
{
    Pstream::initCommunicationSchedule();
}

// * * * * * * * * * * * * * Local Helper Functions  * * * * * * * * * * * * //

// helper function to find the config section name
Foam::word Foam::PstreamConfigSectionName()
{
    // check FREEFOAM_PSTREAM_CONFIG
    if(env("FREEFOAM_PSTREAM_CONFIG"))
    {
        return getEnv("FREEFOAM_PSTREAM_CONFIG");
    }
    else if(debug::controlDict().found("PstreamImplementation"))
    {
        // check the global controlDict::PstreamImplementation::configName
        word configName;
        debug::controlDict().subDict("PstreamImplementation").lookup("configName") >> configName;
        return configName;
    }
    else
    {
        // otherwise return empty
        return word();
    }
}

// * * * * * * * * * * * * * Public Member Functions * * * * * * * * * * * * //

Foam::autoPtr<Foam::PstreamImpl> Foam::PstreamImpl::New()
{
    if(!instance_.valid())
    {
        // load the Pstream library the user wants to use
        loadPstreamLibrary();
        // find the Pstream type the user wants to use
        instance_ =  loadPstreamInstance<PstreamImpl>
        (
            "Pstream",
            "FREEFOAM_PSTREAM_CLASS",
            dictionaryConstructorTablePtr_
        );
    }
    return instance_;
}

void Foam::PstreamImpl::loadPstreamLibrary()
{
    static bool didLoad = false;
    if(!didLoad)
    {
        fileName PstreamLibName;
        // check whether FREEFOAM_PSTREAM_LIBRARY is set
        if(env("FREEFOAM_PSTREAM_LIBRARY"))
        {
            PstreamLibName = getEnv("FREEFOAM_PSTREAM_LIBRARY");
        }
        else
        {
            // otherwise check the global controlDict
            word configName = PstreamConfigSectionName();
            if
            (
                 !configName.empty() &&
                 debug::controlDict().subDict("PstreamImplementation")
                     .subDict(configName).found("library")
            )
            {
                debug::controlDict().subDict("PstreamImplementation")
                    .subDict(configName).lookup("library") >> PstreamLibName;
            }
        }

        // if we found some Pstream library, load it, otherwise assume it is
        // not necessary
        if(!PstreamLibName.empty())
        {
            if(PstreamImpl::debug)
            {
                Info<< "Trying to load Pstream library '" << PstreamLibName << "'" << endl;
            }

            if(!dlLibraryTable::open(PstreamLibName))
            {
                FatalErrorIn
                (
                     "PstreamImpl::loadPstreamLibrary()"
                ) << "Failed to load the library '" << PstreamLibName << "'" << endl
                  << Foam::exit(FatalError);
            }
        }
        else
        {
            if(PstreamImpl::debug)
            {
                WarningIn
                (
                     "PstreamImpl::loadPstreamLibrary()"
                ) << "No Pstream library specified to load" << endl;
            }
        }
        didLoad = true;
    }
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
