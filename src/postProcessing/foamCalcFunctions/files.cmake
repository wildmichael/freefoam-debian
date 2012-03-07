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
  calcType/calcType.C
  calcType/newCalcType.C
  field/components/components.C
  field/mag/mag.C
  field/magSqr/magSqr.C
  field/magGrad/magGrad.C
  field/div/div.C
  field/randomise/randomise.C
  field/interpolate/interpolate.C
  basic/addSubtract/addSubtract.C
  )

set(HDRS
  basic/addSubtract/addSubtract.H
  basic/addSubtract/writeAddSubtractField.C
  basic/addSubtract/writeAddSubtractValue.C
  calcType/calcType.H
  field/components/components.H
  field/components/writeComponentFields.C
  field/div/div.H
  field/div/writeDivField.C
  field/interpolate/interpolate.H
  field/interpolate/writeInterpolateField.C
  field/mag/mag.H
  field/mag/writeMagField.C
  field/magGrad/magGrad.H
  field/magGrad/writeMagGradField.C
  field/magSqr/magSqr.H
  field/magSqr/writeMagSqrField.C
  field/randomise/randomise.H
  field/randomise/writeRandomField.C
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
