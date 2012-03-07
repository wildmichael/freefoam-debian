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
#include <OpenFOAM/OStringStream.H>

#include <cxxabi.h>
#include <execinfo.h>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Local helper function
void tokenizeSymbols( const Foam::string& symbols, Foam::string& module,
                      Foam::string& address, Foam::string& function,
                      Foam::string& offset )
{
    size_t s(0), e;
    // Mac OS X uses a different output format for backtrac_symbols.
    // Thanks Apple, really.
#ifdef darwin
    // this is for Mac OS X 10.5 Leopard and newer
    std::string blanks(" \t");
    // format: level module address function + offset
    // skip the stack level
    s = symbols.find_first_of(blanks,s);
    // find the module name
    s = symbols.find_first_not_of(blanks,s+1);
    e = symbols.find_first_of(blanks,s+1);
    module = symbols.substr(s,e-s);
    // find the address
    s = symbols.find_first_not_of(blanks,e+1);
    e = symbols.find_first_of(blanks,s+1);
    address = symbols.substr(s,e-s);
    // find the (mangled) function name
    s = symbols.find_first_not_of(blanks,e+1);
    e = symbols.find_first_of(blanks,s+1);
    function = symbols.substr(s,e-s);
    // skip the + sign
    s = symbols.find_first_not_of(blanks,e+1);
    e = symbols.find_first_of(blanks,s+1);
    // find the offset into the function
    s = symbols.find_first_not_of(blanks,e+1);
    e = symbols.find_first_of(blanks,s+1);
    offset = symbols.substr(s,e-s);
#else
    // this is for GNU glibc (assumed)
    // format: module(function+offset) [address]
    // find the module name
    e = symbols.find('(',s);
    module = symbols.substr(s,e-s);
    // find the (mangled) function name
    s = e;
    e = symbols.find('+',s+1);
    function = symbols.substr(s+1,e-s-1);
    // find the offset
    s = e;
    e = symbols.find(')',s+1);
    offset = symbols.substr(s+1,e-s-1);
    // find the address
    s = symbols.find('[',s+1);
    e = symbols.find(']',s+2);
    address = symbols.substr(s+1,e-s-1);
#endif
}


void Foam::error::printStack(Foam::Ostream& os)
{
    os << "  Stack trace:\n";

    // storage array for stack trace address data
    const size_t max_frames = 100;
    void* addrlist[max_frames];

    // retrieve current stack addresses
    int addrlen = backtrace(addrlist, sizeof(addrlist) / sizeof(void*));

    if (addrlen == 0) {
        os << "*        <EMPTY BACKTRACE, POSSIBLY CORRUPT STACK.>        *\n";
    } else {
        // resolve addresses into strings containing "filename(function+address)",
        // this array must be free()-ed
        char** symbollist = backtrace_symbols(addrlist, addrlen);

        // allocate string which will be filled with the demangled function name
        size_t funcnamesize = 256;
        char* funcname = new char[funcnamesize];

        // iterate over the returned symbol lines. skip the first two, it is the
        // address of this function and the sigSegvImpl::sigSegvHandler function.
        for (size_t i = 2; i < addrlen; i++)
        {
            // tokenize the symbols string
            string module, function, address, offset;
            tokenizeSymbols( symbollist[i], module, address, function, offset );

            if (! (module.empty() || address.empty() || function.empty() || offset.empty()) )
            {
                // try to demangle
                int status;
                char* ret = abi::__cxa_demangle(function.c_str(), NULL, 0, &status);
                if (status == 0) {
                    function.assign( ret );
                    free( ret );
                    os << "  " << int(i-2) << " " << module.c_str() << " [" << address.c_str() << "]: "
                        << function.c_str() << " + " << offset.c_str() << "\n";
                }
                else {
                    // demangling failed. Output function name as a C function with
                    // no arguments.
                    os << "  " << int(i-2) << " " << module.c_str() << " [" << address.c_str() << "]: "
                        << function.c_str() << " + " << offset.c_str() << "\n";
                }
            }
            else
            {
                // couldn't parse the line? print the whole line.
                os << "  " << int(i-2) << " " << symbollist[i] << "\n";
            }
        }

        delete[] funcname;
        free(symbollist);
    }
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
