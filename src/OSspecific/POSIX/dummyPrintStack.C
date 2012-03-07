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
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*----------------------------------------------------------------------------*/

#include <OpenFOAM/error.H>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

void Foam::error::printStack(Ostream& os)
{
    os << "* This  version of  FreeFoam does  not support  creating a *\n"
          "* backtrace by  itself to help locating  the problem. This *\n"
          "* may  be because  FreeFOAM was  not compiled  as a  debug *\n"
          "* version,  no GNU  compiler  was used  or your  operating *\n"
          "* system doesn't provide  the necessary functionality. You *\n"
          "* may  still obtain  a  backtrace on  Unix like  operating *\n"
          "* systems (such as  Linux or Mac OS X 10.5)  by having the *\n"
          "* operating  system  create a  core  dump  of the  crashed *\n"
          "* program and inspecting it using a debugger, such as GDB. *\n";
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
