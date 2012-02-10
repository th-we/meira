<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:mei="http://www.music-encoding.org/ns/mei"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:synch="NS:SYNCH"
    xmlns="NS:MUSX"
    xmlns:xlink="http://www.w3.org/1999/xlink">
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
  
 
  <xsl:template match="/mei:mei">
    <musx>
      <musxHead>
        <symbols xlink:href="symbols/symbols.svg"/>
      </musxHead>
      <eventList>
        <!-- Add a special event that we use for attaching the clef, key and time signatures to -->
        <event xml:id="_t0" x="0"/>
        <!--<xsl:apply-templates select="//mei:scoreDef[1]/mei:timeline[last()]/mei:when" mode="add-events"/>-->
                                                          <!-- Only match one element with this synch value (first one returned by key('synchValue'..)) -->
        <xsl:for-each-group select="//mei:*[@synch:*]" group-by="@synch:rounded">
          <!-- Question: Is "number()" required here? -->
          <xsl:sort select="number(@synch:rounded)"/>
          <xsl:message>IN!!</xsl:message>
          <xsl:call-template name="write-event"/>
        </xsl:for-each-group>
        <!-- Add event for last barline -->
        <xsl:for-each select="//mei:measure[last()]">
          <xsl:call-template name="write-event">
            <xsl:with-param name="id" select="@synch:end.id"/>
            <xsl:with-param name="synch:rounded" select="@synch:end.rounded"/>
          </xsl:call-template>
        </xsl:for-each>
      </eventList>
      <xsl:apply-templates select="//mei:scoreDef[1]"/>
    </musx>
  </xsl:template>
  
  <xsl:template name="write-event">
    <xsl:param name="id" select="@synch:id[1]"/>
    <xsl:param name="synch:rounded" select="@synch:rounded[1]"/>
    <!-- This is *VERY BAD* proportional spacing, just to have some spacing info. 
      TODO: Implement separate, elaborate spacing algorithm. -->
    <event x="{200 * $synch:rounded}">
      <xsl:attribute name="xml:id">
        <xsl:value-of select="$id"/>
      </xsl:attribute>
    </event>
  </xsl:template>
  
