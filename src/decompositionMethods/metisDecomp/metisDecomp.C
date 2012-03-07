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

#include "metisDecomp.H"
#include <OpenFOAM/addToRunTimeSelectionTable.H>
#include <OpenFOAM/floatScalar.H>
#include <OpenFOAM/Time.H>
#include <scotchDecomp/scotchDecomp.H>

extern "C"
{
#define OMPI_SKIP_MPICXX
#   include <metis.h>
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#if defined(METIS_NEW_API) || (defined(METIS_API) && defined(METIS_NOPTIONS))

// Compatibility functions implementing the old API
#define DEFINE_METIS_COMPAT_FUNC(BASE_NAME)                                   \
    void FOAM_W ## BASE_NAME(int *nvtxs_p, int *xadj_p, int *adjncy_p,        \
                                  int *vwgt_p, int *adjwgt_p, int *wgtflag_p, \
                                  int *numflag_p, int *nparts_p,              \
                                  float *tpwgts_p, int *options_p,            \
                                  int *edgecut_p, int *part_p)                \
{                                                                             \
    using namespace Foam;                                                     \
    /* ignored: wgtflag_p */                                                  \
    /* convert arguments to correct type */                                   \
    idx_t nvtxs = *nvtxs_p;                                                   \
    idx_t ncon = 1;                                                           \
    idx_t madjncy = xadj_p[nvtxs];                                            \
    List<idx_t> xadj(nvtxs+1);                                                \
    std::copy(xadj_p, xadj_p+nvtxs+1, xadj.begin());                          \
    List<idx_t> adjncy(madjncy);                                              \
    std::copy(adjncy_p, adjncy_p+madjncy, adjncy.begin());                    \
    List<idx_t> vwgt;                                                         \
    if (vwgt_p)                                                               \
    {                                                                         \
        vwgt.setSize(nvtxs);                                                  \
        std::copy(vwgt_p, vwgt_p+nvtxs, vwgt.begin());                        \
    }                                                                         \
    List<idx_t> adjwgt;                                                       \
    if (adjwgt_p)                                                             \
    {                                                                         \
        adjwgt.setSize(madjncy);                                              \
        std::copy(adjwgt_p, adjwgt_p+madjncy, adjwgt.begin());                \
    }                                                                         \
    idx_t nparts = *nparts_p;                                                 \
    List<real_t> tpwgts;                                                      \
    if (tpwgts_p)                                                             \
    {                                                                         \
        tpwgts.setSize(nparts);                                               \
        std::copy(tpwgts_p, tpwgts_p+nparts, tpwgts.begin());                 \
    }                                                                         \
    List<idx_t> opts(METIS_NOPTIONS);                                         \
    METIS_SetDefaultOptions(opts.begin());                                    \
    if (options_p && options_p[0])                                            \
    {                                                                         \
        /* only options_p[1] has multiple, non-default options which has      \
         * equivalent in new API. Not sure about refinement in Kway-case... */\
        switch (options_p[1])                                                 \
        {                                                                     \
            case 1: opts[METIS_OPTION_CTYPE] = METIS_CTYPE_RM; break;         \
            case 2: /* fall-through */                                        \
            case 3: opts[METIS_OPTION_CTYPE] = METIS_CTYPE_SHEM; break;       \
        }                                                                     \
    }                                                                         \
    opts[METIS_OPTION_NUMBERING] = *numflag_p;                                \
    idx_t edgecut;                                                            \
    List<idx_t> part(nvtxs);                                                  \
                                                                              \
    /* call new API function */                                               \
    METIS_ ## BASE_NAME                                                       \
    (                                                                         \
        &nvtxs,                                                               \
        &ncon,                                                                \
        xadj.begin(),                                                         \
        adjncy.begin(),                                                       \
        vwgt_p ? vwgt.begin() : NULL,                                         \
        NULL,   /* vsize */                                                   \
        adjwgt_p ? adjwgt.begin() : NULL,                                     \
        &nparts,                                                              \
        tpwgts_p ? tpwgts.begin() : NULL,                                     \
        NULL,   /* ubvec */                                                   \
        opts.begin(),                                                         \
        &edgecut,                                                             \
        part.begin()                                                          \
    );                                                                        \
                                                                              \
    /* pass output values back */                                             \
    *edgecut_p = edgecut;                                                     \
    forAll(part, partI)                                                       \
    {                                                                         \
        part_p[partI] = part[partI];                                          \
    }                                                                         \
}                                                                             \
                                                                              \
                                                                              \
