<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET"
    xmlns:musx="NS:MUSX">
  <import href="../shared/matchingHelper.xsl"/>
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  
  <template match="def:symbol" mode="generic-default"/>
  <template match="def:symbol" mode="add-as-type-attribute">
    <attribute name="as">xs:string*</attribute>
  </template>
  
  <template match="def:symbol" mode="create-getter-templates">
    <param name="elementNames" as="xs:string*"/>

    <!-- Elements without @{@name} attribute (=> defaults) -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
      <xsl:value-of select="concat($symbolURIroot,'#',{@lacuna})"/>
    </xsl:template>
    
    <variable name="dot">
      <text>'.'</text>
    </variable>
    <!-- element with @{@name} attribute that has a dot in it (like "rest.quarter") -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames, concat('[contains(@',@name,',',$dot,')]'))}"
        priority="2">
      <xsl:sequence select="concat($symbolURIroot,'#',@{@name})"/>
    </xsl:template>
    <!-- element with @{@name} attribute that does not have a dot in it (like "quarter", without "rest." before) -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames, concat('[@',@name,']'))}">
      <xsl:sequence select="concat($symbolURIroot,'#',local-name(),'.',@{@name})"/>
    </xsl:template>
    
    <xsl:template mode="get_OwnBoundingBox" match="{g:matchPattern($elementNames)}" priority="-1">
      <xsl:variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:{@name}(.))" as="node()*"/>
      <xsl:if test="$symbolBBox">
        <xsl:variable name="size" select="g:size(.)"/>
        <xsl:variable name="x" select="g:x(.)"/>
        <xsl:variable name="y" select="g:y(.)"/>
        
        <musx:BoundingBox
          left="{{  $x + $size*number($symbolBBox/@x)}}"
          right="{{ $x + $size*sum(($symbolBBox/@x,$symbolBBox/@width))}}"
          top="{{   $y + $size*number($symbolBBox/@y)}}"
          bottom="{{$y + $size*sum(($symbolBBox/@y,$symbolBBox/@height))}}"
          source="symbol '{@name}' on {{local-name()}}"/>
      </xsl:if>
    </xsl:template>
    
  </template>
</stylesheet>