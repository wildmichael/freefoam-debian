const volScalarField::GeometricBoundaryField& pbf = p.boundaryField();
wordList rhoBoundaryTypes = pbf.types();

forAll(rhoBoundaryTypes, patchi)
{
    if (rhoBoundaryTypes[patchi] == "waveTransmissive")
    {
        rhoBoundaryTypes[patchi] = zeroGradientFvPatchScalarField::typeName;
    }
    else if (pbf[patchi].fixesValue())
    {
        rhoBoundaryTypes[patchi] = fixedRhoFvPatchScalarField::typeName;
    }
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
