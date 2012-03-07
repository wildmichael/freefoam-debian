<!--
  Inlcuded in xhtml.xsl, xhtml.chunked.xsl, htmlhelp.xsl.
  Contains common XSL stylesheets parameters.
  Output documents styled by docbook.css.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="orig-common.xsl"/>
<!-- Exclude GNU FDL sections from TOC (how to do this with dblatex???) -->
<xsl:template match="appendix[@id='sec_gnu_fdl']//section"  mode="toc" />
</xsl:stylesheet>
