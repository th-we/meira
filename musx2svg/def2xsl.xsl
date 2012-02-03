<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0" 
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
  xmlns:xsl-ns="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:def="NS:DEF"
  xmlns:g="NS:GET"
  xmlns:musx="NS:MUSX">
  
  <import href="propertyTypes/propertyTypesLoader.xsl"/>
  <import href="shared/matchingHelper.xsl"/>
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
  <output indent="yes"/>
  
  <!-- All content with xsl: prefix is written as output -->
  
  <template match="/def:elementDefinition/def:element[@name='musx']">
    <xsl:stylesheet version="2.0"  exclude-result-prefixes="xs def g musx svg">
      <xsl:output indent="yes"/>
      
      <xsl:variable name="symbolURIroot" select="/musx:musx/musx:musxHead/musx:symbols/@xlink:href"/>
      
      <call-template name="add-getter-functions-and-templates">
        <with-param name="properties" as="node()*">
          <for-each select="def:includeDefinition">
            <sequence select="document(@href)/def:elementDefinition/def:element/def:properties/def:*"/>
          </for-each>
        </with-param>
      </call-template>
      
      <for-each select="def:includeDefinition">
        <variable name="element" select="document(@href)/def:elementDefinition/def:element" as="node()*"/>
        <!-- TODO: Currently, there is no guaranty that templates, function etc. with identical names are
                   supplied by different element definitions. Work out naming scheme or check mechanism so
                   that we prevent clashes when copying everything! -->
        <copy-of select="$element/xsl-ns:*"/>
        <apply-templates select="$element/def:OwnBoundingBox"/>
        <apply-templates select="$element/def:draw"/>
      </for-each>

      <!-- Templates that are common for all draw templates -->
      <xsl:template match="@xml:id" mode="copy-svg-and-id-attributes">
        <xsl:attribute name="id">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:template>
      <xsl:template match="@svg:*" mode="copy-svg-and-id-attributes">
        <xsl:attribute name="{'{'}local-name(){'}'}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:template>
      <xsl:template match="@*" mode="copy-svg-and-id-attributes"/>
      
      <!-- Default draw template: Ignore unknown content -->
      <xsl:template match="*" mode="draw" priority="-5"/>
      
      <!-- Templates that transform <musx:musxHead> to <svg:defs> -->
      <xsl:template match="musx:musxHead" mode="generate-defs">
        <svg:defs>
          <xsl:apply-templates mode="generate-defs"/>
        </svg:defs>
      </xsl:template>
      <xsl:template match="*" mode="generate-defs" priority="-1"/>
      <xsl:template match="svg:*" mode="generate-defs">
        <xsl:copy-of select="."/>
      </xsl:template>
      
      <!-- Main template for converting to SVG -->
      <xsl:template match="/musx:musx">
        <svg:svg>
          <xsl:apply-templates select="musx:musxHead[*]" mode="generate-defs"/>
          <xsl:apply-templates mode="draw"/>
        </svg:svg>
      </xsl:template>
      
      <!-- Template for adding bounding box dimension info to the musx data.
           To use this template, add-bounding-boxes has to be set as the initial mode 
           (e.g. using the switch -im:add-bounding-boxes with saxonb-xslt) -->
      <xsl:template match="@*|node()" mode="add-bounding-boxes">
        <xsl:copy>
          <xsl:apply-templates mode="add-bounding-boxes" select="@*|node()"/>
        </xsl:copy>
      </xsl:template>
      
      <xsl:template match="musx:*" mode="add-bounding-boxes" priority="1">
        <xsl:variable name="children" as="node()*">
          <xsl:apply-templates mode="add-bounding-boxes" select="node()"/>
        </xsl:variable>
        <xsl:variable name="allBoundingBoxes" as="node()*">
          <xsl:sequence select="$children/musx:BoundingBox"/>
          <xsl:apply-templates mode="get_OwnBoundingBox" select="."/>
        </xsl:variable>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:copy-of select="$children"/>
          <xsl:if test="$allBoundingBoxes">
            <musx:BoundingBox 
              left="{{min($allBoundingBoxes//@left)}}"
              right="{{max($allBoundingBoxes//@right)}}"
              top="{{min($allBoundingBoxes//@top)}}"
              bottom="{{max($allBoundingBoxes//@bottom)}}"/>
          </xsl:if>
        </xsl:copy>
      </xsl:template>
      <xsl:template match="node()|@*" mode="get_OwnBoundingBox" priority="-2"/>
      <xsl:function name="g:OwnBoundingBox" as="node()*">
        <xsl:param name="element" as="node()*"/>
        <xsl:apply-templates select="$element" mode="get_OwnBoundingBox"/>
      </xsl:function>
      
      <xsl:key name="svgID" match="svg:*[@id]" use="@id"/>
      <xsl:function name="g:svgSymbolBoundingBox" as="node()*">
        <xsl:param name="symbolURI" as="xs:string*"/>

        <xsl:for-each select="$symbolURI">
          <xsl:variable name="symbolID" select="substring-after(.,'#')" as="xs:string"/>
          <xsl:variable name="documentURI" select="substring-before(.,'#')" as="xs:string"/>
          <xsl:sequence select="key('svgID',$symbolID,document($documentURI))/svg:metadata/*:bbox"/>
        </xsl:for-each>
      </xsl:function>
      
      <xsl:template match="/" mode="svg-with-bounding-boxes">
        <xsl:variable name="musxWithBoundingBoxes">
          <xsl:apply-templates select="." mode="add-bounding-boxes"/>
        </xsl:variable>
        <xsl:apply-templates select="$musxWithBoundingBoxes/musx:musx"/>
      </xsl:template>
      
    </xsl:stylesheet>
    
  </template>
  
  <!-- Add functions and templates that are used to access properties (in "g:x(.)" style) -->
  <template name="add-getter-functions-and-templates">
    <param name="properties" as="node()*"/>
    
    <for-each-group select="$properties" group-by="@name">
      <!-- Require that all properties of the same name must be of the same type
           as the getter functions can't distinguish between different contexts. -->
      <if test="count(distinct-values(current-group()/local-name())) &gt; 1">
        <message terminate="yes">
          ERROR: Property name "<value-of select="@name"/>" must be used for one property type consistently.
          Usage in the following elements:
          <for-each select="current-group()">
            on element <value-of select="ancestor::def:element/@name"/> used as type <value-of select="local-name()"/>
          </for-each>
        </message>
      </if>
      
      <xsl:function name="g:{@name}">
        <apply-templates select="." mode="add-as-type-attribute"/>
        <xsl:param name="elements" as="node()*"/>
        <xsl:variable name="result">
          <apply-templates select="." mode="add-as-type-attribute"/>
          <xsl:apply-templates select="$elements" mode="get_{@name}"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
          </xsl:when>
          <xsl:otherwise>
            <apply-templates select="." mode="generic-default"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:function>
    </for-each-group>
    
    <!-- Create getter templates for all properties.
         Group properties that have the same type (=local-name()), @name, @anchor and @lacuna
         to avoid duplicating identical templates that only differ in their match pattern.
    -->
    <for-each-group select="$properties" group-by="concat(local-name(),'$',@name,'$',@anchor,'$',@lacuna)">
      <variable name="elementNames" select="current-group()/ancestor::def:element/@name" as="xs:string*"/>
      <apply-templates select="current-group()[1]" mode="create-getter-templates">
        <with-param name="elementNames" select="$elementNames" as="xs:string*"/>
      </apply-templates>
    </for-each-group>
    
  </template>

  <template match="def:draw">
    <variable name="elementName" select="ancestor::def:element/@name"/>
    <xsl:template match="{g:musxPrefix()}{$elementName}" mode="draw">
      <svg:g>
        <apply-templates select="@svg:*" mode="copy-svg-attributes"/>
        <xsl:attribute name="class">
          <xsl:value-of select="normalize-space(concat('{$elementName} ',@class))"/>
        </xsl:attribute>
        <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
        <copy-of select="*"/>
        <xsl:apply-templates mode="draw"/>
      </svg:g>
    </xsl:template>
  </template>
  
  <template match="def:OwnBoundingBox">
    <xsl:template match="musx:{parent::def:element/@name}" mode="get_OwnBoundingBox" priority="1">
      <copy-of select="*"/>
    </xsl:template>
  </template>
  
  <template match="@svg:*" mode="copy-svg-attributes">
    <attribute name="{local-name()}">
      <value-of select="."/>
    </attribute>
  </template>
  
</stylesheet>