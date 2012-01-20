<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <import href="../shared/matchingHelper.xsl"/>
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  
  <template match="def:integer" mode="generic-default">
    <copy-of select="0"/>
  </template>
  <template match="def:integer" mode="add-as-type-attribute">
    <attribute name="as">xs:integer*</attribute>
  </template>
  
  <template match="def:integer" mode="create-getter-templates">
    <param name="elementNames" as="xs:string*"/>
    
    <!-- Elements without {@name} attribute (=> defaults) -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
      <xsl:copy-of select="{@lacuna}"/>
    </xsl:template>
    
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames,concat('[@',@name,']'))}">
      <xsl:copy-of select="@{@name} cast as xs:integer"/>
    </xsl:template>
  </template>
  
</stylesheet>