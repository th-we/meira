<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <xsl:import href="../shared/matchingHelper.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="" result-prefix="xsl"/>
  
  <xsl:template match="def:integer" mode="generic-default">
    <copy-of select="0"/>
  </xsl:template>
  <xsl:template match="def:integer" mode="add-as-type-attribute">
    <xsl:attribute name="as">xs:integer*</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="def:integer" mode="create-getter-templates">
    <xsl:param name="elementNames" as="xs:string*"/>
    
    <!-- Elements without {@name} attribute (=> defaults) -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
      <copy-of select="{@lacuna}"/>
    </template>
    
    <template mode="get_{@name}" match="{g:matchPattern($elementNames,concat('[@',@name,']'))}">
      <copy-of select="@{@name} cast as xs:integer"/>
    </template>
  </xsl:template>
  
</xsl:stylesheet>