<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:svg="http://www.w3.org/2000/svg" xmlns="NS:MUSX" xmlns:synch="NS:SYNCH" version="2.0">
  
  <xsl:template mode="mei2musx" match="mei:note">
    <note>
      <xsl:apply-templates select="." mode="copy-id"/>
      <xsl:apply-templates select="." mode="add-y-attribute"/>
      <xsl:apply-templates mode="mei2musx" select="@synch:id|*"/>
      <!-- If neither this note nor an ancestor has an @dur, throw root element into the select
           to have something to match the template for the fallback notehead -->
      <xsl:apply-templates select="(ancestor-or-self::mei:*[@dur]|/mei:*)[last()]" mode="add-head"/>
      <xsl:apply-templates select="self::*[not(parent::mei:chord)]" mode="add-stem"/>
      <xsl:apply-templates mode="mei2musx" select="@accid|@artic|@dots"/>
    </note>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:accid">
    <accidental symbol="accidental.{@accid}"/>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="@artic">
    <articulation symbol="articulation.{string()}"/>
  </xsl:template>
  <xsl:template mode="mei2musx" match="mei:artic">
    <xsl:apply-templates mode="mei2musx" select="@artic"/>
  </xsl:template>
  
  <xsl:template match="mei:note" mode="add-y-attribute">
    <xsl:variable name="staffN" select="ancestor::mei:staff/@n"/>
    <xsl:variable name="numericClefPitch">
      <!-- Find the staffdef/scoredef/clefchange element that provides the clef currently "in action" -->
      <!-- TODO: in preprocessing, convert all clef attributes to elements to make matching easier and "safer"? -->
    	<xsl:apply-templates mode="get-numeric-clef-pitch" select="       (       preceding::mei:*[self::mei:clef or @clef.shape]       [ancestor-or-self::mei:*[@n = $staffN and (self::mei:staff or self::mei:staffDef)]]       )[last()]"/>
    	<!--<xsl:apply-templates mode="get-numeric-clef-pitch" select="
    		(
    		ancestor-or-self::mei:*/
    		preceding-sibling::mei:*/
    		descendant-or-self::mei:*[self::mei:clef or @clef.shape]
    		[ancestor-or-self::mei:*[@n = $staffN and (self::mei:staff or self::mei:staffDef)]]
    		)[last()]"/>-->
    </xsl:variable>
    <xsl:variable name="oct" select="(preceding-sibling::mei:note/@oct|@oct)[last()]"/>
    <xsl:variable name="pname" select="(preceding-sibling::mei:note/@pname|@pname)[last()]"/>
    <xsl:attribute name="y">
      <!-- string-length(substring-before('cdefgab',$pname)) returns 0 for $pname='c', 1 for 'd' etc. -->
      <xsl:value-of select="concat(           'S',           -(7*$oct + string-length(substring-before('cdefgab',$pname)) - $numericClefPitch - 8))"/>
         <!-- TODO: template mode get-numeric-clef-pitch returns a numeric pitch value for the bottommost
                    staff line, but we calculate from the top one (therefore "- 8" in the above calculation) -->
    </xsl:attribute>
  </xsl:template>
  <!--<xsl:template match="mei:note[not(@pname or preceding-sibling::mei:note/@pname) or not(@oct or preceding-sibling::mei:note/@oct)]" mode="add-y-attribute">
    <xsl:message terminate="no">
      WARNING: @oct and @pname required on note <xsl:value-of select="@xml:id"/>
    </xsl:message>
  </xsl:template>-->
  
  <!-- "numeric clef pitch" is the numeric pitch value of the bottommost staff line. -->
  <xsl:template mode="get-numeric-clef-pitch" match="mei:*[@line or @clef.line]">
    <xsl:variable name="rawNumericClefPitch">
      <xsl:apply-templates mode="get-raw-numeric-clef-pitch" select="(@clef.shape|@shape)[last()]"/>
    </xsl:variable>
    <!-- TODO: Implement octaveDisplacement; what does the syntax say?
    <xsl:variable name="octaveDisplacement">
      <xsl:apply-templates mode="get-octave-displacemenet"
          select="(@clef.dis|mei:clef/@dis|.)[last()]"/>
    </xsl:variable>-->
    <!-- TODO: in preprocessing, convert all clef attributes to elements to make handling easier? -->
    <xsl:value-of select="$rawNumericClefPitch - 2*((@clef.line|@line) - 1)"/>
  </xsl:template>
  
  <xsl:template mode="get-numeric-clef-pitch" match="mei:*" priority="-1">
    <xsl:message terminate="yes">
      ERROR: @clef.line required on <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> with set @clef.shape attribute
    </xsl:message>
  </xsl:template>
  
  <!-- "numeric clef pitch" is the numeric pitch of the clef's reference 
       note - the offset resulting from the line it sits on, e.g. g4 for the g clef,
       f3 for the f clef.  c0 has the numerical value 0, c1 7 etc. -->
  <xsl:template mode="get-raw-numeric-clef-pitch" match="@*[string()='G']">
    <xsl:value-of select="32"/>
  </xsl:template>
  <xsl:template mode="get-raw-numeric-clef-pitch" match="@*[string()='GG']">
    <xsl:value-of select="25"/>
  </xsl:template>
  <xsl:template mode="get-raw-numeric-clef-pitch" match="@*[string()='F']">
    <xsl:value-of select="24"/>
  </xsl:template>
  <xsl:template mode="get-raw-numeric-clef-pitch" match="@*[string()='C']">
    <xsl:value-of select="28"/>
  </xsl:template>
  <xsl:template mode="get-raw-numeric-clef-pitch" match="@*" priority="-1">
    <xsl:message terminate="yes">
      ERROR: Unsupported attribute @<xsl:value-of select="local-name()"/>="<xsl:value-of select="string()"/>" on <xsl:value-of select="local-name(parent::*)"/> element <xsl:value-of select="../@xml:id"/>
    </xsl:message>
  </xsl:template>
  
  <!-- TODO: Noteheads for mensural @dur attributes (currently quarter is fallback for everything) -->
  <xsl:template match="mei:*[@dur='1']" mode="add-head" priority="1">
    <head symbol="notehead.whole"/>
  </xsl:template>
  <xsl:template match="mei:*[@dur='2']" mode="add-head" priority="1">
    <head symbol="notehead.half"/>
  </xsl:template>
  <!-- Notehead for all other durations and as fallback if there's no @dur-->
  <xsl:template match="mei:*" mode="add-head">
    <head symbol="notehead.quarter"/>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:chord">
    <chord>
      <xsl:apply-templates mode="mei2musx" select="@synch:id|*"/>
      <xsl:apply-templates select="." mode="add-stem"/>
    </chord>
  </xsl:template>
  
  <xsl:template match="mei:note|mei:chord" mode="add-stem">
    <stem>
      <xsl:apply-templates select="." mode="add-beam-attributes"/>
      <xsl:apply-templates select="@stem.dir" mode="add-direction"/>
      <xsl:apply-templates select="." mode="add-flags"/>
    </stem>
  </xsl:template>
  <!-- Prevent stems on whole notes
       TODO: Implement handling for non-numeric @dur values. -->
  <xsl:template match="mei:*[self::mei:note/@dur='1' or self::mei:chord/descendant-or-self::mei:*/@dur='1']" mode="add-stem"/>
	<xsl:template match="@stem.dir" mode="add-direction">
		<xsl:attribute name="direction">
			<xsl:value-of select="if (.='up') then -1 else 1"/>
		</xsl:attribute>
	</xsl:template>
  
  <xsl:template match="mei:*[ancestor::mei:beam or ancestor::mei:fTrem]" mode="add-flags" priority="1"/>
  <!-- This is easier and maybe faster than recursively counting how many times one has to divide by two 
       until the value is 4. (This approach is taken in beam.xsl where the number of beams is calculated
       based on a parameter, not by matching a dur attribute) -->
  <xsl:template match="mei:*[@dur='8']" mode="add-flags">
    <flags number="1"/>
  </xsl:template>
  <xsl:template match="mei:*[@dur='16']" mode="add-flags">
    <flags number="2"/>
  </xsl:template>
  <xsl:template match="mei:*[@dur='32']" mode="add-flags">
    <flags number="3"/>
  </xsl:template>
  <xsl:template match="mei:*[@dur='64']" mode="add-flags">
    <flags number="4"/>
  </xsl:template>
  <xsl:template match="mei:*[@dur='128']" mode="add-flags">
    <flags number="5"/>
  </xsl:template>
  <xsl:template match="mei:*" mode="add-flags" priority="-1"/>
  
  <!-- TODO: Recognize beamspans -->
  <xsl:template match="mei:*[ancestor::mei:beam or ancestor::mei:fTrem]" mode="add-beam-attributes">
    <xsl:attribute name="beam">
      <xsl:value-of select="(ancestor::mei:beam|ancestor::mei:fTrem)/@xml:id"/>
    </xsl:attribute>
    <xsl:attribute name="xml:id">
      <xsl:value-of select="concat(@xml:id,'_stem')"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="mei:*" mode="add-beam-attributes" priority="-1"/>
  
  <xsl:template mode="mei2musx" match="mei:rest">
    <!-- TODO: Position rest according to layer/voice -->
    <rest symbol="rest.{@dur}" y="S4">
      <xsl:apply-templates select="." mode="copy-id"/>
      <xsl:apply-templates mode="mei2musx" select="@synch:id|*"/>
    </rest>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:mRest">
    <rest symbol="rest.1" y="S4">
      <xsl:apply-templates select="." mode="copy-id"/>
      <xsl:apply-templates mode="mei2musx" select="@synch:id|*"/>
    </rest>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="@dots">
    <dots number="{string()}"/>
  </xsl:template>

</xsl:stylesheet>
