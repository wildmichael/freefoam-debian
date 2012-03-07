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

Class
    Foam::dummyIPstreamImpl

Description
    Dummy implementation of the IPstreamImpl abstract base class.

SourceFiles
    dummyIPstreamImpl.C

\*----------------------------------------------------------------------------*/

#ifndef dummyIPstreamImpl_H
#define dummyIPstreamImpl_H

#include <OpenFOAM/IPstreamImpl.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                           Class dummyIPstreamImpl Declaration
\*---------------------------------------------------------------------------*/

class dummyIPstreamImpl
:
    public IPstreamImpl
{
    // Private Member Functions

        //- Disallow default bitwise copy construct
        dummyIPstreamImpl(const dummyIPstreamImpl&);

        //- Disallow default bitwise assignment
        void operator=(const dummyIPstreamImpl&);

public:

    // Declare name of the class and its debug switch
    TypeName("dummyIPstreamImpl");

    // Constructors

        //- Construct null
        dummyIPstreamImpl(){}

    // Member Functions

        //- Initialization
        virtual void init
        (
            const PstreamImpl::commsTypes commsType,
            const label bufSize,
            int& fromProcNo,
            label& messageSize,
            List<char>& buf
        );

        //- Read into given buffer from given processor and return the
        //  message size
        virtual label read
        (
           const PstreamImpl::commsTypes commsType,
           const int fromProcNo,
           char* buf,
           const std::streamsize bufSize
        );

        //- Non-blocking receives: wait until all have finished.
        virtual void waitRequests();

        //- Non-blocking receives: has request i finished?
        virtual bool finishedRequest(const label i);
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************ vim: set sw=4 sts=4 et: ************************ //
