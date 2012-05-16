<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svg="http://www.w3.org/2000/svg"
  xmlns="http://www.w3.org/2000/svg"
  version="2.0">
  <xsl:namespace-alias stylesheet-prefix="svg" result-prefix=""/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="." mode="clean-svg"/>
  </xsl:template>
  
  <xsl:template match="@*|node()" mode="clean-svg">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="clean-svg"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="svg:svg" mode="clean-svg">
    <svg xmlns:xlink="http://www.w3.org/1999/xlink">
      <xsl:apply-templates select="@*|node()" mode="clean-svg"/>
    </svg>
  </xsl:template>
  
  <xsl:template match="svg:*" mode="clean-svg">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()" mode="clean-svg"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>