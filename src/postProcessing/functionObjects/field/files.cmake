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
  fieldAverage/fieldAverage/fieldAverage.C
  fieldAverage/fieldAverageItem/fieldAverageItem.C
  fieldAverage/fieldAverageItem/fieldAverageItemIO.C
  fieldAverage/fieldAverageFunctionObject/fieldAverageFunctionObject.C
  fieldMinMax/fieldMinMax.C
  fieldMinMax/fieldMinMaxFunctionObject.C
  fieldValues/fieldValue/fieldValue.C
  fieldValues/faceSource/faceSource.C
  fieldValues/faceSource/faceSourceFunctionObject.C
  fieldValues/cellSource/cellSource.C
  fieldValues/cellSource/cellSourceFunctionObject.C
  readFields/readFields.C
  readFields/readFieldsFunctionObject.C
  surfaceInterpolateFields/surfaceInterpolateFieldsFunctionObject.C
  surfaceInterpolateFields/surfaceInterpolateFields.C
  )

set(HDRS
  fieldAverage/fieldAverage/IOFieldAverage.H
  fieldAverage/fieldAverage/fieldAverage.H
  fieldAverage/fieldAverage/fieldAverageTemplates.C
  fieldAverage/fieldAverageFunctionObject/fieldAverageFunctionObject.H
  fieldAverage/fieldAverageItem/fieldAverageItem.H
  fieldMinMax/IOfieldMinMax.H
  fieldMinMax/fieldMinMax.H
  fieldMinMax/fieldMinMaxFunctionObject.H
  fieldMinMax/fieldMinMaxTemplates.C
  fieldValues/fieldValue/fieldValue.H
  fieldValues/fieldValue/fieldValueI.H
  fieldValues/fieldValue/fieldValueTemplates.C
  fieldValues/faceSource/IOfaceSource.H
  fieldValues/faceSource/faceSource.H
  fieldValues/faceSource/faceSourceFunctionObject.H
  fieldValues/faceSource/faceSourceI.H
  fieldValues/faceSource/faceSourceTemplates.C
  fieldValues/cellSource/IOcellSource.H
  fieldValues/cellSource/cellSource.H
  fieldValues/cellSource/cellSourceFunctionObject.H
  fieldValues/cellSource/cellSourceI.H
  fieldValues/cellSource/cellSourceTemplates.C
  readFields/readFields.H
  readFields/readFieldsFunctionObject.H
  readFields/readFieldsTemplates.C
  surfaceInterpolateFields/IOsurfaceInterpolateFields.H
  surfaceInterpolateFields/surfaceInterpolateFields.H
  surfaceInterpolateFields/surfaceInterpolateFieldsFunctionObject.H
  surfaceInterpolateFields/surfaceInterpolateFieldsTemplates.C
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
