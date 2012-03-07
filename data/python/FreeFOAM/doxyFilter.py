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
#
# Script
#     doxyFilter
#
# Description
#     pass-through filter for doxygen
#
#     Special treatment for applications/{solvers,utilities}/*.C
#     - only keep the first comment block of the C source file
#       use @cond / @endcond to suppress documenting all classes/variables
#
#     Otherwise converts cocoon style sentinel strings into doxygen style
#     strings. Assumes comment strings are formatted as follows
#         //- general description
#         //  more information
#         //  and even more information
#     This should be re-formatted as the following
#         //! general description
#         /*!
#         more information
#         and even more information
#         */
#     The intermediate "/*! ... */" block is left-justified to handle
#     possible verbatim text
#
#-------------------------------------------------------------------------------

"""Pass through filter module for Doxygen"""

from FreeFOAM.compat import *

class DoxyFiltError(Exception):
   """Thrown if an error occurs"""
   def __init__(self, msg):
      Exception.__init__(self, msg)
   def str():
      return self.args[0]

def filter(fileName, libName=None, baseDir=None, topOnly=False,
      incWrapperDir=None):
   """Run the filter on `fileName`.

   Parameters
   ----------
   fileName            The file to filter.
   libName             If the file is part of a library, its name.
   baseDir             Directory to which all paths are made relative. Defaults
                       to os.getcwd()
   topOnly             Only output first comment block, suppress documentation
                       of all other code.
   incWrapperDir       Directory containing include-wrappers.

   """

   import sys
   import os
   import os.path
   import re

   if not baseDir:
      baseDir = os.getcwd()

   # sanity checks
   if not os.path.isfile(fileName):
      echo('ERROR: "%s" does not exist or is not a file'%fileName, file=sys.stderr)
      sys.exit(1)

   relFileName = os.path.relpath(fileName, baseDir)

   lines = open(fileName, 'rt').readlines()
   output = []
   # first transform comment blocks and insert conditionals for applications
   state = 0
   for i, l in enumerate(lines):
      if topOnly:
         if i == 0:
            # /* starts a comment
            if re.match(r'\s*/\*', l):
               state = 1
            else:
               output.append('//! @cond FOAM_IGNORE\n')
               state = 2
            output.append(l)
            continue
         # */ ends a comment block
         if re.search(r'\*/', l):
            output.extend((l, '//! @cond FOAM_IGNORE\n'))
            state = 2
            continue
         # print everyting in the first comment block
         if state:
            output.append(l)
      else:
         # //- starts a comment block
         if re.match(r'\s*//-', l):
            output.append(re.sub(r'//-', '//!', l))
            state = 1
            continue
         elif re.match(r'\s*//', l):
            if state == 1:
               output.append('/*! ')
               state = 2
            if state == 2:
               output.append(re.sub(r'^\s*//(?:  )?', '', l))
            else:
               output.append(l)
            continue
         elif state == 2:
            output.append('*/ ')
         output.append(l)
         state = 0

   if topOnly and state==2:
      output.append('//! @endcond\n')

   # now process special sections and markers in header comment block
   iter = enumerate(output)
   foundFileCommand=False
   for i, l in iter:
      # remove License block
      if re.match('License', l):
         doDelete = True
         j = i-1
         nDelete = 0
         for ll in output[i:]:
            j += 1
            if doDelete:
               del output[i]
               j -= 1
               nDelete += 1
            if re.search(r'MA 0211.-130. USA|<http://www.gnu.org/licenses/>', ll):
               doDelete = False
               foundFileCommand = True
               output.insert(i, ('*/\n/*! @file %s\n'%relFileName)
                     + (nDelete-2)*'\n')
               j += 1
            if re.search(r'\*/', ll):
               output[j] = '*/\n'
               break
         continue
      # remove Application and Global blocks
      if re.match(r'(?:Application|Global)\b\s*$', l):
         del output[i:i+2]
         continue
      # transform Class, Namespace, Typedef and Primitive blocks
      m = re.match(r'(?P<type>Class|Namespace|Typedef|Primitive)\b\s*$', l)
      if m:
         t = m.group('type')
         if t == 'Type':
            t = 'relates'
         r = r'@%s \1'%t.lower()
         if t == 'Class':
            f = os.path.basename(fileName)
            if libName is not None:
               incName = "<%s/%s>"%(libName, f)
            else:
               incName = "<FOAM_LOCAL/%s>"%(f)
            r += '\n'+' '.join(('@headerfile', f, incName))
         del output[i]
         # unwrap following indented lines
         sl = []
         for j, ll in enumerate(output[i:]):
            if re.match(r'\S|^\s*$', ll):
               break
            sl.append(ll.strip())
         del output[i:i+len(sl)-1]
         output[i] = re.sub(r'^ {4}(.+)', r, '    '+''.join(sl))
         output[i] += len(sl)*'\n'
         continue
      # transform special headings
      m = re.match(r'(?P<heading>'+
            '|'.join((
               'Description', 'Usage', r'See\s*Also', 'Author', 'Note', 'To[Dd]o',
               'Warning', 'Deprecated')) + r')\b\s*$', l)
      if m:
         t = m.group('heading')
         if t == 'Description':
            del output[i]
            output.insert(i,
                  '<a class="anchor" name="Description"></a> @brief\n')
         elif t == 'Usage':
            output[i] = '@par Usage\n'
         elif re.match(r'See\s*Also', t):
            output[i] = '@see\n'
         else:
            output[i] = '@'+t.lower()+'\n'
         for j, ll in iter:
            output[j] = re.sub(r'\s{4}', '', ll)
            if re.match(r'\S', output[j+1]):
               break
         continue

      # treat SourceFiles list
      if re.match(r'SourceFiles\s*$', l):
         output[i] = '@par Source files\n<ul><li>%s</li>\n'%relFileName
         for j, ll in iter:
            if re.match(r'\s*$', ll):
               output[j-1] = output[j-1][:-1] + '</ul>\n'
               del output[j]
               break
            output[j] = re.sub(r'\s*(\w+\.\w+)',
                  r'  <li>%s/\1</li>'%os.path.dirname(relFileName), ll)
         continue

      # fix #include "partial/path/someFile.H" to read
      # #include "path/to/partial/path/someFile.H"
      m = re.match(r'\s*#\s*include\s+"([^"]+\.[CH])"', l)
      if m:
         incFile = m.group(1)
         fullIncFile = os.path.join(os.path.dirname(fileName), incFile)
         if os.path.isfile(fullIncFile):
            output[i] = '#include "%s"\n'%os.path.relpath(fullIncFile, baseDir)
         else:
            echo('ERROR: cannot resolve relative include "%s"\n'%incFile,
                  file=sys.stderr)
            sys.exit(1)

      # fix #include <someLib/someFile.H> to read
      # #include "relative/path/to/someFile.H" incWrapperDir is not empty.
      if incWrapperDir:
         try:
            m = re.match(r'\s*#\s*include\s+<(([^>]+)/(\w+\.[CH]))>', l)
            if m:
               incWrapper = os.path.normpath(os.path.join(incWrapperDir, m.group(1)))
               if os.path.isfile(incWrapper):
                  # parse the file for the first #include statement
                  realInclude = None
                  for ll in open(incWrapper, 'rt'):
                     mm = re.match(r'#include "(.*)"', ll)
                     if mm:
                        realInclude = mm.group(1)
                        break
                  if not realInclude:
                     raise DoxyFiltError(
                           'ERROR: Failed to parse include wrapper "%s"\n'%
                           incWrapper)
                  realInclude = os.path.normpath(os.path.join(
                     incWrapperDir, m.group(2), realInclude))
                  if not os.path.isfile(realInclude):
                     raise DoxyFiltError(
                           'ERROR: Wrapped include file "%s" does not exist\n'%
                           realInclude)
                  realInclude = os.path.relpath(realInclude, baseDir)
                  output[i] = '#include "%s"\n'%realInclude
         except DoxyFiltError:
            e = sys.exc_info()[1]
            echo(str(e), file=sys.stderr)
   # append @file command if not already present
   if not foundFileCommand:
      output.append('/*! @file %s */\n'%relFileName)
   # finally write to stdout
   echo(''.join(output))

# ------------------------- vim: set sw=3 sts=3 et: --------------- end-of-file
