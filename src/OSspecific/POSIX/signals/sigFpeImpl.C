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

#include <OpenFOAM/error.H>
#include "sigFpeImpl.H"

#include <OpenFOAM/JobInfo.H>
#include <OpenFOAM/OSspecific.H>
#include <OpenFOAM/IOstreams.H>

#if defined(FOAM_HAVE_FEENABLEEXCEPT) && defined(FOAM_HAVE_FENV_H)
#   ifndef __USE_GNU
#       define __USE_GNU
#   endif
#   include <fenv.h>
#elif defined(FOAM_HAVE_HANDLE_SIGFPES) && defined(FOAM_HAVE_SIGFPE_H)
#   include <sigfpe.h>
#endif

#ifdef FOAM_USE_MALLOC_HOOK
#   include <malloc.h>
#endif


// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

struct sigaction Foam::sigFpeImpl::oldAction_;


#ifdef FOAM_USE_MALLOC_HOOK

void *(*Foam::sigFpeImpl::old_malloc_hook)(size_t, const void *) = NULL;

void* Foam::sigFpeImpl::my_malloc_hook(size_t size, const void *caller)
{
    void *result;

    // Restore all old hooks
    __malloc_hook = old_malloc_hook;

    // Call recursively
    result = malloc (size);

    // initialize to signalling nan
#   ifdef SP

    const uint32_t sNAN = 0x7ff7fffflu;

    int nScalars = size / sizeof(scalar);

    uint32_t* dPtr = reinterpret_cast<uint32_t*>(result);

    for (int i = 0; i < nScalars; i++)
    {
        *dPtr++ = sNAN;
    }

#   else

    const uint64_t sNAN = 0x7ff7ffffffffffffllu;

    int nScalars = size/sizeof(scalar);

    uint64_t* dPtr = reinterpret_cast<uint64_t*>(result);

    for (int i = 0; i < nScalars; i++)
    {
        *dPtr++ = sNAN;
    }

#   endif

    // Restore our own hooks
    __malloc_hook = my_malloc_hook;

    return result;
}

#endif


#ifdef FOAM_USE_FPE_HANDLING

void Foam::sigFpeImpl::sigFpeHandler(int)
{
    // Reset old handling
    if (sigaction(SIGFPE, &oldAction_, NULL) < 0)
    {
        FatalErrorIn
        (
            "Foam::sigFpeImpl::sigFpeHandler()"
        )   << "Cannot reset SIGFPE trapping"
            << abort(FatalError);
    }

    // Update jobInfo file
    jobInfo.signalEnd();

    error::printStack(Perr);

    // Throw signal (to old handler)
    raise(SIGFPE);
}

#endif


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sigFpeImpl::sigFpeImpl()
{
    oldAction_.sa_handler = NULL;
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::sigFpeImpl::~sigFpeImpl()
{
#ifdef FOAM_USE_FPE_HANDLING
    if (env("FOAM_SIGFPE"))
    {

        // Reset signal
        if (oldAction_.sa_handler && sigaction(SIGFPE, &oldAction_, NULL) < 0)
        {
            FatalErrorIn
            (
                "Foam::sigFpeImpl::~sigFpeImpl()"
            )   << "Cannot reset SIGFPE trapping"
                << abort(FatalError);
        }

    }
#endif

#ifdef FOAM_USE_MALLOC_HOOK
    if (env("FOAM_SETNAN"))
    {

        // Reset to standard malloc
        if (oldAction_.sa_handler)
        {
            __malloc_hook = old_malloc_hook;
        }

    }
#endif
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void Foam::sigFpeImpl::set(const bool verbose)
{
    if (oldAction_.sa_handler)
    {
        FatalErrorIn
        (
            "Foam::sigFpeImpl::set()"
        )   << "Cannot call sigFpeImpl::set() more than once"
            << abort(FatalError);
    }

#ifdef FOAM_USE_FPE_HANDLING
    if (env("FOAM_SIGFPE"))
    {
#   if defined(FOAM_HAVE_FEENABLEEXCEPT)
        if (verbose)
        {
            Info<< "SigFpe : Enabling floating point exception trapping"
                << " (FOAM_SIGFPE)." << endl;
        }

        feenableexcept
        (
            FE_DIVBYZERO
          | FE_INVALID
          | FE_OVERFLOW
        );

        struct sigaction newAction;
        newAction.sa_handler = sigFpeHandler;
        newAction.sa_flags = SA_NODEFER;
        sigemptyset(&newAction.sa_mask);
        if (sigaction(SIGFPE, &newAction, &oldAction_) < 0)
        {
            FatalErrorIn
            (
                "Foam::sigFpeImpl::set()"
            )   << "Cannot set SIGFPE trapping"
                << abort(FatalError);
        }


#   elif defined(FOAM_HAVE_HANDLE_SIGFPES)

        sigfpe_[_DIVZERO].abort=1;
        sigfpe_[_OVERFL].abort=1;
        sigfpe_[_INVALID].abort=1;

        sigfpe_[_DIVZERO].trace=1;
        sigfpe_[_OVERFL].trace=1;
        sigfpe_[_INVALID].trace=1;

        handle_sigfpes
        (
            _ON,
            _EN_DIVZERO
          | _EN_INVALID
          | _EN_OVERFL,
            0,
            _ABORT_ON_ERROR,
            NULL
        );

#   endif
    }
#endif // FOAM_USE_FPE_HANDLING


#ifdef FOAM_USE_MALLOC_HOOK
    if (env("FOAM_SETNAN"))
    {
        if (verbose)
        {
            Info<< "SetNaN : Initialising allocated memory to NaN"
                << " (FOAM_SETNAN)." << endl;
        }

        // Set our malloc
        __malloc_hook = Foam::sigFpeImpl::my_malloc_hook;

    }
#endif
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
