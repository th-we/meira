<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <xsl:import href="../shared/matchingHelper.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  
  <xsl:template match="def:coordinate" mode="generic-default">
    <copy-of select="0"/>
  </xsl:template>
  <xsl:template match="def:coordinate" mode="add-as-type-attribute">
    <xsl:attribute name="as">xs:double*</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="def:coordinate" mode="create-getter-templates">
    <!-- param elementNames holds the names of those element defintions that 
         have an identical coordinate property (same name, anchor and lacuna), 
         therefore the created templates can be shared. -->
    <xsl:param name="elementNames" as="xs:string*"/>
    
    <xsl:call-template name="createKeyElement">
      <xsl:with-param name="elementNames" select="$elementNames"/>
    </xsl:call-template>
    
    <!-- Elements without {@name} attribute (=> defaults) -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-2">
      <copy-of select="({@anchor}) + ({@lacuna})"/>
    </template>
    <!-- Elements with {@name} attribute, but without unit: Simply return  -->
    <template mode="get_{@name}" match="{g:matchPattern($elementNames,concat('[@',@name,']'))}" priority="-1">
      <copy-of select="number(@{@name})"/>
    </template>
    
    <!-- p Unit: relative to default anchor position, in page units -->
    <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="({@anchor}) + g:size($page) * number(substring(@{@name},2))"/>
    </template>
    <!-- P Unit: relative to page position, in page units -->
    <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
       <!--                g:{@orientation}($page) evaluates to g:x($page) or g:y($page) -->
      <copy-of select="g:{@orientation}($page) + g:size($page) * number(substring(@{@name},2))"/>
    </template>
    <!-- s Unit: relative to default anchor position, in staff units ("scale steps") -->
    <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="({@anchor}) + (g:size($staff) * number(substring(@{@name},2)))"/>
    </template>
    <!-- These two units only make sense for vertical coordinates -->
    <xsl:if test="@orientation = 'y'">
      <!-- S Unit: relative to staff position, in staff units ("scale steps") -->
      <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','S')">
        <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
        <copy-of select="(g:y1($staff)) + 
          (g:size($staff) * number(substring(@{@name},2)))"/>
      </template>
      <!-- L Unit: relative to staff position, in line distances (from bottom up!) -->
      <template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','L')">
        <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
        <copy-of select="(g:y2($staff)) - 
          + 2 * g:size($staff) * (number(substring(@{@name},2)) - 1)"/>
      </template>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>