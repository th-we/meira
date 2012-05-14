<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <xsl:import href="../shared/matchingHelper.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="" result-prefix="xsl"/>
  
  <xsl:template match="def:elementReference" mode="generic-default">
    <sequence select="$elements/.."/>
  </xsl:template>
  <xsl:template match="def:elementReference" mode="add-as-type-attribute">
    <xsl:attribute name="as">node()*</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="def:elementReference" mode="create-getter-templates">
    <xsl:param name="elementNames" as="xs:string*"/>

    <!-- Elements without @{@name} attribute (=> defaults) -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
      <sequence select="{@lacuna}"/>
    </template>
    
    <!-- Element with @{@name} attribute -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames, concat('[@',@name,']'))}">
      <variable name="referencedElement" select="id(@{@name})" as="element()?"/>
      <choose>
        <when test="$referencedElement">
          <sequence select="$referencedElement"/>
        </when>
        <otherwise>
          <message terminate="yes">
            <value-of select="local-name()"/> element <value-of select="@xml:id"/> references non-existent element <value-of select="@{@name}"/>
          </message>
        </otherwise>
      </choose>
    </template>
  </xsl:template>
  
</xsl:stylesheet>