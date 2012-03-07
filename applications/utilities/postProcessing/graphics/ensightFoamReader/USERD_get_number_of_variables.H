//======================================================================
int USERD_get_number_of_variables(void)
{
#ifdef ENSIGHTDEBUG
    Info << "Entering: USERD_get_number_of_variables" << endl << flush;
#endif

    return Num_variables;
}

// ************************ vim: set sw=4 sts=4 et: ************************ //
