<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:svg="http://www.w3.org/2000/svg">

  <xsl:output exclude-result-prefixes="#all"/>
  <xsl:key name="tieByStartid" match="mei:tie" use="@startid"/>
  <xsl:key name="notes-by-staff-and-layer" match="mei:note" 
    use="concat(
      ancestor::mei:staff/@n[last()],
      '$',
      ancestor::mei:layer/@n[last()]
    )"/>
  
  <!-- TODO: This is by far not complete 
    Missing conversions:
    - keysig (below are basics)
    - clef
    - ...
    
    Add @dur to mei:ftrem|mei:btrem|mei:space|mei:halfmRpt|mei:mRest|mei:mSpace
    !!! @dur on ftrem/btrem is not conformant with the specs, but useful !!!
  -->
  
  <xsl:template match="/" priority="-10">
    <xsl:apply-templates select="." mode="canonicalize"/>
  </xsl:template>
  
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

  <xsl:template match="mei:staffDef|mei:scoreDef" mode="canonicalize">
    <xsl:variable name="clefAttributes" select="(@clef.shape,@clef.line,@clef.dis,@clef.dis.place)"/>
    <xsl:copy>
      <xsl:apply-templates mode="canonicalize" select="@* except $clefAttributes"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
      <xsl:if test="$clefAttributes">
        <mei:clef>
          <xsl:for-each select="$clefAttributes">
            <xsl:attribute name="{substring-after(local-name(),'clef.')}">
              <xsl:value-of select="."/>
            </xsl:attribute>
          </xsl:for-each>
        </mei:clef>
      </xsl:if>
      <xsl:apply-templates mode="canonicalize"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="canonicalize" match="mei:note">
    <mei:note>
      <!-- TODO: Check that the canonicalized note has @dur, @oct and @pname. Otherwise we'll fail later
                 Do this here or in a separate step (Schematron?) -->
      <xsl:copy-of select="(@dur|ancestor::mei:chord/@dur|preceding-sibling::mei:note/@dur)[last()]"/>
      <xsl:copy-of select="(@dots|ancestor::mei:chord/@dots)[last()]"/>
      <xsl:copy-of select="(@oct|preceding-sibling::mei:note/@oct)[last()]"/>
      <xsl:copy-of select="(@pname|preceding-sibling::mei:note/@pname)[last()]"/>
      <xsl:apply-templates mode="canonicalize" select="@*"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
      <xsl:apply-templates mode="canonicalize"/>
    </mei:note>
    <xsl:apply-templates select="@tie[string()='i']" mode="turn-attributes-into-element"/>
  </xsl:template>

  <!-- Have @dur on all notes and chords -->
  <xsl:template mode="canonicalize" match="mei:chord">
    <mei:chord>
      <!-- TODO: Which attribute takes precedence, the one already existing, or the one thats written by 
    		   copy-of? -->
      <xsl:apply-templates mode="canonicalize" select="@*"/>
      <xsl:copy-of select="(@dur|descendant::mei:note/@dur)[1]"/>
      <xsl:apply-templates select="@*" mode="turn-attributes-into-element"/>
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

  <xsl:template mode="canonicalize" match="@accid">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="mei:note/@accid" mode="turn-attributes-into-element">
    <mei:accid accid="{string()}"/>
  </xsl:template>
  
  <xsl:template mode="canonicalize" match="@syl"/>
  <xsl:template mode="turn-attributes-into-element" match="@syl">
    <xsl:variable name="staffN" select="(ancestor::mei:staff/@n)[last()]"/>
    <xsl:variable name="previousSyl" select="(preceding::mei:staff[@n=$staffN]//@syl)[last()]"/>
    <mei:verse n="1">
      <mei:syl>
        <xsl:choose>
          <!-- @syl has "-" -->
          <xsl:when test="ends-with(.,'-')">
            <xsl:attribute name="con">
              <xsl:value-of select="'d'"/>
            </xsl:attribute>
            <xsl:attribute name="wordpos">
              <xsl:value-of select="if(ends-with($previousSyl,'-'))
                then 'm'
                else 'i'"/>
            </xsl:attribute>
          </xsl:when>
          <!-- @syl does not have "-" -->
          <xsl:otherwise>
            <xsl:if test="ends-with($previousSyl,'-')">
              <xsl:attribute name="wordpos">
                <xsl:value-of select="'t'"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="ends-with(.,'_')">
              <xsl:attribute name="con">
                <xsl:value-of select="'u'"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <!-- Copy everything except the last char as this might be dash/underscore -->
        <xsl:value-of select="substring(.,1,string-length(.)-1)"/>
        <!-- Copy the last char (if it's a dash or underscore, it will be translated to an empty string) -->
        <xsl:value-of select="translate(substring(.,string-length(.),1),'-_','')"/>
      </mei:syl>
    </mei:verse>
  </xsl:template>
  
  <xsl:template match="mei:syl[not(parent::mei:verse)]" mode="canonicalize">
    <mei:verse n="{count(preceding-sibling::mei:syl) + 1}">
      <xsl:copy-of select="."/>
    </mei:verse>
  </xsl:template>
  
  <xsl:template match="mei:verse[not(@n)]" mode="canonicalize">
    <xsl:copy>
      <xsl:attribute name="n">
        <xsl:value-of select="count(preceding-sibling::mei:verse) + 1"/>
      </xsl:attribute>
      <xsl:copy-of select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- We can add a missing @plist to beamSpans that are on the same layer in the same staff.
       It needs @startid and @endid, though. As <beamSpan>s have a "musical" @dur (the same type as notes/rests),
       @tstamp/@dur can't be used for general <beamSpan>s. So we don't support it for now.-->
  <xsl:template match="mei:beamSpan[not(@plist) and 
                                     id(@startid)/ancestor::staff/@n[last()]
                                    =id(@endid  )/ancestor::staff/@n[last()]]" mode="canonicalize">
    <xsl:variable name="startNote" select="id(@startid)" as="element()"/>
    <xsl:variable name="endNote"   select="id(@endid)"   as="element()"/>
    <xsl:variable name="beamNotes" select="key('notes-by-staff-and-layer',concat(
        (ancestor::mei:staff/@n,@staff)[last()],
        '$',
        (ancestor::mei:layer/@n,@layer)[last()]
      ))[preceding::*=$startNote and following::*=$endNote]"/>
    <xsl:copy>
      <xsl:attribute name="plist">
        <xsl:for-each select="($startNote,$beamNotes,$endNote)">
          <xsl:value-of select="concat(@xml:id,' ')"/>
        </xsl:for-each>
      </xsl:attribute>
      <xsl:apply-templates select="@*|node()" mode="canonicalize"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template mode="turn-attributes-into-element" 
      match="@tie[
        string()='i' and not(
          (: only create new tie element if there isn't already one :)
          for $noteId in ../@xml:id
          return key('tieByStartid',$noteId)
        )
      ]">
    <xsl:variable name="staffN" select="ancestor::mei:staff/@n"/>
    <xsl:variable name="layerN" select="ancestor::mei:layer/@n"/>
    <mei:tie startid="{../@xml:id}" 
      endid="{../following::mei:note[@tie='t' and .=key('notes-by-staff-and-layer',concat($staffN,'$',$layerN))][1]/@xml:id}"/>
  </xsl:template> 

  <!-- QUESTION: Is there an attribute version of <dynam> that we need to canonicalize? -->

  <xsl:template match="@*" mode="turn-attributes-into-element"/>


</xsl:stylesheet>
