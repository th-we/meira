<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <import href="../shared/matchingHelper.xsl"/>
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  
  <template match="def:scaleFactor" mode="generic-default">
    <xsl:copy-of select="1"/>
  </template>
  <template match="def:scaleFactor" mode="add-as-type-attribute">
    <attribute name="as">xs:float*</attribute>
  </template>
  
  <template match="def:scaleFactor" mode="create-getter-templates">
    <param name="elementNames" as="xs:string*"/>
    
    <xsl:key name="{g:createKeyName(@name,$elementNames)}" use="substring(@{@name},1,1)">
      <attribute name="match">
        <value-of select="g:matchPattern($elementNames)"/>
      </attribute>
    </xsl:key>
    
    <!-- Elements without {@name} attribute (=> defaults) -->
    <xsl:template mode="get_{@name}" priority="-1">
      <attribute name="match">
        <value-of select="g:matchPattern($elementNames)"/>
      </attribute>
      <xsl:copy-of select="({@anchor}) * ({@lacuna})"/>
    </xsl:template>
    
    <!-- Attribute with p Unit -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@{@name},2))"/>
    </xsl:template>
    <!-- Attribute with s Unit -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@{@name},2))"/>
    </xsl:template>
  </template>
  
</stylesheet>