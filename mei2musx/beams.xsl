<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:svg="http://www.w3.org/2000/svg" xmlns="NS:MUSX" version="1.0">
  
  <!-- TODO: How should alternatives inside beams be handled?  Currently, only a flat sequence of notes/chords is handled -->
  
  <!-- This template calculates the number of beams necessary for notes of duration $dur. 
       As we can't take roots with XSLT, this recursive template is used that in any iteration
       increments the parameter $number and divides $dur by 2 -->
  <xsl:template match="*" mode="get-number-of-beams">
    <xsl:param name="number" select="0"/>
    <xsl:param name="dur" select="@dur"/>
    
    <xsl:choose>
      <xsl:when test="$dur &gt; 5">
        <xsl:apply-templates select="." mode="get-number-of-beams">
          <xsl:with-param name="number" select="$number + 1"/>
          <xsl:with-param name="dur" select="$dur div 2"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$number"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="mei:*[@dur=2 and ancestor::mei:fTrem]" mode="get-number-of-beams">
    <xsl:value-of select="1"/>
  </xsl:template>

  <!-- The number of "main" beams depends on the longest note under the beam (i.e. the 
       smallest @dur attribute) -->
  <xsl:template name="get-minimum-dur">
    <xsl:param name="notes"/>
    <xsl:variable name="durList">
      <xsl:for-each select="$notes">
        <xsl:sort select="@dur" data-type="number" order="ascending"/>
        <xsl:value-of select="concat(@dur,' ')"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="substring-before($durList,' ')"/>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:beam">
    <beam start="{concat(.//mei:*[self::mei:note[not(ancestor::mei:chord)] or self::mei:chord][1]/@xml:id, '_stem')}" end="{concat(.//mei:*[self::mei:note[not(ancestor::mei:chord)] or self::mei:chord][last()]/@xml:id, '_stem')}">
      <!-- $minimumDur is the numerically smallest @dur attribut, i.e. the *biggest* time value;
           if there are durations 8, 16, 32, 32, then 8 is the minimum dur -->
      <xsl:variable name="minimumDur">
        <xsl:call-template name="get-minimum-dur">
          <xsl:with-param name="notes" select=".//mei:note"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:attribute name="number">
        <xsl:apply-templates select="." mode="get-number-of-beams">
          <xsl:with-param name="dur" select="$minimumDur"/>
        </xsl:apply-templates>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="copy-id"/>
      <xsl:apply-templates mode="add-subbeams" select="*[self::mei:note or self::mei:chord][@dur &gt; $minimumDur]">
        <xsl:with-param name="alreadyDrawnDur" select="$minimumDur"/>
      </xsl:apply-templates>
    </beam>
    <xsl:apply-templates mode="mei2musx"/>
  </xsl:template>
  
  <!-- TODO: The matching/selection mechanism for subbeams should be improved.  As can be seen in 
       file Beispiele/beamtest.mei, sometimes superfluous subbeams are added.  Those aren't visible because they
       are directly superimposed over other subbeams, therefore the visual result is correct. -->
  <!-- This template matches all notes that don't have an immediate preceding note/chord that is equally long or shorter. 
       At a note/chord that satisfies this condition, a new subbeam must start. -->
  <xsl:template mode="add-subbeams" match="*[                (self::mei:note or self::mei:chord)                 and                 not( self::*/@dur &lt;= preceding-sibling::mei:*[self::mei:note or self::mei:chord][1]/@dur)              ]">
    <xsl:param name="alreadyDrawnDur"/>
    <xsl:variable name="dur" select="@dur"/>
    <xsl:variable name="startId" select="@xml:id"/>
    <!-- Find last note that is a) shorter than the already drawn beam implies and b) isn't separated from the current
         note by a note for which the already drawn beams are already sufficient. This is the endpoint of the subbeam --> 
    <xsl:variable name="endId" select="           (             following-sibling::*             [@dur &gt; $alreadyDrawnDur]             [not(               preceding-sibling::*               [@dur &lt;= $alreadyDrawnDur]               [preceding-sibling::*/@xml:id = $startId]             )]             | self::*           )[last()]/@xml:id"/>
    <xsl:variable name="notesUnderSubbeam" select="self::*|key('id',$endId)|                 following-sibling::*[                   following-sibling::*/@xml:id=$endId                  ]"/>
    <xsl:variable name="minimumDur">
      <xsl:call-template name="get-minimum-dur">
        <xsl:with-param name="notes" select="$notesUnderSubbeam"/>
      </xsl:call-template>
    </xsl:variable>
    
    <subbeam start="{@xml:id}_stem" notesUnderSubbeam="{count($notesUnderSubbeam)}">
      <xsl:attribute name="number">
        <xsl:apply-templates select="." mode="get-number-of-beams">
          <xsl:with-param name="dur" select="$minimumDur div $alreadyDrawnDur * 4"/>
        </xsl:apply-templates>
      </xsl:attribute>
      <xsl:attribute name="end">
        <xsl:value-of select="concat($endId,'_stem')"/>
      </xsl:attribute>
      <!-- If there is only one note under this subbeam, add a stemlet -->
      <xsl:if test="@xml:id = $endId">
        <xsl:attribute name="x1">
          <!-- TODO: Distinguish whether stemlet goes to the left or to the right -->
          <xsl:value-of select="'s-2'"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates mode="add-subbeams" select="$notesUnderSubbeam[@dur &gt; $minimumDur]">
        <xsl:with-param name="alreadyDrawnDur" select="$minimumDur"/>
      </xsl:apply-templates>
    </subbeam>
  </xsl:template>

  <!-- TODO: implement ftrems for whole notes (without stems) -->
  <xsl:template mode="mei2musx" match="mei:fTrem">
    <xsl:variable name="numberOfBeams">
      <xsl:apply-templates mode="get-number-of-beams" select="(.//mei:note|.//mei:chord)[@dur][1]"/>
    </xsl:variable>
    <beam start="{.//*[self::mei:note or self::mei:chord][1]/@xml:id}" end="{.//*[self::mei:note or self::mei:chord][last()]/@xml:id}" number="{$numberOfBeams}">
      <xsl:apply-templates select="." mode="copy-id"/>
      <subbeam x1="s2" x2="s-2" number="{@slash - $numberOfBeams}"/>
    </beam>
    <xsl:apply-templates mode="mei2musx"/>
  </xsl:template>
</xsl:stylesheet>
