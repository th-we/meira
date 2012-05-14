<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mei2svg="NS:MEI2SVG">
  
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
  
  <variable name="steps" select="('reducedMEI','MEIwithIDs','canonicalizedMEI',
      'MEIwithDurations','MEIwithSynch','MEIwithIDREFs','musx','musxWithSubevents',
      'musxAccidentalsFormatted','spacedMusx','svg')" as="xs:string+"/>
  
  <param name="firstStep" select="$steps[1]" as="xs:string"/>
  <param name="outputStep" select="$steps[last()]" as="xs:string"/>
  
  <template match="/" priority="10">
    <param name="currentStep" select="$firstStep" as="xs:string"/>
    
    <variable name="intermediateDocument" as="document-node()">
      <document>
        <choose>
          <when test="$currentStep = 'reducedMEI'">
            <apply-templates select="." mode="reduceToMdiv"/>
          </when>
          <when test="$currentStep = 'MEIwithIDs'">
            <apply-templates select="." mode="add-ids"/>
          </when>
          <when test="$currentStep = 'canonicalizedMEI'">
            <apply-templates select="." mode="canonicalize"/>
          </when>
          <when test="$currentStep = 'MEIwithDurations'">
            <apply-templates select="." mode="addDurations"/>
          </when>
          <when test="$currentStep = 'MEIwithSynch'">
            <apply-templates select="." mode="addSynchronicity"/>
          </when>
          <when test="$currentStep = 'MEIwithIDREFs'">
            <apply-templates select="." mode="anyuri2idref"/>
          </when>
          <when test="$currentStep = 'musx'">
            <apply-templates select="." mode="mei2musx"/>
          </when>
          <when test="$currentStep = 'musxWithSubevents'">
            <apply-templates select="." mode="create-subevents"/>
          </when>
          <when test="$currentStep = 'musxAccidentalsFormatted'">
            <apply-templates select="." mode="accidentalFormatter"/>
          </when>
          <when test="$currentStep = 'spacedMusx'">
            <apply-templates select="." mode="spacing"/>
          </when>
          <when test="$currentStep = 'svg'">
            <apply-templates select="." mode="musx2svg"/>
          </when>
          <otherwise>
            <message terminate="yes"> ERROR: Invalid parameter outputStep = <value-of select="$outputStep"/>
              Possible values are:
              <value-of select="$steps" separator="', '"/>
            </message>
          </otherwise>
        </choose>
      </document>
    </variable>
    
    <choose>
      <when test="$currentStep = $outputStep">
        <sequence select="$intermediateDocument"/>
      </when>
      <otherwise>
        <variable name="nextStepIndex" select="index-of($steps,$currentStep)+1"/>
        <apply-templates select="$intermediateDocument">
          <with-param name="currentStep" select="$steps[$nextStepIndex]" as="xs:string"/>
        </apply-templates>
      </otherwise>
    </choose>
  </template>
  
</stylesheet>