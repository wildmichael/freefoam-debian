<?xml version='1.0'?>
<!--
Additional user-stylesheet for dblatex. It customizes
- the template matching the <alt> element such that no automatic math mode
  wrappers are added
- the appearance of <gui(menu|label|button|icon)> elements
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<xsl:import href="orig-asciidoc-dblatex.xsl"/>

<!-- Direct copy of the content -->

<xsl:template match="alt" mode="latex">
  <xsl:variable name="delim">
    <xsl:if test="processing-instruction('texmath')">
      <xsl:call-template name="pi-attribute">
        <xsl:with-param name="pis"
                   select="processing-instruction('texmath')"/>
        <xsl:with-param name="attribute" select="'delimiters'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="tex">
    <xsl:variable name="text" select="normalize-space(.)"/>
    <xsl:variable name="len" select="string-length($text)"/>
    <xsl:choose>
    <xsl:when test="$delim='user'">
      <xsl:copy-of select="."/>
    </xsl:when>
    <xsl:when test="ancestor::equation[not(child::title)]">
      <!-- Remove any math mode in an equation environment -->
      <xsl:choose>
      <xsl:when test="starts-with($text,'$') and
                      substring($text,$len,$len)='$'">
        <xsl:copy-of select="substring($text, 2, $len - 2)"/>
      </xsl:when>
      <xsl:when test="(starts-with($text,'\[') and
                       substring($text,$len - 1,$len)='\]') or
                      (starts-with($text,'\(') and
                       substring($text,$len - 1,$len)='\)')">
        <xsl:copy-of select="substring($text, 3, $len - 4)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <!-- Test to be DB5 compatible, where <alt> can be in other elements -->
    <xsl:when test="ancestor::equation or
                    ancestor::informalequation or
                    ancestor::inlineequation">
      <!-- Keep the specified math mode... -->
      <xsl:choose>
      <xsl:when test="(starts-with($text,'\[') and
                       substring($text,$len - 1,$len)='\]') or
                      (starts-with($text,'\(') and
                       substring($text,$len - 1,$len)='\)') or
                      (starts-with($text,'$') and
                       substring($text,$len,$len)='$')">
        <xsl:copy-of select="$text"/>
      </xsl:when>
      <!-- ...Or wrap in default math mode -->
      <xsl:otherwise>
        <!-- ...Or rather not...
        <xsl:copy-of select="concat('$', $text, '$')"/>-->
        <xsl:copy-of select="$text"/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise/>
    </xsl:choose>
  </xsl:variable>
  <!-- Encode it properly -->
  <xsl:call-template name="scape-encode">
    <xsl:with-param name="string" select="$tex"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="guibutton|guiicon|guilabel|guimenu">
  <xsl:call-template name="inline.italicseq"/>
</xsl:template>

</xsl:stylesheet>
