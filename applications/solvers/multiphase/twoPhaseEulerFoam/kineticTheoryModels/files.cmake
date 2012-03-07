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
  kineticTheoryModel/kineticTheoryModel.C
  viscosityModel/viscosityModel/viscosityModel.C
  viscosityModel/viscosityModel/newViscosityModel.C
  viscosityModel/Gidaspow/GidaspowViscosity.C
  viscosityModel/Syamlal/SyamlalViscosity.C
  viscosityModel/HrenyaSinclair/HrenyaSinclairViscosity.C
  viscosityModel/none/noneViscosity.C
  conductivityModel/conductivityModel/conductivityModel.C
  conductivityModel/conductivityModel/newConductivityModel.C
  conductivityModel/Gidaspow/GidaspowConductivity.C
  conductivityModel/Syamlal/SyamlalConductivity.C
  conductivityModel/HrenyaSinclair/HrenyaSinclairConductivity.C
  radialModel/radialModel/radialModel.C
  radialModel/radialModel/newRadialModel.C
  radialModel/CarnahanStarling/CarnahanStarlingRadial.C
  radialModel/Gidaspow/GidaspowRadial.C
  radialModel/LunSavage/LunSavageRadial.C
  radialModel/SinclairJackson/SinclairJacksonRadial.C
  granularPressureModel/granularPressureModel/granularPressureModel.C
  granularPressureModel/granularPressureModel/newGranularPressureModel.C
  granularPressureModel/Lun/LunPressure.C
  granularPressureModel/SyamlalRogersOBrien/SyamlalRogersOBrienPressure.C
  frictionalStressModel/frictionalStressModel/frictionalStressModel.C
  frictionalStressModel/frictionalStressModel/newFrictionalStressModel.C
  frictionalStressModel/JohnsonJackson/JohnsonJacksonFrictionalStress.C
  frictionalStressModel/Schaeffer/SchaefferFrictionalStress.C
  )

set(HDRS
  conductivityModel/Gidaspow/GidaspowConductivity.H
  conductivityModel/HrenyaSinclair/HrenyaSinclairConductivity.H
  conductivityModel/Syamlal/SyamlalConductivity.H
  conductivityModel/conductivityModel/conductivityModel.H
  frictionalStressModel/JohnsonJackson/JohnsonJacksonFrictionalStress.H
  frictionalStressModel/Schaeffer/SchaefferFrictionalStress.H
  frictionalStressModel/frictionalStressModel/frictionalStressModel.H
  granularPressureModel/Lun/LunPressure.H
  granularPressureModel/SyamlalRogersOBrien/SyamlalRogersOBrienPressure.H
  granularPressureModel/granularPressureModel/granularPressureModel.H
  kineticTheoryModel/kineticTheoryModel.H
  radialModel/CarnahanStarling/CarnahanStarlingRadial.H
  radialModel/Gidaspow/GidaspowRadial.H
  radialModel/LunSavage/LunSavageRadial.H
  radialModel/SinclairJackson/SinclairJacksonRadial.H
  radialModel/radialModel/radialModel.H
  viscosityModel/Gidaspow/GidaspowViscosity.H
  viscosityModel/HrenyaSinclair/HrenyaSinclairViscosity.H
  viscosityModel/Syamlal/SyamlalViscosity.H
  viscosityModel/none/noneViscosity.H
  viscosityModel/viscosityModel/viscosityModel.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
