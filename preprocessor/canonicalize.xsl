<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:mei="http://www.music-encoding.org/ns/mei"
    xmlns:svg="http://www.w3.org/2000/svg">
  
  <!-- TODO: This is by far not complete 
    Missing conversions:
    - keysig (below are basics)
    - clef
    - ...
    
    Add @dur to mei:ftrem|mei:btrem|mei:space|mei:halfmRpt|mei:mRest|mei:mSpace
    !!! @dur on ftrem/btrem is not conformant with the specs, but useful !!!
  -->
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="mei:note">
    <mei:note>
      <xsl:copy-of select="(@dur|ancestor::mei:chord/@dur|preceding-sibling::mei:note/@dur)[last()]"/>
      <xsl:copy-of select="(@oct|preceding-sibling::mei:note/@oct)[last()]"/>
      <xsl:copy-of select="(@pname|preceding-sibling::mei:note/@pname)[last()]"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
      <xsl:apply-templates/>
    </mei:note>
  </xsl:template>
  
  <!-- Have @dur on all notes and chords -->
  <xsl:template match="mei:chord">
    <mei:chord>
      <xsl:apply-templates select="@*"/>
      <xsl:copy-of select="(@dur|descendant::mei:note/@dur)[1]"/>
      <xsl:apply-templates/>
    </mei:chord>
  </xsl:template>
  
  <xsl:template match="mei:note/@artic"/>
  <xsl:template match="mei:note/@artic" mode="turn-attributes-into-element">
    <mei:artic artic="{string()}"/>
  </xsl:template>
  
  <xsl:template match="@key.sig"/>
  <xsl:template match="@key.sig" mode="turn-attributes-into-element">
    <!-- @key.sig is of the form "mixed|0|[1-7][f|s]" -->
    <mei:keySig n="{substring(string(),1,1)}" accid="{substring(string(),2,1)}"/>
    <!-- TODO:
         - Handle case "mixed"
         - Handle [@key.accid], @key.mode, @key.pname, @key.sig.mixed, @key.sig.show, @key.sig.showchange
    -->
  </xsl:template>
	
	<xsl:template match="@accid"/>
	<xsl:template match="@accid" mode="turn-attributes-into-element">
		<mei:accid accid="{.}"/>
	</xsl:template>
  
  <xsl:template match="@*" mode="turn-attributes-into-element"/>

</xsl:stylesheet>