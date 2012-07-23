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

include(files.cmake)

# copy files
foam_configure_files(installFiles DESTDIR doc/UserGuide COPYONLY ${IMAGES})
set(COPY_OUTPUT)
foreach(fd IN LISTS COPY_SRCS)
  # parse <source>=>[range]<test> entries
  if(fd MATCHES "([^=]*)=(\\[(-?[0-9]*:-?[0-9]*)\\])?>(.*)")
    set(f "${CMAKE_MATCH_1}")
    get_filename_component(df "${f}" NAME)
    set(d "${CMAKE_MATCH_4}/${df}")
    if(NOT IS_ABSOLUTE "${d}")
      set(d "${CMAKE_CURRENT_BINARY_DIR}/${d}")
    endif()
    if(CMAKE_MATCH_3)
      get_filename_component(dd "${d}" PATH)
      if(NOT IS_DIRECTORY "${dd}")
        file(MAKE_DIRECTORY "${dd}")
      endif()
      # have a line-range specified
      file(RELATIVE_PATH rf "${CMAKE_SOURCE_DIR}" "${f}")
      add_custom_command(OUTPUT "${d}"
        COMMAND "${PYTHON_EXECUTABLE}" -c
        "open('${d}', 'wt').writelines(open('${f}', 'rt').readlines()[${CMAKE_MATCH_3}])"
        DEPENDS "${f}"
        COMMENT "Extracting range ${CMAKE_MATCH_3} from ${rf}"
        VERBATIM)
    else()
      configure_file("${f}" "${d}" COPYONLY)
    endif()
    list(APPEND COPY_OUTPUT "${d}")
  else()
    message(SEND_ERROR
      "Elements in LISTING_SRCS must be in form SRCFILE=([range])?>DESTDIR")
  endif()
endforeach()

# set up and run asymptote
set_property(SOURCE
  images/mesh_snappyHexMeshBlockMesh.asy
  images/mesh_snappyHexMeshCellRemoval.asy
  images/mesh_snappyHexMeshCellSplittingFeatures.asy
  images/mesh_snappyHexMeshCellSplittingRegion.asy
  images/mesh_snappyHexMeshCellSplittingSurface.asy
  images/mesh_snappyHexMeshDescription.asy
  images/mesh_snappyHexMeshLayers.asy
  images/mesh_snappyHexMeshSnapping.asy
  PROPERTY OBJECT_DEPENDS images/mesh_snappyHexMeshCommon.asy)
set_property(SOURCE images/post_displayPanel.asy PROPERTY
  OBJECT_DEPENDS images/post_displayPanel-snapshot.png)
set_property(SOURCE images/post_parametersPanel.asy PROPERTY
  OBJECT_DEPENDS images/post_parametersPanel-snapshot.png)
set_property(SOURCE images/post_paraviewToolbars.asy PROPERTY
  OBJECT_DEPENDS images/post_paraviewToolbars-snapshot.png)
set_property(SOURCE images/post_UxResidual.asy PROPERTY
  OBJECT_DEPENDS images/post_Ux_0)
set_property(SOURCE images/tut_damBreakFine_snapshot_1.asy PROPERTY
  OBJECT_DEPENDS
  images/tut_damBreak_commonDamBreak.asy
  images/tut_damBreakFine_snapshot_field_1.png images/tut_damBreakFine_bar.png)
set_property(SOURCE images/tut_damBreakFine_snapshot_2.asy PROPERTY
  OBJECT_DEPENDS
  images/tut_damBreak_commonDamBreak.asy
  images/tut_damBreakFine_snapshot_field_2.png
  images/tut_damBreakFine_bar.png)
set_property(SOURCE images/tut_damBreak_initial.asy PROPERTY
  OBJECT_DEPENDS
  images/tut_damBreak_commonDamBreak.asy
  images/tut_damBreak_initial_field.png
  images/tut_damBreak_bar.png)
set_property(SOURCE images/tut_damBreak_snapshot_1.asy PROPERTY
  OBJECT_DEPENDS
  images/tut_damBreak_commonDamBreak.asy
  images/tut_damBreak_snapshot_field_1.png
  images/tut_damBreak_bar.png)
