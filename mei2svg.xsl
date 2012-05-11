<?xml version="1.0" encoding="UTF-8"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform"
  version="2.0">
  
  <import href="preprocessor/reduceToMdiv.xsl"/>
  <import href="preprocessor/add-ids.xsl"/>
  <import href="preprocessor/canonicalize.xsl"/>
  <import href="preprocessor/addDurations.xsl"/>
  <import href="preprocessor/addSynchronicity.xsl"/>
  <import href="preprocessor/anyuri2idref.xsl"/>
  <import href="mei2musx/mei2musx.xsl"/>
  <import href="formatter/createSubevents.xsl"/>
  <import href="formatter/accidentalFormatter.xsl"/>
  <import href="formatter/spacing.xsl"/>
  <import href="musx2svg/musx2svg.xsl"/>
  
  <param name="outputStep" select="'svg'"/>
  
  <template match="/" priority="10">
    <variable name="reducedMEI">
      <apply-templates select="." mode="reduceToMdiv"/>
    </variable>
    <variable name="MEIwithIDs">
      <apply-templates select="$reducedMEI" mode="add-ids"/>
    </variable>
    <variable name="canonicalizedMEI">
      <apply-templates select="$MEIwithIDs" mode="canonicalize"/>
    </variable>
    <variable name="MEIwithDurations">
      <apply-templates select="$canonicalizedMEI" mode="addDurations"/>
    </variable>
    <variable name="MEIwithSynch">
      <apply-templates select="$MEIwithDurations" mode="addSynchronicity"/>
    </variable>
    <variable name="MEIwithIDREFs">
      <apply-templates select="$MEIwithSynch" mode="anyuri2idref"/>
    </variable>
    <variable name="musx">
      <apply-templates select="$MEIwithIDREFs" mode="mei2musx"/>
    </variable>
    <variable name="musxWithSubevents">
      <apply-templates select="$musx" mode="create-subevents"/>
    </variable>
    <variable name="musxAccidentalsFormatted">
      <apply-templates select="$musxWithSubevents" mode="accidentalFormatter"/>
    </variable>
    <variable name="spacedMusx">
      <apply-templates select="$musxAccidentalsFormatted" mode="spacing"/>
    </variable>
    <variable name="svg">
      <apply-templates select="$spacedMusx" mode="musx2svg"/>
    </variable>
    
    <choose>
      <when test="$outputStep = 'reducedMEI'">
        <sequence select="$reducedMEI"/>
      </when>
      <when test="$outputStep = 'MEIwithIDs'">
        <sequence select="$MEIwithIDs"/>
      </when>
      <when test="$outputStep = 'canonicalizedMEI'">
        <sequence select="$canonicalizedMEI"/>
      </when>
      <when test="$outputStep = 'MEIwithDurations'">
        <sequence select="$MEIwithDurations"/>
      </when>
      <when test="$outputStep = 'MEIwithSynch'">
        <sequence select="$MEIwithSynch"/>
      </when>
      <when test="$outputStep = 'MEIwithIDREFs'">
        <sequence select="$MEIwithSynch"/>
      </when>
      <when test="$outputStep = 'musx'">
        <sequence select="$musx"/>
      </when>
      <when test="$outputStep = 'musxWithSubevents'">
        <sequence select="$musxWithSubevents"/>
      </when>
      <when test="$outputStep = 'musxAccidentalsFormatted'">
        <sequence select="$musxAccidentalsFormatted"/>
      </when>
      <when test="$outputStep = 'spacedMusx'">
        <sequence select="$spacedMusx"/>
      </when>
      <when test="$outputStep = 'svg'">
        <sequence select="$svg"/>
      </when>
      <otherwise>
        <message terminate="yes">
          ERROR: Invalid parameter outputStep = <value-of select="$outputStep"/>
          Valid parameters are: 
          reducedMEI, MEIwithIDs, canonicalizedMEI, MEIwithDurations, MEIwithSynch, 
          MEIwithIDREFs, musx, musxWithSubevents, musxAccidentalsFormatted, spacedMusx, svg
        </message>
      </otherwise>
    </choose>
  </template>
  
</stylesheet>