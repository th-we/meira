<?xml version="1.0" encoding="UTF-8"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform"
  version="2.0">
  
 <import href="preprocessor/reduceToMdiv.xsl"/>
  <import href="preprocessor/add-ids.xsl"/>
  <import href="preprocessor/canonicalize.xsl"/>
  <import href="preprocessor/addDurations.xsl"/>
  <import href="preprocessor/addSynchronicity.xsl"/>
  <import href="mei2musx/mei2musx.xsl"/>
  <import href="formatter/accidentalFormatter.xsl"/>
  <import href="formatter/spacing.xsl"/>
  <import href="musx2svg/musx2svg.xsl"/>
  
  <template match="/">
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
    <variable name="musx">
      <apply-templates select="$MEIwithSynch" mode="mei2musx"/>
    </variable>
    <variable name="musxAccidentalsFormatted">
      <apply-templates select="$musx" mode="accidentalFormatter"/>
    </variable>
    <variable name="spacedMusx">
      <apply-templates select="$musxAccidentalsFormatted" mode="spacing"/>
    </variable>
    <variable name="svg">
      <apply-templates select="$spacedMusx" mode="musx2svg"/>
    </variable>
    
    <sequence select="$svg"/>
  </template>
  
</stylesheet>