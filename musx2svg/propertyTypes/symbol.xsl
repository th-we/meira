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
  
  <template match="def:symbol" mode="generic-default">
    <text>''</text>
  </template>
  <template match="def:symbol" mode="add-as-type-attribute">
    <attribute name="as">xs:string*</attribute>
  </template>
  
  <template match="def:symbol" mode="create-getter-templates">
    <param name="elementNames" as="xs:string*"/>

    <!-- Elements without @{@name} attribute (=> defaults) -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-1">
      <xsl:sequence select="concat($symbolURIroot,'#{@lacuna}')"/>
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
    
    <xsl:template mode="get_OwnBoundingBox" match="{g:matchPattern($elementNames)}" priority="1">
      <xsl:variable name="symbolID" select="substring-after(g:{@name}(.),'#')" as="xs:string"/>
      <!-- Why doesn't this work? -->
      <!--      <xsl:variable name="symbolBBox" select="id($symbolID,document($symbolURIroot))/svg:metadata/bbox" as="node()"/>-->
      <xsl:variable name="symbolBBox" select="document($symbolURIroot)//svg:*[@id=$symbolID]/svg:metadata/*:bbox" as="node()"/>
      
      
      <musx:BoundingBox
        left="{{g:x(.) + g:size(..)*number($symbolBBox/@x)}}"
        right="{{g:x(.) + g:size(..)*sum(($symbolBBox/@x,$symbolBBox/@width))}}"
        top="{{g:y(.) + g:size(..)*number($symbolBBox/@y)}}"
        bottom="{{g:y(.) + g:size(..)*sum(($symbolBBox/@y,$symbolBBox/@height))}}"
        source="symbol '{@name}' on {{local-name()}}"/>
    </xsl:template>
    
  </template>
</stylesheet>