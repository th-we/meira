<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:def="NS:DEF"
  xmlns:g="NS:GET"
  xmlns:musx="NS:MUSX"
  xmlns:xsb="http://www.expedimentum.org/XSLT/SB"
  exclude-result-prefixes="xsl">
	
	<!-- QUESTION: Use xpath-default-namespaee="NS:MUSX"? -->
  
  <xsl:import href="propertyTypes/propertyTypesLoader.xsl"/>
  <xsl:import href="shared/matchingHelper.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="" result-prefix="xsl"/>
  <xsl:output indent="yes"/>
  
  <!-- TODO: In elementDefinitions, avoid requiring the musx: prefix in XPath expressions.
             This can be achieved by making musx the default namespace -->
  
  <!-- All content with xsl: prefix is written as output -->
  
  <xsl:template match="/def:elementDefinition/def:element[@name='musx']">
    <stylesheet version="2.0" exclude-result-prefixes="xs def g musx svg">
      <!--<output indent="yes"/>-->

    	<!-- The libDirectory can be specified in the musx file (/musx/musxHead/libDirectory/@xlink:href).
    		   If we're calling this from a wrapper XSLT, then there is no such
    		
    		If we're calling this from a wrapper XSLT, then the root node isn't <musx> but <mei>. 
           The wrapper XSLT can provide required to -->
      <import href="math/math.xsl"/>
      
      <param name="libDirectory" select="if (/musx:musx) then /musx:musx/musx:musxHead/musx:libDirectory/@xlink:href else 'lib'" as="xs:string"/>
    	<param name="musicFont" select="'musicSymbols'" as="xs:string"/>
    	<param name="symbolFile" select="'symbols.svg'" as="xs:string"/>
      
      <key name="class" match="*" use="tokenize(@class,'\s+')"/>
      <key name="elements-by-staff-and-event" match="*">
        <variable name="startEvent">
          <apply-templates mode="get-start-event" select="."/>
        </variable>
        <variable name="staff" select="ancestor::musx:staff[1]"/>
        <value-of select="concat($staff/generate-id(),'$',$startEvent/generate-id())"/>
      </key>
      <template mode="get-start-event" match="*">
        <apply-templates select="g:start(.)" mode="get-start-event"/>
      </template>
      <template mode="get-start-event" match="musx:event">
        <sequence select="."/>
      </template>
      
      <xsl:call-template name="add-getter-functions-and-templates">
        <xsl:with-param name="properties" as="element()*">
          <xsl:for-each select="def:includeDefinition">
            <xsl:sequence select="document(@href)/def:elementDefinition/def:element/def:properties/def:*"/>
          </xsl:for-each>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:for-each select="def:includeDefinition">
        <xsl:variable name="element" select="document(@href)/def:elementDefinition/def:element" as="element()*"/>
        <!-- TODO: Currently, there is no guaranty that templates, function etc. with identical names are
                   supplied by different element definitions. Work out naming scheme or check mechanism so
                   that we prevent clashes when copying everything! -->
        <xsl:copy-of select="$element/xsl:*"/>
        <xsl:apply-templates select="$element/def:OwnBoundingBox"/>
        <xsl:apply-templates select="$element/def:draw"/>
      </xsl:for-each>

      <!-- Templates that are common for all draw templates -->
      <template match="@xml:id" mode="copy-svg-and-id-attributes">
        <attribute name="id">
          <value-of select="."/>
        </attribute>
      </template>
      <template match="@svg:*" mode="copy-svg-and-id-attributes">
        <attribute name="{'{'}local-name(){'}'}">
          <value-of select="."/>
        </attribute>
      </template>
      <template match="@*" mode="copy-svg-and-id-attributes"/>
      
      <!-- Default draw template: Ignore unknown content -->
      <template match="*" mode="draw" priority="-5"/>
      
      <!-- Templates that transform <musx:musxHead> to <svg:defs> -->
      <template match="musx:musxHead" mode="generate-defs">
        <svg:defs>
          <apply-templates mode="generate-defs"/>
        </svg:defs>
      </template>
      <template match="*" mode="generate-defs" priority="-1"/>
      <template match="svg:*" mode="generate-defs">
        <copy-of select="."/>
      </template>
      
      
      <template match="/" priority="-10">
      	<apply-templates select="." mode="musx2svg"/>
      </template>
      
      <!-- Main template for converting to SVG -->
      <template match="/musx:musx" mode="musx2svg">
        <svg:svg width="{{g:x2(//musx:page[1])}}" height="{{g:y2(//musx:page[1])}}">
          <apply-templates select="musx:musxHead[*]" mode="generate-defs"/>
          <apply-templates mode="draw"/>
        </svg:svg>
      </template>
      
      <!-- Templates for adding bounding box dimension info to the musx data.
           To use these templates, add-bounding-boxes has to be set as the initial mode 
           (e.g. using the switch -im:add-bounding-boxes with saxonb-xslt) -->
      <template match="@*|node()" mode="add-bounding-boxes">
        <copy>
          <apply-templates mode="add-bounding-boxes" select="@*|node()"/>
        </copy>
      </template>
      
      <template match="musx:*" mode="add-bounding-boxes" priority="1">
        <variable name="children" as="node()*">
          <apply-templates mode="add-bounding-boxes" select="node()"/>
        </variable>
        <variable name="allBoundingBoxes" as="element()*">
          <sequence select="$children/musx:BoundingBox"/>
          <apply-templates mode="get_OwnBoundingBox" select="."/>
        </variable>
        <copy>
          <copy-of select="@*"/>
          <copy-of select="$children"/>
          <if test="$allBoundingBoxes">
            <musx:BoundingBox 
              left="{{min($allBoundingBoxes//@left)}}"
              right="{{max($allBoundingBoxes//@right)}}"
              top="{{min($allBoundingBoxes//@top)}}"
              bottom="{{max($allBoundingBoxes//@bottom)}}"/>
          </if>
        </copy>
      </template>
      
      <!-- Functions/Templates to get bounding box information for a musx element
           "Own"BoundingBox means only the bounding box of this element, not its children.
           E.g., the <staff>'s OwnBoundingBox are the dimensions of the staff lines, not the
           dimensions of all elements inside the staff. -->
      <template match="node()|@*" mode="get_OwnBoundingBox" priority="-2"/>
      <function name="g:OwnBoundingBox" as="element()*">
        <param name="element" as="element()*"/>
        <apply-templates select="$element" mode="get_OwnBoundingBox"/>
      </function>
      
      <function name="g:staffSize" as="xs:double*">
        <param name="element" as="element()*"/>
        <sequence select="g:size($element/ancestor::musx:staff[last()])"/>
      </function>
      
      <!-- We require every symbol in the symbols.svg file to have a <bbox> element inside a <metadata> element.
           This is the function to access the <bbox> element. -->
      <key name="svgID" match="svg:*[@id]" use="@id"/>
      <function name="g:svgSymbolBoundingBox" as="element()*">
        <param name="symbolURI" as="xs:string*"/>

        <for-each select="$symbolURI">
          <variable name="symbolID" select="substring-after(.,'#')" as="xs:string"/>
          <variable name="documentURI" select="substring-before(.,'#')" as="xs:string"/>
          <sequence select="key('svgID',$symbolID,document($documentURI))/svg:metadata/*:bbox"/>
        </for-each>
      </function>
      
      <!-- Template for adding visualized bounding boxes to the SVG output.
        To use this template, svg-with-bounding-boxes has to be set as the initial mode 
        (e.g. using the switch -im:svg-with-bounding-boxes with saxonb-xslt) -->
      <template match="/" mode="svg-with-bounding-boxes">
        <variable name="musxWithBoundingBoxes">
          <apply-templates select="." mode="add-bounding-boxes"/>
        </variable>
        <apply-templates select="$musxWithBoundingBoxes/musx:musx" mode="musx2svg"/>
      </template>
      
    </stylesheet>
    
  </xsl:template>
  
  <!-- Add functions and templates that are used to access properties (in "g:x(.)" style) -->
  <xsl:template name="add-getter-functions-and-templates">
    <xsl:param name="properties" as="element()*"/>
    
    <xsl:for-each-group select="$properties" group-by="@name">
      <!-- Require that all properties of the same name must be of the same type
           as the getter functions can't distinguish between different contexts. -->
      <xsl:if test="count(distinct-values(current-group()/local-name())) &gt; 1">
        <xsl:message terminate="yes">
          ERROR: Property name "<xsl:value-of select="@name"/>" must be used for one property type consistently.
          Usage in the following elements:
          <xsl:for-each select="current-group()">
            on element <xsl:value-of select="ancestor::def:element/@name"/> used as type <xsl:value-of select="local-name()"/>
          </xsl:for-each>
        </xsl:message>
      </xsl:if>
      
      <function name="g:{@name}">
        <xsl:apply-templates select="." mode="add-as-type-attribute"/>
        <param name="elements" as="element()*"/>
        <variable name="result">
          <xsl:apply-templates select="." mode="add-as-type-attribute"/>
          <apply-templates select="$elements" mode="get_{@name}"/>
        </variable>
        <choose>
          <when test="count($result) != 0">
            <sequence select="$result"/>
          </when>
          <otherwise>
            <xsl:apply-templates select="." mode="generic-default"/>
          </otherwise>
        </choose>
      </function>
    </xsl:for-each-group>
    
    <!-- Create getter templates for all properties.
         Group properties that have the same type (=local-name()), @name, @anchor and @lacuna
         to avoid duplicating identical templates that only differ in their match pattern.
    -->
    <xsl:for-each-group select="$properties" group-by="concat(local-name(),'$',@name,'$',@anchor,'$',@lacuna)">
      <xsl:variable name="elementNames" select="current-group()/ancestor::def:element/@name" as="xs:string*"/>
      <xsl:apply-templates select="current-group()[1]" mode="create-getter-templates">
        <xsl:with-param name="elementNames" select="$elementNames" as="xs:string*"/>
      </xsl:apply-templates>
    </xsl:for-each-group>
    
  </xsl:template>

  <xsl:template match="def:draw">
    <xsl:variable name="elementName" select="ancestor::def:element/@name"/>
    <template match="{g:musxPrefix()}{$elementName}" mode="draw">
      <svg:g class="{{normalize-space(concat('{$elementName} ',@class))}}">
        <!-- Copy SVG attributes from the draw definition -->
        <xsl:apply-templates select="@svg:*" mode="copy-svg-attributes"/>
        <!-- Copy SVG attributes from the musx element -->
        <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
        <xsl:copy-of select="*"/>
        <apply-templates mode="draw"/>
      </svg:g>
    </template>
  </xsl:template>
  
  <xsl:template match="def:OwnBoundingBox">
    <template match="musx:{parent::def:element/@name}" mode="get_OwnBoundingBox" priority="1">
      <xsl:copy-of select="*"/>
    </template>
  </xsl:template>
  
  <xsl:template match="@svg:*" mode="copy-svg-attributes">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
</xsl:stylesheet>