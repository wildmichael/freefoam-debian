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

#include "dictionary.H"
#include <OpenFOAM/primitiveEntry.H>

// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

template<class T>
T Foam::dictionary::lookupOrDefault
(
    const word& keyword,
    const T& deflt,
    bool recursive,
    bool patternMatch
) const
{
    const entry* entryPtr = lookupEntryPtr(keyword, recursive, patternMatch);

    if (entryPtr)
    {
        return pTraits<T>(entryPtr->stream());
    }
    else
    {
        return deflt;
    }
}


template<class T>
T Foam::dictionary::lookupOrAddDefault
(
    const word& keyword,
    const T& deflt,
    bool recursive,
    bool patternMatch
)
{
    const entry* entryPtr = lookupEntryPtr(keyword, recursive, patternMatch);

    if (entryPtr)
    {
        return pTraits<T>(entryPtr->stream());
    }
    else
    {
        add(new primitiveEntry(keyword, deflt));
        return deflt;
    }
}


template<class T>
bool Foam::dictionary::readIfPresent
(
    const word& k,
    T& val,
    bool recursive,
    bool patternMatch
) const
{
    const entry* entryPtr = lookupEntryPtr(k, recursive, patternMatch);

    if (entryPtr)
    {
        entryPtr->stream() >> val;
        return true;
    }
    else
    {
        return false;
    }
}


template<class T>
void Foam::dictionary::add(const keyType& k, const T& t, bool overwrite)
{
    add(new primitiveEntry(k, t), overwrite);
}


template<class T>
void Foam::dictionary::set(const keyType& k, const T& t)
{
    set(new primitiveEntry(k, t));
}

#if __GNUC__ == 4 && __GNUC_MINOR__ < 4
// gcc < 4.4 doesn't seem to find Switch::operator bool().
#include <OpenFOAM/Switch.H>
namespace Foam {
template<>
inline Switch dictionary::lookupOrDefault<Switch>
(
    const word& keyword,
    const Switch& deflt,
    bool recursive,
    bool patternMatch
) const
{
    const entry* entryPtr = lookupEntryPtr(keyword, recursive, patternMatch);

    if (entryPtr)
    {
        return Switch(entryPtr->stream());
    }
    else
    {
        return deflt;
    }
}

template<>
inline
Switch Foam::dictionary::lookupOrAddDefault<Switch>
(
    const word& keyword,
    const Switch& deflt,
    bool recursive,
    bool patternMatch
)
{
    const entry* entryPtr = lookupEntryPtr(keyword, recursive, patternMatch);

    if (entryPtr)
    {
        return Switch(entryPtr->stream());
    }
    else
    {
        add(new primitiveEntry(keyword, deflt));
        return deflt;
    }
}
}
#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
