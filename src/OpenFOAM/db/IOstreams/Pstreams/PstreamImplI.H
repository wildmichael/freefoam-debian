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
#include <OpenFOAM/debug.H>
#include <OpenFOAM/OSspecific.H>
#include <OpenFOAM/dictionary.H>
#include <OpenFOAM/dlLibraryTable.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam {

// * * * * * * * * * * * * * Local Helper Functions  * * * * * * * * * * * * //

// helper function to find the config section name
word PstreamConfigSectionName();

// * * * * * * * * * * * * * Public Member Functions * * * * * * * * * * * * //

template<class T, class CTable>
autoPtr<T> PstreamImpl::loadPstreamInstance(const word& dictEntry, const word& envName, CTable* ctable)
{
    word PstreamClassName;
    // check whether the environment variable is set
    if(env(envName))
    {
        PstreamClassName = getEnv(envName);
    }
    else
    {
        // otherwise check the global controlDict
        word configName = PstreamConfigSectionName();
        debug::controlDict().subDict("PstreamImplementation")
            .subDict(configName).lookup(dictEntry) >> PstreamClassName;
    }

    if(PstreamImpl::debug)
    {
        Info<< "Trying to instantiate '" << PstreamClassName << "'" << endl;
    }

    typename CTable::iterator cstrIter =
        ctable->find(PstreamClassName);

    if (cstrIter == ctable->end())
    {
        FatalErrorIn
        (
            "PstreamImpl::loadPstreamInstance(const word&, const word&)"
        )   << "Unknown type '" << PstreamClassName << "'"
            << endl << endl
            << "Valid types are :" << endl
            << ctable->toc()
            << Foam::exit(FatalError);
    }

    // instantiate
    return cstrIter()();
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************ vim: set sw=4 sts=4 et: ************************ //
