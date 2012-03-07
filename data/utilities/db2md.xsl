<?xml version='1.0'?>
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                ______                _     ____          __  __
               |  ____|             _| |_  / __ \   /\   |  \/  |
               | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
               |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
               | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
               |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|

                    FreeFOAM: The Cross-Platform CFD Toolkit

  Copyright (C) 2008-2012 Michael Wild themiwi@users.sf.net
                          Gerber van der Graaf gerber_graaf@users.sf.net
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  License
    This file is part of FreeFOAM.

    FreeFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.

  Description
      XSLT stylesheet to convert a very limited subset of DocBook XML to
      Markdown. This is used to generate the SourceForge README file in the
      download section.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml"
  version="1.0"
  >

<xsl:output method="text"/>

<!-- match articleinfo -->
<xsl:template match="articleinfo">
  <xsl:text># </xsl:text><xsl:value-of select="./title"/><xsl:text>&#xa;</xsl:text>
  <xsl:value-of select="./author/firstname"/><xsl:text> </xsl:text>
  <xsl:value-of select="./author/surname"/><xsl:text>  &#xa;</xsl:text>
  <xsl:text>&lt;</xsl:text><xsl:value-of select="./author/email"/>
  <xsl:text>&gt;  &#xa;</xsl:text>
  <xsl:text>version </xsl:text>
  <xsl:value-of select="./revhistory/revision/revnumber"/><xsl:text>, </xsl:text>
  <xsl:value-of select="./revhistory/revision/date"/><xsl:text>&#xa;</xsl:text>
</xsl:template>

<!-- match para and simpara -->
<xsl:template match="para|simpara">
  <xsl:apply-templates/>
  <xsl:text>&#xa;</xsl:text>
</xsl:template>

<!-- match ulink -->
<xsl:template match="ulink">
  <xsl:text>[</xsl:text><xsl:value-of select="text()"/><xsl:text>](</xsl:text>
  <!-- bad hack! -->
  <xsl:if test="(@url = 'INSTALL.html') or (@url = 'ChangeLog.html')">
    <xsl:text>http://freefoam.sourceforge.net/downloads/v</xsl:text>
    <xsl:value-of select="//articleinfo/revhistory/revision/revnumber"/><xsl:text>/</xsl:text>
  </xsl:if>
  <xsl:value-of select="@url"/><xsl:text>)</xsl:text>
</xsl:template>

<!-- match itemizedlist -->
<xsl:template match="itemizedlist/listitem">
  <xsl:text>* </xsl:text><xsl:apply-templates select="simpara"/>
</xsl:template>

</xsl:stylesheet>
