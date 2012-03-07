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
#-------------------------------------------------------------------------------

"""Parser to convert the Doxygen header comments to Asciidoc manpage source"""

import re as _re
import sys as _sys
from FreeFOAM.compat import *

class Parser:
  def __init__(self, sourceFile):
    """Initializes a Parser object.

    Parameters
    ----------
    sourceFile : Path to file containing the header doc.

    """
    self._sourceFile = sourceFile
    self._lines = open(sourceFile, 'rt').readlines()
    # insert blank fake line at beginning
    self._lines.insert(0, '')
    self._NR = 0
    self._0 = self._lines[self._NR]
    # state and helper variables
    self._in_head = False
    self._in_description = False
    self._in_brief = False
    self._in_doc = False
    self._current_section = None
    self._list_indents = []
    self._list_stack = []
    self._current_pattern = 0
    # set up the result data
    self._result = {
        'sections': {
          'Author': ['OpenCFD Ltd.', ''],
          'Brief': ['**TODO** write brief description', ''],
          'Usage': ['**TODO** write a usage section', ''],
          'SeeAlso': [''],
          },
        'arguments': [],
        'options': {},
        }
    # set up substitutions
    self._substitutions = (
        (_re.compile(r'^    '), ''),
        (_re.compile(r'[@\\](?:em|a)\s+(\w+)'), r'__\1__'),
        (_re.compile(r'[@\\]b\s+(\w+)'), r'**\1**'),
        (_re.compile(r'[@\\][cp]\s+(\w+)'), r'++\1++'),
        (_re.compile(r'[@\\]todo\s+'), r'**TODO** '),
        (_re.compile(r'</?em>'), r'__'),
        (_re.compile(r'</?b>'), r'**'),
        (_re.compile(r'</?tt>'), r'++'),
        (_re.compile(r'\\([<>])'), r'\1'),
        )

    # set up patterns
    self._strip_regex = _re.compile(r'^\s+')
    self._patterns = (
        (_re.compile(r'^/\*-----+\*\\$'), self._s_head_begin),
        (_re.compile(r'\*/'), self._s_head_end),
        (_re.compile(r'^Description'), self._s_description_kw),
        (_re.compile(r'^(?:Notes?|Usage|Author|See\s*Also)$'),
          self._s_special_section_kw),
        (_re.compile(r'^\s*- .*\[OPTIONS?\]'),
          self._s_swallow_paragraph),
        (_re.compile(r'^\s*$'), self._s_empty_line),
        (_re.compile(r'^\s*[@\\]verbatim\s*$'), self._s_verbatim_begin),
        (_re.compile(r'^\s*[@\\]endverbatim\s*$'), self._s_verbatim_end),
        (_re.compile(r'^\s*[@\\]param\b'), self._s_param_list),
        (_re.compile(r'^\s*-#\s+'), self._s_ordered_list),
        (_re.compile(r'^\s*-\s+'), self._s_unordered_list),
        (_re.compile(r'^\s*\.$'), self._s_list_termination),
        # MUST BE LAST
        (_re.compile(r'.*'), self._s_text),
        )

  def parse(self):
    """Converts the Doxygen header comments to a Asciidoc manpage.

    Returns
    -------
    A string with the Asciidoc source.

    """
    # process file
    while self._has_next_line():
      # go to next line
      self._next_line()
      while (self._has_next_line() and
          self._current_pattern < len(self._patterns)):
        pattern, action = self._patterns[self._current_pattern]
        # search the pattern and invoke the action if found
        m = pattern.search(self._0)
        if m:
          action(pattern, m)
        # go to next pattern
        self._current_pattern += 1

    # transfer special sections
    if not len(self._result['sections']['Detailed']):
      self._result['sections']['Detailed'] = (
          ['**TODO** write detailed description', ''])
    for s in 'Author Brief Detailed Usage SeeAlso'.split():
      self._result[s.lower()] = self._result['sections'][s]
      del self._result['sections'][s]

    return self._result

  def _s_head_begin(self, regex, match):
    """Parser action for the begin of the header comments"""
    self._in_head = True
    self._next_line()

  def _s_head_end(self, regex, match):
    """Parser action for the end of the header comments"""
    self._in_head = False
    self._NR = len(self._lines)

  def _s_description_kw(self, regex, match):
    """Parser action for the 'Description' keyword"""
    self._in_description = True
    self._in_brief = True
    self._current_section = 'Brief'
    self._result['sections']['Brief'] = []
    self._next_line()

  def _s_special_section_kw(self, regex, match):
    """Parser action for the special keywords ('Note', 'Usage', etc.)"""
    if self._current_section:
      self._flush_lists()
      sect = match.group(0)
      # sanitize section names
      if sect == 'Notes':
        sect = 'Note'
      if _re.match(r'See\s*[Aa]lso]', sect):
        sect = 'SeeAlso'
      self._current_section = sect
      self._result['sections'][sect] = []
      self._in_brief = False
      self._in_description = False
      self._next_line()

  def _s_swallow_paragraph(self, regex, match):
    """Parser action for paragraphs to swallow"""
    while(self._0 != "" and self._has_next_line()):
      self._next_line()

  def _s_empty_line(self, regex, match):
    """Parser action to detect the separation of sections"""
    if self._current_section:
      if self._in_description and self._in_brief:
        self._in_brief = False
        self._current_section = 'Detailed'
        self._result['sections']['Detailed'] = []
      else:
        if len(self._result['sections'][self._current_section]) > 0:
          self._add_text('')
    self._next_line()

  def _s_verbatim_begin(self, regex, match):
    """Parser action for @verbatim"""
    if self._current_section:
      if self._in_list():
        self._add_text('+', '--')
      self._add_text('.............')
      n = _re.match(r'^\s*', self._0).end() - 1
      self._strip_regex = _re.compile(r'^\s{1,%d}'%n)
      self._next_line()

  def _s_verbatim_end(self, regex, match):
    """Parser action for @endverbatim"""
    if self._current_section:
      self._add_text('.............')
      if(self._in_list()):
        self._add_text('--', '+')
      self._strip_regex = _re.compile(r'^\s+')
      self._next_line()

  def _s_param_list(self, regex, match):
    """Parser action for @param lists"""
    if self._current_section:
      self._handle_list('param')
      # strip \s*\\n from EOL
      self._0 = _re.sub(r'\s*\\n$', '', self._0)
      # special treatment for Usage section (ugly)
      if self._current_section == "Usage":
        # check whether it is a -opt option or a <argument>
        m = _re.match(r'^\s*[\\@]param\s*(?P<opt>-[^:\s]+)?(?:\s*(?P<arg><[^:>]+>))?', self._0)
        stat = True
        if m:
          if m.group('opt'):
            # it is an -opt option
            opt = m.group('opt')
            optstr = ['*%s*'%opt]
            if m.group('arg'):
              arg = m.group('arg')
              optstr.append("'%s'"%arg)
              self._result['options'][opt] = arg
            else:
              self._result['options'][opt] = None
            optstr.append('::')
            self._add_text(' '.join(optstr))
          elif m.group('arg'):
            # it is a <argument>
            arg = m.group('arg')
            self._result['arguments'].append(arg)
            self._add_text("'%s' ::"%arg)
          else:
            stat = False
        else:
          stat = False
        if not stat:
          echo('Error: failed to parse "%s" in file %s"'%
                (self._lines[self._NR], self._sourceFile), file=_sys.stderr)
        self._next_line()
      else:
        self._0 = _re.sub(r'^(\s*)[\\@]param\s+([^:]*[^:\s])(?:\s*:\s*(.*))?',
            "\\1'\\2'::\n\\1  \\3", self._0)

  def _s_ordered_list(self, regex, match):
    """Parser action for ordered (-# item) lists"""
    if self._current_section:
      self._handle_list('ordered')
      self._0 = _re.sub(r'(\s*)-#', r'\1. ', self._0)

  def _s_unordered_list(self, regex, match):
    """Parser action for unordered (- item) lists"""
    if self._current_section:
      self._handle_list('unordered')

  def _s_list_termination(self, regex, match):
    """Parser action for explicit list termination (single . at EOL)"""
    if self._current_section:
      self._handle_list("term")
      self._0 = _re.sub(r'  \.$','+',self._0)

  def _s_text(self, regex, match):
    """Parser action to handle remaining text"""
    if self._current_section:
      self._add_text(
          self._strip_regex.sub('', self._0)
          )
      self._next_line()

  def _add_text(self, *text):
    """Append text to the current section"""
    if self._current_section:
      self._result['sections'][self._current_section].extend(text)

  def _has_next_line(self):
    """Check whether we have a next line"""
    return self._NR < len(self._lines)

  def _next_line(self):
    """Proceed to next line"""
    self._NR += 1
    if self._has_next_line():
      self._0 = self._lines[self._NR][:-1]
      # apply substitutions
      for p, s in self._substitutions:
        self._0 = p.sub(s, self._0)
    self._current_pattern = -1

  def _push_list(self, type, indent):
    """if necessary, push a list level (worker function)"""
    if( not self._in_list() or
        indent > self._list_indents[-1] or
        ( indent==self._list_indents[-1] and
          type!=self._list_stack[-1] ) ):
      self._list_stack.append(type)
      self._list_indents.append(indent)
      if len(self._list_indents) > 1:
        self._add_text('+', '--');
      return True
    return False

  def _pop_list_work(self):
    """pop a list level without asking (worker function)"""
    self._list_stack.pop()
    self._list_indents.pop()
    if len(self._list_stack) > 0:
      self._add_text('--')

  def _pop_list(self, type, indent):
    """if necessary, pop list levels"""
    if type == 'term':
      while len(self._list_indents) and self._list_indents[-1] >= indent:
        self._pop_list_work();
    else:
      popped_list = False
      while len(self._list_indents) and (self._list_indents[-1] > indent or
          self._list_stack[-1] != type):
        popped_list = True
        self._pop_list_work()
      if self._in_list() and popped_list:
        self._add_text('+')

  def _flush_lists(self):
    """flush all lists"""
    if self._in_list():
       self._pop_list("term", self._list_indents[0]);

  def _handle_list(self, type):
    """Handle list element"""
    indent=len(_re.match(r'^\s*', self._0).group(0))
    if type == "term":
      self._pop_list(type,indent)
    elif self._push_list(type,indent):
      pass
    else:
      self._pop_list(type,indent)

  def _in_list(self):
    return len(self._list_stack)!=0