inline                                                                        \
void FOAM_ ## BASE_NAME(int *nvtxs_p, int *xadj_p, int *adjncy_p, int *vwgt_p,\
                        int *adjwgt_p, int *wgtflag_p, int *numflag_p,        \
                        int *nparts_p, int *options_p, int *edgecut_p,        \
                        int *part_p)                                          \
{                                                                             \
    FOAM_W ## BASE_NAME(nvtxs_p, xadj_p, adjncy_p, vwgt_p, adjwgt_p,          \
                        wgtflag_p, numflag_p, nparts_p, NULL /* tpwgts */,    \
                        options_p, edgecut_p, part_p);                        \
}

namespace {
    DEFINE_METIS_COMPAT_FUNC(PartGraphRecursive)
    DEFINE_METIS_COMPAT_FUNC(PartGraphKway)
}

#else

#define FOAM_PartGraphRecursive  METIS_PartGraphRecursive
#define FOAM_WPartGraphRecursive METIS_WPartGraphRecursive
#define FOAM_PartGraphKway       METIS_PartGraphKway
#define FOAM_WPartGraphKway      METIS_WPartGraphKway

#endif

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
    defineTypeNameAndDebug(metisDecomp, 0);

    addToRunTimeSelectionTable
    (
        decompositionMethod,
        metisDecomp,
        dictionaryMesh
    );
}


// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

