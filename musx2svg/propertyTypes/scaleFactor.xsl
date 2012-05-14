<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <xsl:import href="../shared/matchingHelper.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="" result-prefix="xsl"/>
  
  <xsl:template match="def:scaleFactor" mode="generic-default">
    <copy-of select="1"/>
  </xsl:template>
  <xsl:template match="def:scaleFactor" mode="add-as-type-attribute">
    <xsl:attribute name="as">xs:double*</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="def:scaleFactor" mode="create-getter-templates">
    <xsl:param name="elementNames" as="xs:string*"/>
    
    <key name="{g:createKeyName(@name,$elementNames)}" use="substring(@{@name},1,1)">
      <xsl:attribute name="match">
        <xsl:value-of select="g:matchPattern($elementNames)"/>
      </xsl:attribute>
    </key>
    
    <!-- Elements without {@name} attribute (=> defaults) -->
    <template mode="get_{@name}" priority="-2">
      <xsl:attribute name="match">
        <xsl:value-of select="g:matchPattern($elementNames)"/>
      </xsl:attribute>
      <copy-of select="({@anchor}) * ({@lacuna})"/>
    </template>
    
    <!-- Attribute wihtout Unit -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames,concat('[@',@name,']'))}" priority="-1">
      <copy-of select="number(@{@name})"/>
    </template>
    
    <!-- Attribute with p Unit -->
    <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@{@name},2))"/>
    </template>
    <!-- Attribute with s Unit -->
    <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@{@name},2))"/>
    </template>
  </xsl:template>
  
</xsl:stylesheet>