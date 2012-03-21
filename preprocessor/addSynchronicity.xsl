<?xml version="1.0"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:duration="NS:DURATION" xmlns:synch="NS:SYNCH" xmlns:frac="NS:FRAC" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
  
  <import href="fraction.xsl"/>
  <import href="contentChronologyKeys.xsl"/>
	
	<param name="floatToFractionPrecision" select="100" as="xs:integer"/>
  
  <template match="/">
  	<apply-templates select="." mode="addSynchronicity"/>
  </template>
  
  <template mode="addSynchronicity" match="/">
  	<variable name="meiWithSynch">
  		<apply-templates mode="addSynchronicity"/>
  	</variable>
  	
  	<apply-templates select="$meiWithSynch" mode="add-tstamp-synch"/>
  </template>
  
	<template mode="addSynchronicity" match="@*|node()">
		<copy>
			<apply-templates mode="addSynchronicity" select="@*|node()"/>
		</copy>
	</template>
	
	<template match="@*|node()" mode="add-tstamp-synch">
		<copy>
			<apply-templates select="@*|node()" mode="add-tstamp-synch"/>
		</copy>
	</template>
	
	<function name="synch:getMeasureSynch" as="xs:integer*">
		<param name="measure" as="node()"/>
		<sequence select="($measure/@synch:numerator cast as xs:integer, $measure/@synch:denominator cast as xs:integer)"/>
	</function>
	
	<function name="synch:getFractionalPart">
		<param name="tstamp" as="xs:string"/>
		<sequence select="frac:completelyReduce(    round((number($tstamp) - 1) * $floatToFractionPrecision) cast as xs:integer,    $floatToFractionPrecision   )"/> 
	</function>
	
	<template match="@tstamp" mode="add-tstamp-synch">
		<copy-of select="."/>
		<variable name="measureSynch" select="synch:getMeasureSynch(ancestor::mei:measure)" as="xs:integer*"/>
		<variable name="tstampFraction" select="synch:getFractionalPart(.)" as="xs:integer*"/>
		<call-template name="write-synch">
			<with-param name="synch" select="frac:add($measureSynch,$tstampFraction)"/>
		</call-template>
	</template>
	
	<template match="@dur[contains(.,'m+')]" mode="add-tstamp-synch">
		<copy-of select="."/>
		<variable name="endMeasureOffset" select="substring-before(.,'m') cast as xs:integer" as="xs:integer"/>
		<variable name="endMeasure" select="(following::mei:measure)[$endMeasureOffset + 1]" as="node()"/>
		<variable name="endMeasureSynch" select="synch:getMeasureSynch($endMeasure)" as="xs:integer*"/>
		<variable name="endTstamp" select="synch:getFractionalPart(substring-after(.,'m+'))" as="xs:integer*"/>
		<call-template name="write-synch">
			<with-param name="synch" select="frac:add($endMeasureSynch,$endTstamp)"/>
			<with-param name="namePrefix" select="'end.'"/>
		</call-template>
	</template>
	
	<template mode="addSynchronicity" match="key('contentChronology','synchronous')">
    <param name="synch" select="(0,1)" as="xs:integer*"/>
    
    <copy>
      <apply-templates mode="write-synch" select=".">
        <with-param name="synch" select="$synch"/>
      </apply-templates>
      <apply-templates mode="addSynchronicity" select="@*|node()">
        <with-param name="synch" select="$synch"/>
      </apply-templates>
    </copy>
  </template>

  <template mode="addSynchronicity" match="key('contentChronology','sequential')">
    <param name="synch" select="(0,1)" as="xs:integer*"/>
    
    <copy>
      <apply-templates mode="write-synch" select=".">
        <with-param name="synch" select="$synch"/>
      </apply-templates>
      <apply-templates mode="addSynchronicity" select="@*"/>
      <call-template name="add-sequential-elements">
        <with-param name="synch" select="$synch"/>
        <with-param name="elements" select="node()"/>
      </call-template>
    </copy>
  </template>
  
  <template name="add-sequential-elements">
    <param name="synch" select="(0,1)" as="xs:integer*"/>
    <param name="elements" as="node()*"/>
    
    <apply-templates mode="addSynchronicity" select="$elements[1]">
      <with-param name="synch" select="$synch"/>
    </apply-templates>

    <variable name="elementDuration" select="if($elements[1]/@duration:numerator and $elements[1]/@duration:denominator)                 then ($elements[1]/@duration:numerator cast as xs:integer,                       $elements[1]/@duration:denominator cast as xs:integer)                 else (0,1)"/>
    
    <if test="count($elements) gt 1">
      <call-template name="add-sequential-elements">
        <with-param name="synch" select="frac:add($synch,$elementDuration)"/>
        <with-param name="elements" select="$elements except $elements[1]"/>
      </call-template>
    </if>
  </template>

  <template mode="addSynchronicity" match="mei:note|mei:chord|mei:rest|mei:mRest|mei:mSpace">
    <param name="synch" as="xs:integer*"/>
    <copy>
      <apply-templates mode="write-synch" select=".">
        <with-param name="synch" select="$synch"/>
      </apply-templates>
      <apply-templates mode="addSynchronicity" select="@*|node()"/>
    </copy>
  </template>
	
  
  <!-- QUESTION: This is basically identical to template "write-duration" from addDurations.xsl 
       Generalize this template? -->
  <template name="write-synch" mode="write-synch" match="*">
    <param name="synch" as="xs:integer*"/>
    <!-- $namePrefix is used for write end synchronization data and then takes on the value
         "end.". This results in @end.numerator, @end.denominator etc. -->
    <param name="namePrefix" select="''" as="xs:string"/>
    
    <attribute name="{$namePrefix}numerator" namespace="NS:SYNCH">
      <value-of select="$synch[1]"/>
    </attribute>
    <attribute name="{$namePrefix}denominator" namespace="NS:SYNCH">
      <value-of select="$synch[2]"/>
    </attribute>
    <attribute name="{$namePrefix}rounded" namespace="NS:SYNCH">
      <value-of select="$synch[1] div $synch[2]"/>
    </attribute>
    <attribute name="{$namePrefix}id" namespace="NS:SYNCH">
      <value-of select="concat('_t',$synch[1],'_',$synch[2])"/>
    </attribute>
  </template>
  
  <template mode="write-synch" match="mei:measure">
    <param name="synch" as="xs:integer*"/>
    
    <call-template name="write-synch">
      <with-param name="synch" select="frac:add($synch,(@duration:numerator,@duration:denominator))"/>
      <with-param name="namePrefix" select="'end.'"/>
    </call-template>
    
    <call-template name="write-synch">
      <with-param name="synch" select="$synch"/>
    </call-template>
  </template>

  <!-- Handle second note/chord of an fTrem specially. The @synch* attributes shall respect the graphical position,
       not the musical synchronicity -->
  <template mode="write-synch" match="mei:*[parent::mei:fTrem and preceding-sibling::*]">
    <param name="synch" as="xs:integer*"/>
    
    <call-template name="write-synch">
      <with-param name="synch" select="$synch"/>
      <with-param name="namePrefix" select="'real.'"/>
    </call-template>
    
    <variable name="fTrem" select="ancestor::mei:fTrem" as="element()"/>
    <!-- Sum up numerator/denominator + 1/2 * fTrem_duration:numerator/fTrem_duration:denominator -->
    <call-template name="write-synch">
      <with-param name="synch" select="frac:add(                                          $synch,                                          ($fTrem/@duration:numerator cast as xs:integer,                                           2 * $fTrem/@duration:denominator cast as xs:integer)                                        )"/>
    </call-template>
  </template>

</stylesheet>