// Call Metis with options from dictionary.
Foam::label Foam::metisDecomp::decompose
(
    const List<int>& adjncy,
    const List<int>& xadj,
    const scalarField& cWeights,

    List<int>& finalDecomp
)
{
    // C style numbering
    int numFlag = 0;

    // Method of decomposition
    // recursive: multi-level recursive bisection (default)
    // k-way: multi-level k-way
    word method("k-way");

    int numCells = xadj.size()-1;

    // decomposition options. 0 = use defaults
    List<int> options(5, 0);

    // processor weights initialised with no size, only used if specified in
    // a file
    Field<floatScalar> processorWeights;

    // cell weights (so on the vertices of the dual)
    List<int> cellWeights;

    // face weights (so on the edges of the dual)
    List<int> faceWeights;


    // Check for externally provided cellweights and if so initialise weights
    scalar minWeights = gMin(cWeights);
    if (cWeights.size() > 0)
    {
        if (minWeights <= 0)
        {
            WarningIn
            (
                "metisDecomp::decompose"
                "(const pointField&, const scalarField&)"
            )   << "Illegal minimum weight " << minWeights
                << endl;
        }

        if (cWeights.size() != numCells)
        {
            FatalErrorIn
            (
                "metisDecomp::decompose"
                "(const pointField&, const scalarField&)"
            )   << "Number of cell weights " << cWeights.size()
                << " does not equal number of cells " << numCells
                << exit(FatalError);
        }
        // Convert to integers.
        cellWeights.setSize(cWeights.size());
        forAll(cellWeights, i)
        {
            cellWeights[i] = int(cWeights[i]/minWeights);
        }
    }


    // Check for user supplied weights and decomp options
    if (decompositionDict_.found("metisCoeffs"))
    {
        const dictionary& metisCoeffs =
            decompositionDict_.subDict("metisCoeffs");
        word weightsFile;

        if (metisCoeffs.readIfPresent("method", method))
        {
            if (method != "recursive" && method != "k-way")
            {
                FatalErrorIn("metisDecomp::decompose()")
                    << "Method " << method << " in metisCoeffs in dictionary : "
                    << decompositionDict_.name()
                    << " should be 'recursive' or 'k-way'"
                    << exit(FatalError);
            }

            Info<< "metisDecomp : Using Metis method     " << method
                << nl << endl;
        }

        if (metisCoeffs.readIfPresent("options", options))
        {
            if (options.size() != 5)
            {
                FatalErrorIn("metisDecomp::decompose()")
                    << "Number of options in metisCoeffs in dictionary : "
                    << decompositionDict_.name()
                    << " should be 5"
                    << exit(FatalError);
            }

            Info<< "metisDecomp : Using Metis options     " << options
                << nl << endl;
        }

        if (metisCoeffs.readIfPresent("processorWeights", processorWeights))
        {
            processorWeights /= sum(processorWeights);

            if (processorWeights.size() != nProcessors_)
            {
                FatalErrorIn("metisDecomp::decompose(const pointField&)")
                    << "Number of processor weights "
                    << processorWeights.size()
                    << " does not equal number of domains " << nProcessors_
                    << exit(FatalError);
            }
        }

        if (metisCoeffs.readIfPresent("cellWeightsFile", weightsFile))
        {
            Info<< "metisDecomp : Using cell-based weights." << endl;

            IOList<int> cellIOWeights
            (
                IOobject
                (
                    weightsFile,
                    mesh_.time().timeName(),
                    mesh_,
                    IOobject::MUST_READ,
                    IOobject::AUTO_WRITE
                )
            );
            cellWeights.transfer(cellIOWeights);

            if (cellWeights.size() != xadj.size()-1)
            {
                FatalErrorIn("metisDecomp::decompose(const pointField&)")
                    << "Number of cell weights " << cellWeights.size()
                    << " does not equal number of cells " << xadj.size()-1
                    << exit(FatalError);
            }
        }
    }

    int nProcs = nProcessors_;

    // output: cell -> processor addressing
    finalDecomp.setSize(numCells);

    // output: number of cut edges
    int edgeCut = 0;

    // Vertex weight info
    int wgtFlag = 0;
    int* vwgtPtr = NULL;
    int* adjwgtPtr = NULL;

    if (cellWeights.size())
    {
        vwgtPtr = cellWeights.begin();
        wgtFlag += 2;       // Weights on vertices
    }
    if (faceWeights.size())
    {
        adjwgtPtr = faceWeights.begin();
        wgtFlag += 1;       // Weights on edges
    }

    if (method == "recursive")
    {
        if (processorWeights.size())
        {
            FOAM_WPartGraphRecursive
            (
                &numCells,         // num vertices in graph
                const_cast<List<int>&>(xadj).begin(),   // indexing into adjncy
                const_cast<List<int>&>(adjncy).begin(), // neighbour info
                vwgtPtr,           // vertexweights
                adjwgtPtr,         // no edgeweights
                &wgtFlag,
                &numFlag,
                &nProcs,
                processorWeights.begin(),
                options.begin(),
                &edgeCut,
                finalDecomp.begin()
            );
        }
        else
        {
            FOAM_PartGraphRecursive
            (
                &numCells,         // num vertices in graph
                const_cast<List<int>&>(xadj).begin(),   // indexing into adjncy
                const_cast<List<int>&>(adjncy).begin(), // neighbour info
                vwgtPtr,           // vertexweights
                adjwgtPtr,         // no edgeweights
                &wgtFlag,
                &numFlag,
                &nProcs,
                options.begin(),
                &edgeCut,
                finalDecomp.begin()
            );
        }
    }
    else
    {
        if (processorWeights.size())
        {
            FOAM_WPartGraphKway
            (
                &numCells,         // num vertices in graph
                const_cast<List<int>&>(xadj).begin(),   // indexing into adjncy
                const_cast<List<int>&>(adjncy).begin(), // neighbour info
                vwgtPtr,           // vertexweights
                adjwgtPtr,         // no edgeweights
                &wgtFlag,
                &numFlag,
                &nProcs,
                processorWeights.begin(),
                options.begin(),
                &edgeCut,
                finalDecomp.begin()
            );
        }
        else
        {
            FOAM_PartGraphKway
            (
                &numCells,         // num vertices in graph
                const_cast<List<int>&>(xadj).begin(),   // indexing into adjncy
                const_cast<List<int>&>(adjncy).begin(), // neighbour info
                vwgtPtr,           // vertexweights
                adjwgtPtr,         // no edgeweights
                &wgtFlag,
                &numFlag,
                &nProcs,
                options.begin(),
                &edgeCut,
                finalDecomp.begin()
            );
        }
    }

    return edgeCut;
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::metisDecomp::metisDecomp
(
    const dictionary& decompositionDict,
    const polyMesh& mesh
)
:
    decompositionMethod(decompositionDict),
    mesh_(mesh)
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

Foam::labelList Foam::metisDecomp::decompose
(
    const pointField& points,
    const scalarField& pointWeights
)
{
    if (points.size() != mesh_.nCells())
    {
        FatalErrorIn
        (
            "metisDecomp::decompose(const pointField&,const scalarField&)"
        )   << "Can use this decomposition method only for the whole mesh"
            << endl
            << "and supply one coordinate (cellCentre) for every cell." << endl
            << "The number of coordinates " << points.size() << endl
            << "The number of cells in the mesh " << mesh_.nCells()
            << exit(FatalError);
    }

    List<int> adjncy;
    List<int> xadj;
    scotchDecomp::calcCSR
    (
        mesh_,
        adjncy,
        xadj
    );

    // Decompose using default weights
    List<int> finalDecomp;
    decompose(adjncy, xadj, pointWeights, finalDecomp);

    // Copy back to labelList
    labelList decomp(finalDecomp.size());
    forAll(decomp, i)
    {
        decomp[i] = finalDecomp[i];
    }
    return decomp;
}


Foam::labelList Foam::metisDecomp::decompose
(
    const labelList& agglom,
    const pointField& agglomPoints,
    const scalarField& agglomWeights
)
{
    if (agglom.size() != mesh_.nCells())
    {
        FatalErrorIn
        (
            "metisDecomp::decompose"
            "(const labelList&, const pointField&, const scalarField&)"
        )   << "Size of cell-to-coarse map " << agglom.size()
            << " differs from number of cells in mesh " << mesh_.nCells()
            << exit(FatalError);
    }

    // Make Metis CSR (Compressed Storage Format) storage
    //   adjncy      : contains neighbours (= edges in graph)
    //   xadj(celli) : start of information in adjncy for celli
    List<int> adjncy;
    List<int> xadj;
    {
        // Get cellCells on coarse mesh.
        labelListList cellCells;
        calcCellCells
        (
            mesh_,
            agglom,
            agglomPoints.size(),
            cellCells
        );

        scotchDecomp::calcCSR(cellCells, adjncy, xadj);
    }

    // Decompose using default weights
    List<int> finalDecomp;
    decompose(adjncy, xadj, agglomWeights, finalDecomp);


    // Rework back into decomposition for original mesh_
    labelList fineDistribution(agglom.size());

    forAll(fineDistribution, i)
    {
        fineDistribution[i] = finalDecomp[agglom[i]];
    }

    return fineDistribution;
}


Foam::labelList Foam::metisDecomp::decompose
(
    const labelListList& globalCellCells,
    const pointField& cellCentres,
    const scalarField& cellWeights
)
{
    if (cellCentres.size() != globalCellCells.size())
    {
        FatalErrorIn
        (
            "metisDecomp::decompose"
            "(const pointField&, const labelListList&, const scalarField&)"
        )   << "Inconsistent number of cells (" << globalCellCells.size()
            << ") and number of cell centres (" << cellCentres.size()
            << ")." << exit(FatalError);
    }


    // Make Metis CSR (Compressed Storage Format) storage
    //   adjncy      : contains neighbours (= edges in graph)
    //   xadj(celli) : start of information in adjncy for celli

    List<int> adjncy;
    List<int> xadj;
    scotchDecomp::calcCSR(globalCellCells, adjncy, xadj);


    // Decompose using default weights
    List<int> finalDecomp;
    decompose(adjncy, xadj, cellWeights, finalDecomp);

    // Copy back to labelList
    labelList decomp(finalDecomp.size());
    forAll(decomp, i)
    {
        decomp[i] = finalDecomp[i];
    }
    return decomp;
}


// ************************ vim: set sw=4 sts=4 et: ************************ //
