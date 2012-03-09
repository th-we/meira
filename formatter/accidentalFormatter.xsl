<?xml version="1.0"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:update="NS:UPDATE" xmlns:musx="NS:MUSX" version="2.0">
  <import href="update.xsl"/>

  <!-- TODO: - Arrange accidentals in "C-Shape" (see Gieseking)
             - Check whether there are noteheads flipped to the left and move accidentals further left accordingly -->
  <!-- These parameters are in scale steps, i.e. the "s" unit -->
  <param name="columnWidth" select="2.5"/>
	<!-- Is accidental origin currently on the left or the right of the symbol? -->
  <param name="distanceFromNotes" select="2.5"/>

  <template match="/" priority="-10">
  	<apply-templates select="." mode="accidentalFormatter"/>
  </template>

  <template mode="accidentalFormatter" match="/">
    <variable name="updateTree">
      <document>
        <for-each select="//musx:staff">
          <for-each-group select=".//musx:note[musx:accidental]" group-by="ancestor-or-self::*/@start">
            <call-template name="arrange-accidentals">
              <with-param name="notes" as="element()*">
                <perform-sort select="current-group()">
                  <!-- @y is expected to be of the form "S-4", "S3" etc. (i.e. leading S unit) -->
                  <sort select="number(substring(@y,2))"/>
                </perform-sort>
              </with-param>
            </call-template>
          </for-each-group>
        </for-each>
      </document>
    </variable>
    
    <apply-templates mode="update">
      <with-param name="updateTree" select="$updateTree"/>
    </apply-templates>
  </template>
  
  <template name="arrange-accidentals">
    <param name="notes" as="element()*"/>
    <param name="columndIndex" select="0" as="xs:integer"/>
    
    <variable name="notesInFirstColumn" as="element()*">
      <call-template name="arrange-column">
        <with-param name="notes" select="$notes" as="element()*"/>
      </call-template>
    </variable>
    <variable name="remainingNotes" select="$notes[not(. intersect $notesInFirstColumn)]"/>
    
    <for-each select="$notesInFirstColumn">
      <update:attribute name="x" element="{generate-id(musx:accidental)}" value="s{-($columndIndex * $columnWidth + $distanceFromNotes)}"/>
    </for-each>
    
    <if test="$remainingNotes">
      <call-template name="arrange-accidentals">
        <with-param name="notes" select="$remainingNotes"/>
        <with-param name="columndIndex" select="$columndIndex + 1"/>
      </call-template>
    </if>
  </template>

  <template name="arrange-column">
    <param name="notes" as="element()*"/>
    
    <!-- QUESTION: Is there a better way to find the top note? -->
    <variable name="topNoteY" select="number(substring($notes[1]/@y,2))" as="xs:double"/>
    
    <!-- Add first note to column -->
    <sequence select="$notes[1]"/>
    
    <!-- select all notes that are farther than a sixth (i.e. farther than 5 steps) away from first note -->
    <variable name="furtherNotesPotentiallyInThisColumn" select="$notes[number(substring(@y,2)) gt $topNoteY + 5]" as="element()*"/>
    <!-- recurse -->
    <if test="$furtherNotesPotentiallyInThisColumn">
      <call-template name="arrange-column">
        <with-param name="notes" select="$furtherNotesPotentiallyInThisColumn"/>
      </call-template>
    </if>
  </template>

</stylesheet>
