<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:svg="http://www.w3.org/2000/svg" xmlns:synch="NS:SYNCH" xmlns="NS:MUSX" xmlns:xlink="http://www.w3.org/1999/xlink" version="2.0">
  <xsl:include href="beams.xsl"/>
  <xsl:include href="notes.xsl"/>

  <!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    This stylesheet relies on a preprocessed MEI file that has
    (among other things) IDs on all elements.
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->

  <!-- Why doesn't this work in Firefox???
  <xsl:key name="when" match="mei:when" use="@xml:id"/>-->
  <!--<xsl:key name="when" match="mei:when" use="@*[local-name()='id' or local-name()='xml:id']"/>-->
  <xsl:key name="id" match="*" use="@*[contains(local-name(),'id')]"/>
  <xsl:key name="staff" match="mei:staff" use="@n"/>
  <xsl:key name="measure" match="mei:measure" use="@n"/>
  <xsl:key name="synchValue" match="mei:*[@synch:rounded]" use="@synch:rounded"/>
  <xsl:key name="synchedElement" match="mei:*[@synch:rounded]" use="'true'"/>
  <xsl:param name="stylesheet" select="'type=&quot;text/xsl&quot; href=&quot;xsl/musx2svg.xsl&quot;'"/>
  <xsl:param name="spacePerQuarter" select="200"/>
  <xsl:param name="equidistantProportionalBalance" select=".1"/>
  <xsl:param name="staffDistance" select="70"/>
  <xsl:param name="barlineSpace" select="10"/>
  <xsl:param name="clefSpace" select="35"/>
  <xsl:param name="keysignatureSpace" select="60"/>
  <xsl:param name="timesignatureSpace" select="20"/>
  <xsl:param name="size" select="3"/>
  <xsl:param name="margin" select="30"/>
  <xsl:param name="excludeStaffsList" select="''"/>
  <xsl:param name="startMeasure" select="//mei:measure[1]/@n"/>
  <xsl:param name="endMeasure" select="//mei:measure[last()]/@n"/>
  
  
  <xsl:template match="/" priority="-10">
  	<xsl:apply-templates select="." mode="mei2musx"/>
  </xsl:template>
 
  <xsl:template mode="mei2musx" match="/mei:mei">
    <musx>
      <musxHead>
        <libDirectory xlink:href="lib"/>
      </musxHead>
    	<eventList>
    		<!-- Add a special event that we use for attaching the clef, key and time signatures to -->
    		<event xml:id="_t0" x="0" synchTime="0"/>
    		<!--<xsl:apply-templates select="//mei:scoreDef[1]/mei:timeline[last()]/mei:when" mode="add-events"/>-->
    		<!-- Only match one element with this synch value (first one returned by key('synchValue'..)) -->
    		<xsl:for-each-group select="//@synch:rounded|//@synch:end.rounded" group-by=".">
    			<xsl:sort select="number(.)"/>
    			<xsl:variable name="synchIdAttributeLocalName" select="concat(substring-before(local-name(),'rounded'),'id')"/>
    			<!-- This ("200 * .") is *VERY BAD* proportional spacing, just to have some spacing info. 
              TODO: Implement separate, elaborate spacing algorithm. -->
    			<event x="{200 * .}" synchTime="{.}">
    				<xsl:attribute name="xml:id">
    					<xsl:value-of select="../@synch:*[local-name()=$synchIdAttributeLocalName]"/>
    				</xsl:attribute>
    			</event>
    		</xsl:for-each-group>
    	</eventList>    	
      <xsl:apply-templates mode="mei2musx" select="(//mei:scoreDef)[1]"/>
    </musx>
  </xsl:template>
  
  <xsl:template match="*" mode="copy-id">
    <xsl:attribute name="xml:id">
      <!-- Hopefully this satisfies all XSLT processors -->
      <xsl:value-of select="attribute::*[local-name()='xml:id']|@xml:id"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="@synch:id">
    <xsl:attribute name="start">
      <xsl:value-of select="string()"/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- TODO: Don't repeat this for every scoreDef. It creates multiple pages that cover each other -->
  <xsl:template mode="mei2musx" match="mei:scoreDef">
    <page y2="{(count(//mei:staffDef[not(contains($excludeStaffsList,concat(' ',@n,' ')))]) + 2) * $staffDistance}" x2="p{2*$margin}" end="{//@synch:end.id[number(../@synch:end.rounded)=max(//@synch:end.rounded)]}">
      <!-- Currently, everything is put into a single line of music, i.e no system breaks. -->
      <!-- Firefox doesn't support accessing @xml:id, for some reason, therefore the strange workaround -->
      <system start="_t0" end="{(//mei:measure)[last()]/@synch:end.id}" size="{$size}" svg:transform="translate({$margin},{$margin})">
        <barline/><!-- System barline -->
        <xsl:apply-templates mode="add-staffs" select="mei:staffGrp|mei:staffDef"/>
      </system>
    </page>
  </xsl:template>
  
  <xsl:template match="mei:staffGrp" mode="add-staffs">
    <staffGroup>
      <xsl:apply-templates mode="add-staffs" select="mei:staffGrp|mei:staffDef"/>
    </staffGroup>
  </xsl:template>
  
  <xsl:template match="mei:staffDef" mode="add-staffs">
    <!-- As <staffdef>s may occur grouped in <staffgrp>s, a simple 
         count(preceding-sibling::mei:staffDef) doesn't do the job. -->
    <staff y="p{$staffDistance * (
	    	 count(
	    	   preceding-sibling::mei:staffDef|ancestor::mei:staffGrp/preceding-sibling::mei:*/descendant-or-self::mei:staffDef             
	    	 ) + 1)}" start="_t0">
      <!-- Display staff label -->
      <svg y="S6" x="s-2">
        <svg:text font-size="4" text-anchor="end">
          <xsl:value-of select="@n"/>
        </svg:text>
      </svg>
      <!-- TODO: more general templates for clef and keysignature generation, not only at the start of a piece 
                 Use those templates instead of explicitly adding them here -->
      <clef symbol="clef.{(@clef.shape|mei:clef/@shape)[last()]}" y="L{(@clef.line|mei:clef/@line)[last()]}" x="s{1}"/>
      <timeSignature x="p{$clefSpace + $keysignatureSpace}">
        <!-- Look for meter definition, either in this very element or a preceding scoredef -->
        <xsl:apply-templates select="(ancestor-or-self::mei:*[@*[starts-with(local-name(),'meter.')]])[last()]" mode="add-timesignature-symbols"/>
      </timeSignature>
      <!-- Add all content from all <staff> elements with corresponding @n -->
      <xsl:apply-templates mode="mei2musx" select="key('staff',@n)"/>
    </staff>
  </xsl:template>
  
  <xsl:template match="mei:*[@meter.sym]" mode="add-timesignature-symbols" priority="1">
    <xsl:attribute name="symbol">
      <xsl:value-of select="concat('metersymbol.',@meter.sym)"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="mei:*[@meter.count and @meter.unit]" mode="add-timesignature-symbols">
    <fraction>
      <string><xsl:value-of select="@meter.count"/></string>
      <string><xsl:value-of select="@meter.unit"/></string>
    </fraction>
  </xsl:template>
  
  <xsl:template mode="get-keysignature-pattern" match="mei:staffDef[mei:keySig]">
    <keySignature symbol="accidental.{mei:keySig/@accid}" y="L{(@clef.line|mei:clef/@line)[last()]}" x="p{$clefSpace}">
      <!-- $clefSpace tells us how much space the preceding clef takes up -->
      <xsl:attribute name="pattern">
        <!-- Extract pattern from table
          - first with substring-after get the section that follows "s" for sharps and "f" for flats 
          - then, again with substring-after get section that belongs to the current clef (G, C or F; GG has same pattern as G
          - then with substring get the first $n 4-char "table cells" which represent the pattern -->
        <xsl:value-of select="           substring(             substring-after(               substring-after(                 's G-6  -3  -7  -4  -1  -5  -2                      C-3   0  -4  -1   2  -2   1                    F 0   3  -1   2   5   1   4                  f G-2  -5  -1  -4   0  -3   1                      C 1  -2   2  -1   3   0   4                    F 4   1   5   2   6   3   7',                 mei:keySig/@accid               ),               substring((@clef.shape|mei:clef/@shape)[last()],1,1)            ), 1, mei:keySig/@n*4)"/>
         </xsl:attribute>
    </keySignature>
    <!-- TODO: Handle more complex ("mixed") patterns -->
  </xsl:template>
  <xsl:template mode="get-keysignature-pattern" match="*"/>
  
  <xsl:template mode="mei2musx" match="mei:staff">
    <group class="measure">
      <!-- Display measure number -->
      <svg y="S-2" x="p{-1 * $barlineSpace}">
        <xsl:apply-templates mode="mei2musx" select="ancestor-or-self::*/@synch:id"/>
        <svg:text font-size="3" text-anchor="end">
          <xsl:value-of select="ancestor::mei:measure/@n"/>
        </svg:text>
      </svg>
      <xsl:apply-templates mode="mei2musx"/>
      <barline x="p{-.85 * $barlineSpace}" start="{ancestor::mei:measure/@synch:end.id}"/>
    </group>
  </xsl:template>
  
  <!-- This groups elements so that they can be styled (e.g. hidden) or manipulated with Javascript as a whole. -->
  <xsl:template mode="mei2musx" match="mei:rdg|mei:del|mei:lem|mei:orig|mei:reg|mei:app">
    <!-- TODO: In order to avoid class naming clashes, find a sensible method of prefixing or somehow else
         modifying the names of sources, hands and the name of the editorial/analysis element --> 
    <group class="{local-name()} {@source} {@hand}">
      <xsl:apply-templates mode="mei2musx"/>
    </group>
  </xsl:template>
	
	<xsl:template mode="mei2musx" match="mei:hairpin">
		<!-- TODO: Proper y positioning (as well for mei:dynam, see below) -->
		<hairpin start="{@synch:id}" end="{@synch:end.id}" y="S{if(@place='above') then '-5' else '14'}">
			<xsl:variable name="opening" select="if(@opening) then @opening * 2 else 4"/>
			<xsl:attribute name="{if(@form = 'cres') then 'endSpread' else 'startSpread'}">
				<xsl:value-of select="concat('s',$opening)"/>
			</xsl:attribute>
		</hairpin>
	</xsl:template>
	
	<xsl:template mode="mei2musx" match="mei:dynam">
		<!-- TODO: Proper y positioning (as well for mei:hairpin, see above) -->
		<symbolText start="{@synch:id}" class="dynam" y="S{if(@place='above') then '-5' else '14'}">
			<xsl:apply-templates mode="mei2musx"/>
		</symbolText>
	</xsl:template>
	
</xsl:stylesheet>
