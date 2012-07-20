<!--
  Generates chunked XHTML documents from DocBook XML source using DocBook XSL
  stylesheets.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version="1.0">

<xsl:import href="orig-xhtml.xsl"/>

<xsl:import href="custom.xsl"/>

<xsl:template name="user.header.content">
  <xsl:call-template name="foam.header.content"/>
</xsl:template>

</xsl:stylesheet>
