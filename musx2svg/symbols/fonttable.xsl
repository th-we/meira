<?xml version="1.0" ?>
<!-- 
  This stylesheet renders all glyphs of a font in a scroll view.
-->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:svg="http://www.w3.org/2000/svg">
  
  <xsl:template name="get-token-n">
    <xsl:param name="string"/>
    <xsl:param name="n"/>
    <xsl:choose>
      <xsl:when test="$n = 1">
        <xsl:value-of select="substring-before(concat(normalize-space($string),' '),' ')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="get-token-n">
          <xsl:with-param name="string" select="substring-after(normalize-space($string),' ')"/>
          <xsl:with-param name="n" select="$n - 1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="/">
    <xsl:variable name="bbox" select="//svg:font/svg:font-face/@bbox"/>
    <xsl:variable name="bbox.x1">
      <xsl:call-template name="get-token-n">
        <xsl:with-param name="string" select="$bbox"/>
        <xsl:with-param name="n" select="1"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="bbox.y1">
      <xsl:call-template name="get-token-n">
        <xsl:with-param name="string" select="$bbox"/>
        <xsl:with-param name="n" select="2"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="bbox.x2">
      <xsl:call-template name="get-token-n">
        <xsl:with-param name="string" select="$bbox"/>
        <xsl:with-param name="n" select="3"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="bbox.y2">
      <xsl:call-template name="get-token-n">
        <xsl:with-param name="string" select="$bbox"/>
        <xsl:with-param name="n" select="4"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="bbox.height" select="$bbox.y2 - $bbox.y1"/>
    <xsl:variable name="bbox.width" select="$bbox.x2 - $bbox.x1"/>
    
    <svg:svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="{count(//svg:font/svg:glyph) * ($bbox.x2 - $bbox.x1)}">
      <svg:defs>
        <svg:g id="box" fill="none" stroke="black">
          <svg:rect width="{$bbox.x2 - $bbox.x1}" height="{$bbox.height}" stroke-width="2"/>
          <svg:path d="M{0 - $bbox.x1} 0 v{$bbox.height}M0 {$bbox.y2}h {$bbox.width}"/>
        </svg:g>
      </svg:defs>
      <xsl:apply-templates select="//svg:font/svg:glyph">
        <xsl:with-param name="bbox.width" select="$bbox.width"/>
        <xsl:with-param name="bbox.height" select="$bbox.height"/>
        <xsl:with-param name="bbox.x1" select="$bbox.x1"/>
        <xsl:with-param name="bbox.y2" select="$bbox.y2"/>
      </xsl:apply-templates>
    </svg:svg>
  </xsl:template>
  
  <xsl:template match="svg:glyph">
    <xsl:param name="bbox.x1"/>
    <xsl:param name="bbox.y2"/>
    <xsl:param name="bbox.width"/>
    <xsl:param name="bbox.height"/>
    
    <svg:g transform="translate({$bbox.width * count(preceding-sibling::svg:glyph)},20)">
      <svg:text>
        <xsl:value-of select="@glyph-name"/>
      </svg:text>
      <svg:use xlink:href="#box"/>
      <svg:path d="M{(@horiz-adv-x|../svg:font-face/@horiz-adv-x)[last()] - $bbox.x1} 0 v{$bbox.height}" fill="none" stroke="black"/>
      <svg:g transform="scale(1,-1) translate({0 - $bbox.x1},{0 - $bbox.y2})">
        <xsl:apply-templates select="@d|*" mode="draw-glyph"/>
      </svg:g>
    </svg:g>
  </xsl:template>
  
  <xsl:template match="svg:*" mode="draw-glyph">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="@d" mode="draw-glyph">
    <svg:path d="{.}"/>
  </xsl:template>
</xsl:stylesheet>
