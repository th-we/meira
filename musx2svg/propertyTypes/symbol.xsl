<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET"
    xmlns:musx="NS:MUSX">
  <xsl:import href="../shared/matchingHelper.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="" result-prefix="xsl"/>
  
  <xsl:template match="def:symbol" mode="generic-default"/>
  <xsl:template match="def:symbol" mode="add-as-type-attribute">
    <xsl:attribute name="as">xs:string*</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="def:symbol" mode="create-getter-templates">
    <xsl:param name="elementNames" as="xs:string*"/>

    <!-- Elements without @{@name} attribute (=> defaults) -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
    	<value-of select="concat($libDirectory,'/',$symbolFile,'#',{@lacuna})"/>
    </template>
    
    <xsl:variable name="dot">
      <xsl:text>'.'</xsl:text>
    </xsl:variable>
    <!-- element with @{@name} attribute that has a dot in it (like "rest.quarter") -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames, concat('[contains(@',@name,',',$dot,')]'))}"
        priority="2">
    	<sequence select="concat($libDirectory,'/',$symbolFile,'#',@{@name})"/>
    </template>
    <!-- element with @{@name} attribute that does not have a dot in it (like "quarter", without "rest." before) -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames, concat('[@',@name,']'))}">
    	<sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@{@name})"/>
    </template>
    
    <template mode="get_OwnBoundingBox" match="{g:matchPattern($elementNames)}" priority="-1">
      <variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:{@name}(.))" as="node()*"/>
      <if test="$symbolBBox">
        <variable name="size" select="g:size(.)"/>
        <variable name="x" select="g:x(.)"/>
        <variable name="y" select="g:y(.)"/>
        
        <musx:BoundingBox
          left="{{  $x + $size*number($symbolBBox/@left)}}"
          right="{{ $x + $size*number($symbolBBox/@right)}}"
          top="{{   $y + $size*number($symbolBBox/@top)}}"
          bottom="{{$y + $size*number($symbolBBox/@bottom)}}"/>
      </if>
    </template>
    
  </xsl:template>
</xsl:stylesheet>