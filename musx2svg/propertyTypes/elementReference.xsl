<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <import href="../shared/matchingHelper.xsl"/>
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  
  <template match="def:elementReference" mode="generic-default">
    <xsl:sequence select="$elements/.."/>
  </template>
  <template match="def:elementReference" mode="add-as-type-attribute">
    <attribute name="as">node()*</attribute>
  </template>
  
  <template match="def:elementReference" mode="create-getter-templates">
    <param name="elementNames" as="xs:string*"/>

    <!-- Elements without @{@name} attribute (=> defaults) -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
      <xsl:sequence select="{@lacuna}"/>
    </xsl:template>
    
    <!-- Element with @{@name} attribute -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames, concat('[@',@name,']'))}">
      <xsl:sequence select="id(@{@name})"/>
    </xsl:template>
  </template>
  
</stylesheet>