set_property(SOURCE images/tut_damBreak_snapshot_2.asy PROPERTY
  OBJECT_DEPENDS
  images/tut_damBreak_commonDamBreak.asy
  images/tut_damBreak_snapshot_field_2.png
  images/tut_damBreak_bar.png)
set_property(SOURCE images/tut_ico_cavity_paraFoamCavityGlyphParameters.asy
  PROPERTY OBJECT_DEPENDS
  images/tut_ico_cavity_paraFoamCavityGlyphParameters_snapshot.png)
set_property(SOURCE images/tut_ico_cavity_paraFoamCavityGraphParameters.asy
  PROPERTY OBJECT_DEPENDS
  images/tut_ico_cavity_paraFoamCavityGraphParameters_snapshot.png)
set_property(SOURCE images/tut_ico_cavity_paraFoamCavityMesh.asy PROPERTY
  OBJECT_DEPENDS images/tut_ico_cavity_paraFoamCavityMesh_snapshot.png)
set_property(SOURCE images/tut_ico_cavity_paraFoamCavityPContourDisplay.asy
  PROPERTY OBJECT_DEPENDS
  images/tut_ico_cavity_paraFoamCavityPContourDisplay_snapshot.png)
set_property(SOURCE
  images/tut_ico_cavity_paraFoamCavityStreamTracerParameters.asy PROPERTY
  OBJECT_DEPENDS
  images/tut_ico_cavity_paraFoamCavityStreamTracerParameters_snapshot.png)
set_property(SOURCE images/tut_plateHole_sigmaxx.asy PROPERTY
  OBJECT_DEPENDS images/tut_plateHole_field.png images/tut_plateHole_bar.png)
set_property(SOURCE images/tut_plateHole_sigmaxx_profile.asy PROPERTY
  OBJECT_DEPENDS images/tut_plateHole_leftPatch_sigmaxx.xy)

# IMPORTANT: Each output file must only be depended on by one command,
# otherwise parallel builds break. If this ever changes, collect the output in
# a custom target, and use add_dependencies() instead of a direct DEPENDS in
# the depending custom command.
foreach(f IN LISTS FOAM_GUIDES_FORMATS)
  if(f STREQUAL xhtml)
    foam_compile_asy(ASY_${f}_OUTPUT png ${ASY_SRCS})
  elseif(f STREQUAL pdf)
    foam_compile_asy(ASY_${f}_OUTPUT pdf ${ASY_SRCS})
  else()
    message(SEND_ERROR "Unknown output format ${f}")
  endif()
endforeach()

# pdf options
set(DBLATEX_XSL
  "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/asciidoc-dblatex.xsl")
set(DBLATEX_STY
  "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/asciidoc-dblatex.sty")

set(A2X_pdf_dblatex_OPTS
  "--dblatex-opts=--xsl-user=${DBLATEX_XSL}"
  "--texstyle=${DBLATEX_STY}"
  "--fig-path=${CMAKE_CURRENT_BINARY_DIR}")
string(REPLACE ";" " " A2X_pdf_dblatex_OPTS "${A2X_pdf_dblatex_OPTS}")

set(A2X_pdf_fop_OPTS --fop -a foam-use-fop -a foam-use-pngmath)

set(A2X_pdf_OPTS -f pdf -a foam-pdf -a builddir=${CMAKE_CURRENT_BINARY_DIR}/)

if(FOAM_USE_FOP)
  list(APPEND A2X_pdf_OPTS ${A2X_pdf_fop_OPTS})
else()
  list(APPEND A2X_pdf_OPTS -a foam-use-dblatex ${A2X_pdf_dblatex_OPTS})
endif()

set(A2X_pdf_DESTDIR "${CMAKE_BINARY_DIR}/doc")
set(A2X_pdf_OUTPUT "${A2X_pdf_DESTDIR}/UserGuide.pdf")

if(NOT FOAM_USE_FOP)
  set(A2X_pdf_EXTRA_DEPS
    "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/asciidoc-dblatex.xsl"
    "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/orig-asciidoc-dblatex.xsl"
    "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/asciidoc-dblatex.sty"
    "${CMAKE_BINARY_DIR}/data/asciidoc/dblatex/orig-asciidoc-dblatex.sty")
