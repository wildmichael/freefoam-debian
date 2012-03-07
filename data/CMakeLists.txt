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

# configure the utility data files for build tree and the install tree
foam_configure_files(installDataFiles
  DESTDIR data
  COPYONLY
  foamLog.db
  templates/foamAppTemplate.C
  templates/foamCommentStyles
  templates/foamScript
  templates/foamTemplate.C
  templates/foamTemplate.H
  templates/foamTemplateI.H
  templates/foamTemplateIO.C
  templates/foamTemplateTemplate.C
  templates/foamTemplateTemplate.H
  templates/foamTemplateTemplateI.H
  templates/foamTemplateTemplateIO.C
  )

# install the data files
foam_install_configured_files(FILES
  ${installDataFiles}
  DESTINATION ${FOAM_INSTALL_DATA_PATH}
  COMPONENT data
  )

add_subdirectory(asciidoc)
add_subdirectory(utilities)
add_subdirectory(python/FreeFOAM)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
