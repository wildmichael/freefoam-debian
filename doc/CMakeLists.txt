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

if(FOAM_ENABLE_XHTML_HELP OR FOAM_ENABLE_DOXYGEN_DOCS
    OR FOAM_ENABLE_XHTML_GUIDES)
  foam_configure_files(installImgFiles
    COPYONLY
    DESTDIR doc/html
    img/FreeFOAMLogo.png
    img/CrossPlatformToolkit.png)

  install(FILES
    ${installImgFiles}
    DESTINATION ${FOAM_INSTALL_DOC_PATH}/img COMPONENT doc)

  foam_configure_files(installCSSFiles
    COPYONLY
    DESTDIR doc/html
    css/layout.css
    css/custom.css)
  if(FOAM_ENABLE_XHTML_HELP OR FOAM_ENABLE_XHTML_GUIDES)
    # have asciidoc, use xhtml11.css and asciidoc-xhtml12.js from there
    if(EXISTS "${A2X_CONF_DIR}/stylesheets/asciidoc.css")
      # newer versions renamed xhtml11.css to asciidoc.css
      configure_file("${A2X_CONF_DIR}/stylesheets/asciidoc.css"
        "${CMAKE_CURRENT_BINARY_DIR}/html/css/xhtml11.css" COPYONLY)
    elseif(EXISTS "${A2X_CONF_DIR}/stylesheets/xhtml11.css")
      configure_file("${A2X_CONF_DIR}/stylesheets/xhtml11.css"
        "${CMAKE_CURRENT_BINARY_DIR}/html/css/xhtml11.css" COPYONLY)
    else()
      message(SEND_ERROR "Failed to find xhtml11.css or asciidoc.css")
    endif()
    configure_file("${A2X_CONF_DIR}/stylesheets/docbook-xsl.css"
      "${CMAKE_CURRENT_BINARY_DIR}/html/css/docbook-xsl.css" COPYONLY)
    set(installXHTMLCSSFiles
      "${CMAKE_CURRENT_BINARY_DIR}/html/css/xhtml11.css"
      "${CMAKE_CURRENT_BINARY_DIR}/html/css/docbook-xsl.css")
    if(EXISTS "${A2X_CONF_DIR}/javascripts/asciidoc.js")
      # newer versions renamed asciidoc-xhtml11.js to asciidoc.js
      configure_file("${A2X_CONF_DIR}/javascripts/asciidoc.js"
        "${CMAKE_CURRENT_BINARY_DIR}/html/js/asciidoc-xhtml11.js" COPYONLY)
    elseif(EXISTS "${A2X_CONF_DIR}/javascripts/asciidoc-xhtml11.js")
      configure_file("${A2X_CONF_DIR}/javascripts/asciidoc-xhtml11.js"
        "${CMAKE_CURRENT_BINARY_DIR}/html/js/asciidoc-xhtml11.js" COPYONLY)
    else()
      message(SEND_ERROR "Failed to find asciidoc-xhtml11.js or asciidoc.js")
    endif()
    set(installXHTMLJavaScriptFiles
      "${CMAKE_CURRENT_BINARY_DIR}/html/js/asciidoc-xhtml11.js")
    install(FILES ${installXHTMLJavaScriptFiles}
      DESTINATION  ${FOAM_INSTALL_DOC_PATH}/js COMPONENT doc)
  else()
    # otherwise use our own
    foam_configure_files(installXHTMLCSSFiles
      COPYONLY
      DESTDIR doc/html
      css/xhtml11.css)
  endif()

  install(FILES ${installCSSFiles} ${installXHTMLCSSFiles}
    DESTINATION ${FOAM_INSTALL_DOC_PATH}/css COMPONENT doc)
endif()

if(FOAM_ENABLE_XHTML_HELP OR FOAM_ENABLE_XHTML_GUIDES)
  set(opts
    -f "${CMAKE_BINARY_DIR}/data/asciidoc/html.conf"
    -a toc
    -a linkcss
    -a "data-uri!"
    -a stylesdir=css
    -a foam-stylesdir=css
    -a scriptsdir=js
    -a foam-scriptsdir=js
    -a imagesdir=img
    -a rel-doc=.
    -a docs-only)
  if(FOAM_DOCS_FOR_SF)
    list(APPEND opts -a foam-doc-for_sf)
  endif()
  if(FOAM_ENABLE_XHTML_GUIDES)
    list(APPEND opts -a foam-have-ug)
  endif()
  if(FOAM_ENABLE_XHTML_HELP)
    list(APPEND opts -a foam-have-man)
  endif()
  if(FOAM_ENABLE_DOXYGEN_DOCS)
    list(APPEND opts -a foam-have-doxy)
  endif()
  set(pkgdocs)
  foreach(f ChangeLog COPYING INSTALL README ReleaseNotes)
    set(o "${CMAKE_CURRENT_BINARY_DIR}/html/${f}.html")
    add_custom_command(OUTPUT "${o}"
      COMMAND ${PYTHON2_EXECUTABLE} ${ASCIIDOC_EXECUTABLE}
        ${opts} -o "${o}" "${CMAKE_SOURCE_DIR}/${f}"
      DEPENDS "${CMAKE_SOURCE_DIR}/${f}"
        "${CMAKE_BINARY_DIR}/data/asciidoc/html.conf"
      COMMENT "Generating ${f}.html"
      VERBATIM)
    list(APPEND pkgdocs "${o}")
  endforeach()
  add_custom_target(pkgdocs DEPENDS ${pkgdocs})
  add_dependencies(doc pkgdocs)
  install(FILES ${pkgdocs}
    DESTINATION ${FOAM_INSTALL_DOC_PATH} COMPONENT doc)
endif()

add_subdirectory(man/manSource)

if(FOAM_ENABLE_DOXYGEN_DOCS)
  add_subdirectory(Doxygen)
endif()

if(FOAM_ENABLE_XHTML_GUIDES AND FOAM_ENABLE_MATHJAX)
  configure_file(js/MathJaxMacros.js
    "${CMAKE_CURRENT_BINARY_DIR}/html/js/MathJaxMacros.js" COPYONLY)
  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/html/js/MathJaxMacros.js"
    DESTINATION "${FOAM_INSTALL_DOC_PATH}/js" COMPONENT doc)
endif()

if(FOAM_GUIDES_FORMATS)
  add_subdirectory(UserGuide)
endif()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