endif()

set(ADOC_pdf_MAIN_CONF "${CMAKE_BINARY_DIR}/data/asciidoc/pdf.conf")
set(ADOC_pdf_ALL_CONF "${ADOC_pdf_MAIN_CONF}"
  "${CMAKE_BINARY_DIR}/data/asciidoc/common.conf"
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook.conf")

# xhtml options

set(ADOC_xhtml_OPTS
  -b docbook -a foam-xhtml11 -a a2x-format=chunked
  -a builddir=${CMAKE_CURRENT_BINARY_DIR}/)
if(NOT FOAM_ENABLE_MATHJAX)
  list(APPEND ADOC_xhtml_OPTS -a foam-use-pngmath)
endif()

set(ADOC_xhtml_MAIN_CONF "${CMAKE_BINARY_DIR}/data/asciidoc/chunked.conf")
set(ADOC_xhtml_ALL_CONF "${ADOC_xhtml_MAIN_CONF}"
  "${CMAKE_BINARY_DIR}/data/asciidoc/common.conf"
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook.conf")

set(XSLTPROC_xhtml_OPTS
  --stringparam callout.graphics 1
  --stringparam navig.graphics 1
  --stringparam admon.textlabel 0
  --stringparam admon.graphics 1
  --stringparam toc.section.depth 1
  --stringparam base.dir ${PROJECT_BINARY_DIR}/doc/html/UserGuide/
  --stringparam chunk.section.depth 1
  --stringparam foam.version.full ${FOAM_VERSION_FULL}
  --param foam.ug.current 1
  --param foam.doc.have_ug 1
  --stringparam html.stylesheet ../css/docbook-xsl.css)
if(FOAM_ENABLE_MATHJAX)
  list(APPEND XSLTPROC_xhtml_OPTS
    --param foam.use.mathjax 1
    --stringparam foam.mathjax.url ${FOAM_MATHJAX_URL})
endif()
if(FOAM_DOCS_FOR_SF)
  list(APPEND XSLTPROC_xhtml_OPTS --param foam.doc.for_sf 1)
endif()
if(FOAM_ENABLE_DOXYGEN_DOCS)
  list(APPEND XSLTPROC_xhtml_OPTS --param foam.doc.have_doxy 1)
endif()
if(FOAM_ENABLE_XHTML_HELP)
  list(APPEND XSLTPROC_xhtml_OPTS --param foam.doc.have_man 1)
endif()
list(APPEND XSLTPROC_xhtml_OPTS
  ${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/chunked.xsl)

set(XSLTPROC_xhtml_DESTDIR "${CMAKE_BINARY_DIR}/doc/html/UserGuide")
set(XSLTPROC_xhtml_OUTPUT
  "${XSLTPROC_xhtml_DESTDIR}/index.html")

set(XSLTPROC_xhtml_EXTRA_DEPS
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/chunked.xsl"
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/custom.xsl"
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-chunked.xsl"
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/common.xsl"
  "${CMAKE_BINARY_DIR}/data/asciidoc/docbook-xsl/orig-common.xsl")

# convert maths to graphics

set(PNGMATH_FILTER
  "${CMAKE_BINARY_DIR}/data/utilities/foamPNGMathFilter${FOAM_PY_SCRIPT_SUFFIX}")
set(CONF_ASCIIDOC_SRCS)
foreach(f IN LISTS ASCIIDOC_SRCS)
  if(FOAM_NEED_PNGMATH)
    set(ff "${CMAKE_CURRENT_BINARY_DIR}/${f}")
    list(APPEND CONF_ASCIIDOC_SRCS "${ff}")
    add_custom_command(OUTPUT "${ff}"
      COMMAND "${PYTHON_EXECUTABLE}" "${PNGMATH_FILTER}"
        -m "${CMAKE_CURRENT_BINARY_DIR}/math"
        -D 120 -o "${ff}" "${CMAKE_CURRENT_SOURCE_DIR}/${f}"
      DEPENDS "${f}" "${CMAKE_SOURCE_DIR}/data/utilities/foamPNGMathFilter.py.in"
      COMMENT "Filtering math in ${ff}"
      VERBATIM)
  else()
    list(APPEND CONF_ASCIIDOC_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/${f}")
  endif()
endforeach()
list(GET CONF_ASCIIDOC_SRCS 0 ASCIIDOC_MAIN_SRC)

# convenience targets

add_custom_target(UserGuides ALL)
add_dependencies(doc UserGuides)

# run toolchains

if(FOAM_ENABLE_PDF_GUIDES)
  add_custom_command(OUTPUT "${A2X_pdf_OUTPUT}"
    COMMAND ${CMAKE_COMMAND}
      -E copy_directory ${A2X_CONF_DIR}/images/icons
      ${CMAKE_CURRENT_BINARY_DIR}/images/icons
    COMMAND ${PYTHON2_EXECUTABLE} ${A2X_EXECUTABLE} ${A2X_pdf_OPTS} -d book
      # IMPORTANT: format specific destination directories, otherwise parallel
      # builds break
      -D "${A2X_pdf_DESTDIR}" --icons
      "--asciidoc-opts=-f ${ADOC_pdf_MAIN_CONF}"
      -r "${CMAKE_CURRENT_BINARY_DIR}"
      "${ASCIIDOC_MAIN_SRC}"
    DEPENDS ${CONF_ASCIIDOC_SRCS} ${IMAGES} ${ASY_pdf_OUTPUT} ${COPY_OUTPUT}
      ${ADOC_pdf_ALL_CONF}
      ${A2X_pdf_EXTRA_DEPS}
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    COMMENT "Generating pdf version of the UserGuide"
    VERBATIM)
  add_custom_target(UserGuide-pdf
    DEPENDS "${A2X_pdf_OUTPUT}")
  add_dependencies(UserGuides UserGuide-pdf)
  # depend on version_check if enabled
  if(FOAM_HAVE_GIT)
    add_dependencies(UserGuide-pdf version_check)
  endif()
  install(FILES ${A2X_pdf_OUTPUT}
    DESTINATION ${FOAM_INSTALL_DOC_PATH} COMPONENT doc
    )
endif()

if(FOAM_ENABLE_XHTML_GUIDES)
  add_custom_command(OUTPUT ${XSLTPROC_xhtml_OUTPUT}
    COMMAND ${PYTHON2_EXECUTABLE} ${ASCIIDOC_EXECUTABLE}
      -f ${ADOC_xhtml_MAIN_CONF} -d book
      ${ADOC_xhtml_OPTS}
      -o ${PROJECT_BINARY_DIR}/doc/html/UserGuide.xml
      ${ASCIIDOC_MAIN_SRC}
    COMMAND ${XSLTPROC_EXECUTABLE} ${XSLTPROC_xhtml_OPTS}
      ${PROJECT_BINARY_DIR}/doc/html/UserGuide.xml
    COMMAND ${CMAKE_COMMAND}
      -E copy_directory images ${XSLTPROC_xhtml_DESTDIR}/images
    COMMAND ${CMAKE_COMMAND}
      -E copy_directory ${A2X_CONF_DIR}/images/icons
      ${XSLTPROC_xhtml_DESTDIR}/images/icons
    DEPENDS ${CONF_ASCIIDOC_SRCS} ${IMAGES} ${ASY_xhtml_OUTPUT} ${COPY_OUTPUT}
      ${ADOC_xhtml_ALL_CONF}
      ${XSLTPROC_xhtml_EXTRA_DEPS}
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    COMMENT "Generating xhtml version of the UserGuide"
    VERBATIM)
  add_custom_target(UserGuide-xhtml
    DEPENDS "${XSLTPROC_xhtml_OUTPUT}")
  if(FOAM_ENABLE_MATHJAX)
    add_dependencies(UserGuide-xhtml MathJax)
  endif()
  add_dependencies(UserGuides UserGuide-xhtml)
  # depend on version_check if enabled
  if(FOAM_HAVE_GIT)
    add_dependencies(UserGuide-xhtml version_check)
  endif()
  install(DIRECTORY ${XSLTPROC_xhtml_DESTDIR}
    DESTINATION ${FOAM_INSTALL_DOC_PATH} COMPONENT doc
    )
endif()

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
