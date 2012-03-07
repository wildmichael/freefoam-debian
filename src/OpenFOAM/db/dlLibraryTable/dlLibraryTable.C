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

\*---------------------------------------------------------------------------*/

#include <OpenFOAM/dlLibraryTable.H>
#include <OpenFOAM/debug.H>

#include <dlfcn.h>

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

Foam::dlLibraryTable Foam::dlLibraryTable::loadedLibraries;


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::dlLibraryTable::dlLibraryTable()
:
    HashTable<fileName, void*, Hash<void*> >()
{}


Foam::dlLibraryTable::readDlLibrary::readDlLibrary
(
    const dictionary& dict,
    const word& libsEntry
)
{
    open(dict, libsEntry);
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::dlLibraryTable::~dlLibraryTable()
{
    // Don't bother with calling dlclose(), the OS does so anyways and it can
    // even cause problems if the generated finalization code decides to unload
    // the loaded library before calling this dtor.
}

// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

bool Foam::dlLibraryTable::open(const fileName& functionLibName)
{
    if (functionLibName.size())
    {
        void* functionLibPtr = NULL;
        // set up the list of paths to search the library in
        fileNameList searchPathList;
        // add the paths listed in controlDict::LibrarySearchPaths to the list
        // if the library name is not absolute
        if (functionLibName[0] != '/' && debug::controlDict().found("LibrarySearchPaths"))
        {
            debug::controlDict().lookup("LibrarySearchPaths") >> searchPathList;
        }
        // in any case, we want to also try the default search paths
        // (i.e. LD_LIBRARY_PATH etc.) or, if functionLibName is an
        // absolute path, that one. So we append an empty string.
        searchPathList.setSize(searchPathList.size()+1,fileName());
        forAllConstIter(fileNameList, searchPathList, pathI)
        {
            // construct the full name
            fileName functionLibPath;
            if (!pathI->empty())
                functionLibPath = *pathI / functionLibName;
            else
                functionLibPath = functionLibName;
            functionLibPtr = dlopen(functionLibPath.c_str(), RTLD_LAZY|RTLD_GLOBAL);

#ifdef darwin
            if(!functionLibPtr && functionLibPath.ext()=="so") {
                functionLibPath=functionLibPath.lessExt()+".dylib";
                functionLibPtr =
                    dlopen(functionLibPath.c_str(), RTLD_LAZY|RTLD_GLOBAL);
            }
#endif
            // if successfully loaded, stop searching and display some info
            if (functionLibPtr)
            {
                Info<< "Loaded  " << functionLibName;
                if (pathI->empty())
                    Info<< " from the default search path";
                else
                    Info<< " from " << functionLibPath;
                Info<< endl;
                break;
            }
        }
        if (!functionLibPtr)
        {
            WarningIn
            (
                "dlLibraryTable::open(const fileName& functionLibName)"
            )   << "could not load " << dlerror()
                << endl;

            return false;
        }
        else
        {
            if (!loadedLibraries.found(functionLibPtr))
            {
                loadedLibraries.insert(functionLibPtr, functionLibName);
                return true;
            }
            else
            {
                return false;
            }
        }
    }
    else
    {
        return false;
    }
}


bool Foam::dlLibraryTable::open
(
    const dictionary& dict,
    const word& libsEntry
)
{
    if (dict.found(libsEntry))
    {
        fileNameList libNames(dict.lookup(libsEntry));

        bool allOpened = (libNames.size() > 0);

        forAll(libNames, i)
        {
            allOpened = dlLibraryTable::open(libNames[i]) && allOpened;
        }

        return allOpened;
    }
    else
    {
        return false;
    }
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
