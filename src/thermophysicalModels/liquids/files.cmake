#-------------------------------------------------------------------------------
#               ______                _     ____          __  __
#              |  ____|             _| |_  / __ \   /\   |  \/  |
#              | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
#              |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
#              | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
#              |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|
#
#                   FreeFOAM: The Cross-Platform CFD Toolkit
#
# Copyright (C) 2008-2012 Michael Wild <themiwi@users.sf.net>
#                         Gerber van der Graaf <gerber_graaf@users.sf.net>
#-------------------------------------------------------------------------------
# License
#   This file is part of FreeFOAM.
#
#   FreeFOAM is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#   for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------

set(SRCS
  liquid/liquid.C
  H2O/H2O.C
  C7H16/C7H16.C
  C12H26/C12H26.C
  C10H22/C10H22.C
  C8H18/C8H18.C
  IC8H18/IC8H18.C
  C4H10O/C4H10O.C
  C2H6O/C2H6O.C
  IDEA/IDEA.C
  aC10H7CH3/aC10H7CH3.C
  bC10H7CH3/bC10H7CH3.C
  C8H10/C8H10.C
  C16H34/C16H34.C
  C9H20/C9H20.C
  C6H6/C6H6.C
  C7H8/C7H8.C
  C6H14/C6H14.C
  C13H28/C13H28.C
  C14H30/C14H30.C
  C3H8/C3H8.C
  C3H6O/C3H6O.C
  C2H6/C2H6.C
  CH3OH/CH3OH.C
  C2H5OH/C2H5OH.C
  Ar/Ar.C
  N2/N2.C
  MB/MB.C
  CH4N2O/CH4N2O.C
  nC3H8O/nC3H8O.C
  iC3H8O/iC3H8O.C
  )

set(HDRS
  Ar/Ar.H
  Ar/ArI.H
  C10H22/C10H22.H
  C10H22/C10H22I.H
  C12H26/C12H26.H
  C12H26/C12H26I.H
  C13H28/C13H28.H
  C13H28/C13H28I.H
  C14H30/C14H30.H
  C14H30/C14H30I.H
  C16H34/C16H34.H
  C16H34/C16H34I.H
  C2H5OH/C2H5OH.H
  C2H5OH/C2H5OHI.H
  C2H6/C2H6.H
  C2H6/C2H6I.H
  C2H6O/C2H6O.H
  C2H6O/C2H6OI.H
  C3H6O/C3H6O.H
  C3H6O/C3H6OI.H
  C3H8/C3H8.H
  C3H8/C3H8I.H
  C4H10O/C4H10O.H
  C4H10O/C4H10OI.H
  C6H14/C6H14.H
  C6H14/C6H14I.H
  C6H6/C6H6.H
  C6H6/C6H6I.H
  C7H16/C7H16.H
  C7H16/C7H16I.H
  C7H8/C7H8.H
  C7H8/C7H8I.H
  C8H10/C8H10.H
  C8H10/C8H10I.H
  C8H18/C8H18.H
  C8H18/C8H18I.H
  C9H20/C9H20.H
  C9H20/C9H20I.H
  CH3OH/CH3OH.H
  CH3OH/CH3OHI.H
  CH4N2O/CH4N2O.H
  CH4N2O/CH4N2OI.H
  H2O/H2O.H
  H2O/H2OI.H
  IC8H18/IC8H18.H
  IC8H18/IC8H18I.H
  IDEA/IDEA.H
  IDEA/IDEAI.H
  MB/MB.H
  MB/MBI.H
  N2/N2.H
  N2/N2I.H
  aC10H7CH3/aC10H7CH3.H
  aC10H7CH3/aC10H7CH3I.H
  bC10H7CH3/bC10H7CH3.H
  bC10H7CH3/bC10H7CH3I.H
  iC3H8O/iC3H8O.H
  iC3H8O/iC3H8OI.H
  liquid/liquid.H
  liquid/liquidI.H
  nC3H8O/nC3H8O.H
  nC3H8O/nC3H8OI.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
