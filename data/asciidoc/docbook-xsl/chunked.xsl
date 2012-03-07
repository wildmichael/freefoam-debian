<!--
  Generates chunked XHTML documents from DocBook XML source using DocBook XSL
  stylesheets.
-->
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
  <!ENTITY copy "&#169;">
  <!ENTITY reg "&#174;">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version="1.0">

<xsl:include href="orig-chunked.xsl"/>

<xsl:include href="custom.xsl"/>

<xsl:template name="user.header.navigation">
  <xsl:call-template name="foam.header.content"/>
</xsl:template>

</xsl:stylesheet>
