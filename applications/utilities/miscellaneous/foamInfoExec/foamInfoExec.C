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
    foamInfoExec

Description
    Interrogates a case and prints information to screen

Usage

    - foamInfoExec [OPTIONS]

    @param -dictionary \<dictionary name\>\n
    Use specified dictionary.

    @param -entry \<entry name\>\n
    Use specified entry from dictionary (parent:child notation)

    @param -keywords \n
    List keywords in the dictionary.

    @param -times \n
    List all time steps.

    @param -case \<dir\>\n
    Case directory.

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

using namespace Foam;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// Main program:

int main(int argc, char *argv[])
{
    argList::noParallel();
    argList::validOptions.insert("times", "");
    argList::validOptions.insert("dictionary", "dictionary name");
    argList::validOptions.insert("keywords", "");
    argList::validOptions.insert("entry", "entry name");

#   include <OpenFOAM/setRootCase.H>

    Info<< endl;

    if (args.optionFound("times"))
    {
        instantList times
        (
            Foam::Time::findTimes(args.rootPath()/args.caseName())
        );

        forAll (times, i)
        {
            Info<< times[i].name() << endl;
        }
    }

    if (args.optionFound("dictionary"))
    {
        fileName dictFileName
        (
            args.rootPath()/args.caseName()/args.option("dictionary")
        );

        IFstream dictFile(dictFileName);

        if (dictFile.good())
        {
            dictionary dict(dictFile);

            if (args.optionFound("keywords") && !args.optionFound("entry"))
            {
                for
                (
                    IDLList<entry>::iterator iter = dict.begin();
                    iter != dict.end();
                    ++iter
                )
                {
                    Info<< iter().keyword() << endl;
                }
            }
            else if (args.optionFound("entry"))
            {
                wordList entryNames
                (
                    fileName(args.option("entry")).components(':')
                );

                if (dict.found(entryNames[0]))
                {
                    const entry* entPtr = &dict.lookupEntry
                    (
                        entryNames[0],
                        false,
                        true            // wildcards
                    );

                    for (int i=1; i<entryNames.size(); i++)
                    {
                        if (entPtr->dict().found(entryNames[i]))
                        {
                            entPtr = &entPtr->dict().lookupEntry
                            (
                                entryNames[i],
                                false,
                                true    // wildcards
                            );
                        }
                        else
                        {
                            FatalErrorIn(args.executable())
                                << "Cannot find sub-entry " << entryNames[i]
                                << " in entry " << args.option("entry")
                                << " in dictionary " << dictFileName;
                            FatalError.exit(3);
                        }
                    }

                    if (args.optionFound("keywords"))
                    {
                        /*
                        if (ent[1] != token::BEGIN_BLOCK)
                        {
                            FatalErrorIn(args.executable())
                                << "Cannot find entry "
                                << args.option("entry")
                                << " in dictionary " << dictFileName
                                << " is not a sub-dictionary";
                            FatalError.exit(4);
                        }
                        */

                        const dictionary& dict(entPtr->dict());
                        for
                        (
                            IDLList<entry>::const_iterator iter = dict.begin();
                            iter != dict.end();
                            ++iter
                        )
                        {
                            Info<< iter().keyword() << endl;
                        }
                    }
                    else
                    {
                        Info<< *entPtr << endl;
                    }
                }
                else
                {
                    FatalErrorIn(args.executable())
                        << "Cannot find entry "
                        << entryNames[0]
                        << " in dictionary " << dictFileName;
                    FatalError.exit(2);
                }
            }
            else
            {
                Info<< dict;
            }
        }
        else
        {
            FatalErrorIn(args.executable())
                << "Cannot open file " << dictFileName;
            FatalError.exit(1);
        }
    }

    return 0;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
