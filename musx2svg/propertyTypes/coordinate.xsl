<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <import href="../shared/matchingHelper.xsl"/>
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  
  <template match="def:coordinate" mode="generic-default">
    <xsl:copy-of select="0"/>
  </template>
  <template match="def:coordinate" mode="add-as-type-attribute">
    <attribute name="as">xs:float*</attribute>
  </template>
  
  <template match="def:coordinate" mode="create-getter-templates">
    <!-- param elementNames holds the names of those element defintions that 
         have an identical coordinate property (same name, anchor and lacuna), 
         therefore the created templates can be shared. -->
    <param name="elementNames" as="xs:string*"/>
    
    <if test="not(substring(@name,1,1)=('x','y'))">
      <message terminate="yes">
        ERROR: Invalid property name "<value-of select="@name"/> 
               Properties of type coordinate need to have names that start with either x or y.
      </message>
    </if>
    
    <call-template name="createKeyElement">
      <with-param name="elementNames" select="$elementNames"/>
    </call-template>
    
    <!-- Elements without {@name} attribute (=> defaults) -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames)}" priority="-2">
      <xsl:copy-of select="({@anchor}) + ({@lacuna})"/>
    </xsl:template>
    <!-- Elements with {@name} attribute, but without unit: Simply return  -->
    <xsl:template mode="get_{@name}" match="{g:matchPattern($elementNames,concat('[@',@name,']'))}" priority="-1">
      <xsl:copy-of select="number(@{@name})"/>
    </xsl:template>
    
    <!-- p Unit: relative to default anchor position, in page units -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="({@anchor}) + g:size($page) * number(substring(@{@name},2))"/>
    </xsl:template>
    <!-- P Unit: relative to page position, in page units -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','P')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
       <!--                g:{substring(@name,1,1)}($page) evaluates to g:x($page) or g:y($page) -->
      <xsl:copy-of select="g:{substring(@name,1,1)}($page) + g:size($page) * number(substring(@{@name},2))"/>
    </xsl:template>
    <!-- s Unit: relative to default anchor position, in staff units ("scale steps") -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="({@anchor}) + (g:size($staff) * number(substring(@{@name},2)))"/>
    </xsl:template>
    <!-- S Unit: relative to staff position, in staff units ("scale steps") -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="(g:{substring(@name,1,1)}($staff)) + 
        (g:size($staff) * number(substring(@{@name},2)))"/>
    </xsl:template>
    <!-- L Unit: relative to staff position, in line distances (from bottom up!) -->
    <xsl:template mode="get_{@name}" match="key('{g:createKeyName(@name,$elementNames)}','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="(g:{substring(@name,1,1)}($staff)) - 
        + 2 * g:size($staff) * (number(substring(@{@name},2)) - 1)"/>
    </xsl:template>
  </template>
  
</stylesheet>