<!-- Superceded by new @synch* attributes
  <xsl:template match="mei:when" mode="add-events">
    <event>
      <xsl:attribute name="x">
        <xsl:value-of select="'p'"/>
        <xsl:apply-templates select="." mode="get-event-position"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="copy-id"/>
    </event>
  </xsl:template>-->
  
  <!-- Superceded by new @synch* attributes
    <xsl:template match="mei:when" mode="get-event-position">
    <xsl:variable name="floatTimestamp" select="substring-before(@absolute,'/') div substring-after(@absolute,'/')"/>
    <!-\- Calculate the x position of an event using the parameters supplied to this stylesheet -\->
    <xsl:value-of select="
    $spacePerQuarter * (
    $equidistantProportionalBalance * count(preceding-sibling::mei:when)
    + (1 - $equidistantProportionalBalance) * $floatTimestamp * 4
    ) 
    + $barlineSpace * count((preceding-sibling::mei:when|self::mei:when)[@data])
    + $clefSpace + $keysignatureSpace + $timesignatureSpace
    "/>
    </xsl:template>-->
  
  <xsl:template match="*" mode="copy-id">
    <xsl:attribute name="xml:id">
      <!-- Hopefully this satisfies all XSLT processors -->
      <xsl:value-of select="attribute::*[local-name()='xml:id']|@xml:id"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@synch:id">
    <xsl:attribute name="start">
      <xsl:value-of select="string()"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="mei:scoreDef">
    <page y2="{(count(//mei:staffDef[not(contains($excludeStaffsList,concat(' ',@n,' ')))]) + 2) * $staffDistance}">
      <xsl:attribute name="x2">
        <!-- TODO: Adapt this for the new approach without mei:timeline and with @synch*
        <xsl:variable name="printAreaWidth"> 
          <xsl:apply-templates select="mei:timeline/mei:when[last()]" mode="get-event-position"/>
        </xsl:variable>
        <xsl:value-of select="$printAreaWidth + 2 * $margin"/> -->
        <xsl:value-of select="//mei:measure[last()]/@synch:end.rounded * $spacePerQuarter + 2 * $margin"/>
      </xsl:attribute>
      <!-- Currently, everything is put into a single line of music, i.e no system breaks. -->
      <!-- Firefox doesn't support accessing @xml:id, for some reason, therefore the strange workaround -->
      <system start="_t0" end="{//mei:measure[last()]/@synch:end.id}" 
          size="{$size}"  svg:transform="translate({$margin},{$margin})">
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
            ) 
            + 1)}"
          start="_t0">  
      <!-- Display staff label -->
      <svg y="S6" x="s-2">
        <svg:text font-size="4" text-anchor="end">
          <xsl:value-of select="@n"/>
        </svg:text>
      </svg>
      <!-- TODO: more general templates for clef and keysignature generation, not only at the start of a piece 
                 Use those templates instead of explicitly adding them here -->
      <clef symbol="clef.{(@clef.shape|mei:clef/@shape)[last()]}" 
            y="L{(@clef.line|mei:clef/@line)[last()]}"
            x="s{1}"/>
      <!-- TODO: Add a preprocessing step that converts @key.sig into <keysig>.  This avoids complicated 
           XPath constructions that try to take into account both the attribute and child element variants. -->
      <keySignature symbol="accidental.{
                              substring(
                                concat(mei:keySig/@accid,
                                       substring(@key.sig,2))
                               ,1,1)}"
                    y="L{(@clef.line|mei:clef/@line)[last()]}"
                    x="p{$clefSpace}">
                    <!-- $clefSpace tells us how much space the preceding clef takes up -->
        <xsl:attribute name="pattern">
          <xsl:apply-templates mode="get-keysignature-pattern" select="."/>
        </xsl:attribute>
      </keySignature>
      <timeSignature x="p{$clefSpace + $keysignatureSpace}">
        <!-- Look for meter definition, either in this very element or a preceding scoredef -->
        <xsl:apply-templates select="(ancestor-or-self::mei:*[@*[starts-with(local-name(),'meter.')]])[last()]" 
            mode="add-timesignature-symbols"/>
      </timeSignature>
      <!-- Add all content from all <staff> elements with corresponding @n -->
      <xsl:apply-templates select="key('staff',@n)"/>
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
  
  <xsl:template mode="get-keysignature-pattern" match="mei:staffDef">
    <!-- Extract pattern from table
        - first with substring-after get the section that follows "s" for sharps and "f" for flats 
        - then, again with substring-after get section that belongs to the current clef (G, C or F; GG has same pattern as G
        - then with substring get the first $n 4-char "table cells" which represent the pattern -->
    <xsl:value-of select="
        substring(
          substring-after(
            substring-after(
              's G-6  -3  -7  -4  -1  -5  -2  
                 C-3   0  -4  -1   2  -2   1
                 F 0   3  -1   2   5   1   4
               f G-2  -5  -1  -4   0  -3   1  
                 C 1  -2   2  -1   3   0   4
                 F 4   1   5   2   6   3   7',
              mei:keySig/@accid
            ),
            substring((@clef.shape|mei:clef/@shape)[last()],1,1)
         ), 1, mei:keySig/@n*4)"/>
    <!-- TODO: Handle more complex ("mixed") patterns -->
  </xsl:template>
  
  <xsl:template match="mei:staff">
    <group class="measure">
      <!-- Display measure number -->
      <svg y="S-2" x="p{-1 * $barlineSpace}">
        <xsl:apply-templates select="ancestor-or-self::*/@synch:id"/>
        <svg:text font-size="3"  text-anchor="end">
          <xsl:value-of select="ancestor::mei:measure/@n"/>
        </svg:text>
      </svg>
      <xsl:apply-templates/>
      <barline x="p{-.85 * $barlineSpace}" 
          start="{ancestor::mei:measure/@synch:end.id}"/>
    </group>
  </xsl:template>
  
  <!-- This groups elements so that they can be styled (e.g. hidden) or manipulated with Javascript as a whole. -->
  <xsl:template match="mei:rdg|mei:del|mei:lem|mei:orig|mei:reg|mei:app">
    <!-- TODO: In order to avoid class naming clashes, find a sensible method of prefixing or somehow else
         modifying the names of sources, hands and the name of the editorial/analysis element --> 
    <group class="{local-name()} {@source} {@hand}">
      <xsl:apply-templates/>
    </group>
  </xsl:template>
 </xsl:stylesheet>
