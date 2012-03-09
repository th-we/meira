<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:svg="http://www.w3.org/2000/svg" version="1.0">
  
  <!-- TODO: This is by far not complete 
    Missing conversions:
    - keysig (below are basics)
    - clef
    - ...
    
    Add @dur to mei:ftrem|mei:btrem|mei:space|mei:halfmRpt|mei:mRest|mei:mSpace
    !!! @dur on ftrem/btrem is not conformant with the specs, but useful !!!
  -->
  
  <xsl:template mode="canonicalize" match="*">
    <xsl:copy>
      <xsl:apply-templates mode="canonicalize" select="@*"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
      <xsl:apply-templates mode="canonicalize" select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="canonicalize" match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template mode="canonicalize" match="mei:note">
    <mei:note>
      <xsl:copy-of select="(@dur|ancestor::mei:chord/@dur|preceding-sibling::mei:note/@dur)[last()]"/>
      <xsl:copy-of select="(@oct|preceding-sibling::mei:note/@oct)[last()]"/>
      <xsl:copy-of select="(@pname|preceding-sibling::mei:note/@pname)[last()]"/>
      <xsl:apply-templates mode="canonicalize" select="@*"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
      <xsl:apply-templates mode="canonicalize"/>
    </mei:note>
  </xsl:template>
  
  <!-- Have @dur on all notes and chords -->
  <xsl:template mode="canonicalize" match="mei:chord">
    <mei:chord>
    	<!-- TODO: Which attribute takes precedence, the one already existing, or the one thats written by 
    		   copy-of? -->
      <xsl:apply-templates mode="canonicalize" select="@*"/>
      <xsl:copy-of select="(@dur|descendant::mei:note/@dur)[1]"/>
      <xsl:apply-templates mode="canonicalize"/>
    </mei:chord>
  </xsl:template>
  
  <xsl:template mode="canonicalize" match="mei:note/@artic"/>
  <xsl:template match="mei:note/@artic" mode="turn-attributes-into-element">
    <mei:artic artic="{string()}"/>
  </xsl:template>
  
  <xsl:template mode="canonicalize" match="@key.sig"/>
  <xsl:template match="@key.sig[. != '0']" mode="turn-attributes-into-element">
    <!-- @key.sig is of the form "mixed|0|[1-7][f|s]" -->
    <mei:keySig n="{substring(string(),1,1)}" accid="{substring(string(),2,1)}"/>
    <!-- TODO:
         - Handle case "mixed"
         - Handle [@key.accid], @key.mode, @key.pname, @key.sig.mixed, @key.sig.show, @key.sig.showchange
    -->
  </xsl:template>
	
	<xsl:template mode="canonicalize" match="@accid"/>
	<xsl:template match="@accid" mode="turn-attributes-into-element">
		<mei:accid accid="{.}"/>
	</xsl:template>
	
	<!-- QUESTION: Is there an attribute version of <dynam> that we need to canonicalize? -->
	
	<xsl:template match="@*" mode="turn-attributes-into-element"/>

</xsl:stylesheet>
