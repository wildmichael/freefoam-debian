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
foam_configure_files(installAsciiDocFiles
  DESTDIR data/asciidoc
  COPYONLY
  chunked.conf
  html.conf
  manpage.conf
  pdf.conf
  common.conf
  docbook.conf)

foam_configure_files(installDocBookFiles
  DESTDIR data/asciidoc
  COPYONLY
  docbook-xsl/chunked.xsl
  docbook-xsl/common.xsl
  docbook-xsl/custom.xsl
  docbook-xsl/xhtml.xsl)

foam_configure_files(installDBLaTeXFiles
  DESTDIR data/asciidoc
  COPYONLY
  dblatex/asciidoc-dblatex.sty
  dblatex/foam-macros.sty
  dblatex/asciidoc-dblatex.xsl
  )

# install the data files
install(FILES
  ${installAsciiDocFiles}
  DESTINATION ${FOAM_INSTALL_DATA_PATH}/asciidoc
  COMPONENT dev)

install(FILES
  ${installDocBookFiles}
  DESTINATION ${FOAM_INSTALL_DATA_PATH}/asciidoc/docbook-xsl
  COMPONENT dev)

install(FILES
  ${installDBLaTeXFiles}
  DESTINATION ${FOAM_INSTALL_DATA_PATH}/asciidoc/dblatex
  COMPONENT dev)

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
