<!--
  Custom parameters and user templates.
-->

<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
  <!ENTITY copy "&#169;">
  <!ENTITY reg "&#174;">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="date"
  version="1.0">

<!-- ======================================================================
     default values for parameters
     ====================================================================== -->
<xsl:param name="foam.ug.current" select="0"/>    <!-- UserGuide is current -->
<xsl:param name="foam.api.current" select="0"/>   <!-- API doc is current   -->
<xsl:param name="foam.man.current" select="0"/>   <!-- man doc is current   -->
<xsl:param name="foam.doc.have_ug" select="0"/>   <!-- have local UserGuide -->
<xsl:param name="foam.doc.have_doxy" select="0"/> <!-- have local API doc   -->
<xsl:param name="foam.doc.have_man" select="0"/>  <!-- have local UserGuide -->
<xsl:param name="foam.doc.for_sf" select="0"/>    <!-- docs are for SF      -->
<xsl:param name="foam.use.mathjax" select="0"/>   <!-- user MathJax         -->
<xsl:param name="foam.mathjax.url"
  select="'http://cdn.mathjax.org/mathjax/latest'"/> <!-- MathJax URL       -->
<!-- relative path to doc base directory -->
<xsl:param name="foam.doc.location">
  <xsl:choose>
    <xsl:when test="$foam.man.current">../..</xsl:when>
    <xsl:otherwise>..</xsl:otherwise>
  </xsl:choose>
</xsl:param>
<!-- doc SF url -->
<xsl:param name="foam.doc.sf_url"
  select="concat('http://freefoam.sourceforge.net/doc/v',
                 $foam.version.full)"/>

<!-- user guide location -->
<xsl:param name="foam.ug.location">
  <xsl:choose>
    <xsl:when test="$foam.ug.current">.</xsl:when>
    <xsl:when test="$foam.doc.for_sf or $foam.doc.have_ug">
      <xsl:value-of select="concat($foam.doc.location, '/UserGuide')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat($foam.doc.sf_url, '/UserGuide')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:param>

<!-- API doc location -->
<xsl:param name="foam.api.location">
  <xsl:choose>
    <xsl:when test="$foam.api.current">.</xsl:when>
    <xsl:when test="$foam.doc.for_sf or $foam.doc.have_doxy">
      <xsl:value-of select="concat($foam.doc.location, '/API')"/></xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat($foam.doc.sf_url, '/API')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:param>

<!-- XHTML manpages location -->
<xsl:param name="foam.man.location">
  <xsl:choose>
    <xsl:when test="$foam.man.current">..</xsl:when>
    <xsl:when test="$foam.doc.for_sf or $foam.doc.have_man">
      <xsl:value-of select="concat($foam.doc.location, '/man')"/></xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat($foam.doc.sf_url, '/man')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:param>

<!-- =====================================================================
     customization templates
     ===================================================================== -->
<xsl:template name="user.head.content">
  <link rel="stylesheet" href="{$foam.doc.location}/css/xhtml11.css" type="text/css" />
  <link rel="stylesheet" href="{$foam.doc.location}/css/layout.css" type="text/css" />
  <link rel="stylesheet" href="{$foam.doc.location}/css/custom.css" type="text/css" />
  <xsl:if test="$foam.use.mathjax">
    <script type="text/javascript"
      src="{$foam.mathjax.url}/MathJax.js?config=default"/>
    <script type="text/javascript"
      src="{$foam.doc.location}/js/MathJaxMacros.js"/>
  </xsl:if>
</xsl:template>

<xsl:template name="foam.header.content">
<div id="layout-banner-box">
  <div id="layout-banner">
    <a href="http://freefoam.sourceforge.net/index.html">
      <img id="layout-title" src="{$foam.doc.location}/img/FreeFOAMLogo.png" alt="FreeFOAM"/>
    </a>
    <img id="layout-description" src="{$foam.doc.location}/img/CrossPlatformToolkit.png"
      alt="The Cross-Platform CFD Toolkit"/>
  </div>
</div>
<div id="layout-menu-box">
  <div id="layout-menu">
    <ul>
      <li><a href="http://freefoam.sourceforge.net/index.html">Home</a></li>
      <li><a href="http://freefoam.sourceforge.net/downloads/index.html">
          Downloads</a></li>
      <li><a href="http://freefoam.sourceforge.net/documentation.html">
          Documentation</a></li>
      <li>
        <ul>
          <li><a href="{$foam.doc.location}/INSTALL.html">Installation</a></li>
          <li><a href="{$foam.ug.location}/index.html">
              <xsl:if test="$foam.ug.current">
                <xsl:attribute name="class">current_page</xsl:attribute></xsl:if>
              User&nbsp;Guide</a></li>
          <li><a href="{$foam.man.location}/man1/freefoam.1.html">
              <xsl:if test="$foam.man.current">
                <xsl:attribute name="class">current_page</xsl:attribute></xsl:if>
              man-pages</a></li>
          <li><a href="{$foam.api.location}/index.html">
              <xsl:if test="$foam.api.current">
                <xsl:attribute name="class">current_page</xsl:attribute></xsl:if>
              API&nbsp;Documentation</a></li>
          <li><a href="{$foam.doc.location}/README.html">README</a></li>
          <li><a href="{$foam.doc.location}/ReleaseNotes.html">Release Notes</a></li>
          <li><a href="{$foam.doc.location}/ChangeLog.html">Changes</a></li>
          <li><a href="{$foam.doc.location}/COPYING.html">License</a></li>
        </ul>
      </li>
      <li><a href="http://freefoam.sourceforge.net/support.html">
          Support</a></li>
      <li><a href="http://www.sourceforge.net/projects/freefoam">
          SourceForge Project</a></li>
    </ul>
  </div>
  <xsl:if test="$foam.doc.for_sf">
    <div id="layout-sf">
      Hosted by SourceForge:<br />
      <a href="http://sourceforge.net/projects/freefoam">
        <img
          src="http://sflogo.sourceforge.net/sflogo.php?group_id=215833&amp;type=12"
          width="120" height="30" alt="Get FreeFOAM at SourceForge.net.
          Fast, secure and Free Open Source software downloads" />
      </a>
    </div>
  </xsl:if>
</div>
<xsl:text disable-output-escaping="yes"><![CDATA[
<div id="layout-content-box">
  <div id="layout-content">
]]></xsl:text>
</xsl:template>

<xsl:template name="user.footer.content">
    <div id="footer">
      <div id="footer-text">
        Copyright&nbsp;&copy;&nbsp;2008-2011&nbsp;Michael Wild and Gerber van der Graaf<br/>
        Copyright&nbsp;&copy;&nbsp;2004-2011&nbsp;OpenCFD Ltd<br/>
        OpenFOAM&reg; and OpenCFD&reg; are registered trademarks of OpenCFD Limited.<br/>
        Last updated
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="date" select="date:date-time()"/>
          <xsl:with-param name="format" select="'c'"/>
        </xsl:call-template>
      </div>
    </div>
</xsl:template>

<xsl:template name="user.footer.navigation">
<xsl:text disable-output-escaping="yes"><![CDATA[
  </div>
</div>
]]></xsl:text>
</xsl:template>

</xsl:stylesheet>
