<?xml version="1.0"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:duration="NS:DURATION" xmlns:frac="NS:FRAC" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">

  <!--<import href="fraction.xsl"/>
  <import href="contentChronologyKeys.xsl"/>-->
	
	<!--  !!! We want to @dur added to ftrem/btrem during preprocessing, which is non-conformant with the specs !!! -->
                                    	<!-- QUESTION: Is this the complete list of "events" that take up time?                  Why can't I use boolean(@dur) -->
	<key name="timeConsumingElements" match="mei:note[not(@grace)]|mei:rest|mei:chord|mei:ftrem|mei:btrem|mei:space|mei:halfmRpt|mei:mRest|mei:mSpace" 
	    use="if (@dur)
	         then 'withDur'
	         else 'withoutDur'"/>
  
  <template match="/" priority="-10">
    <apply-templates select="." mode="addDurations"/>
  </template>
  
  <template mode="addDurations" match="@*|node()">
    <copy>
      <apply-templates mode="addDurations" select="@*|node()"/>
    </copy>
  </template>

  <!-- QUESTION: What to do with elements that don't contribute to the duration of the parent element, but still have a duration (like beamSpan)? -->

  <template mode="addDurations" name="process-elements-with-synchronous-content" match="key('contentChronology','synchronous')">
    <variable name="children" as="node()*">
      <apply-templates mode="addDurations" select="node()"/>
    </variable>
    <variable name="longestChild" as="element()?" select="$children[@duration:rounded = max($children/@duration:rounded)][1]"/>
    <copy>
      <if test="$longestChild">
        <call-template name="write-duration">
          <!-- QUESTION: Does it make sense to add "cast as xs:integer" here, or is this done anyway 
                         because of the type expected by the template parameter? -->
          <with-param name="duration" select="($longestChild/@duration:numerator cast as xs:integer,                                                $longestChild/@duration:denominator cast as xs:integer)" as="xs:integer*"/>
        </call-template>
      </if>
      <apply-templates mode="addDurations" select="@*"/>
      <copy-of select="$children"/>
    </copy>
  </template>
  
  <template mode="addDurations" name="process-elements-with-sequential-content" match="key('contentChronology','sequential')">
    <variable name="children" as="node()*">
      <apply-templates mode="addDurations" select="node()"/>
    </variable>
    <variable name="childrenWithDuration" select="$children[@duration:*]" as="element()*"/>
    <copy>
      <if test="$childrenWithDuration">
        <call-template name="write-summed-up-duration">
          <with-param name="elements" select="$childrenWithDuration"/>
        </call-template>
      </if>
      <apply-templates mode="addDurations" select="@*"/>
      <copy-of select="$children"/>
    </copy>
  </template>
  
  <template mode="addDurations" match="key('contentChronology','seeGrandparent')">
    <choose>
      <when test="../.. = key('contentChronology','sequential')">
        <call-template name="process-elements-with-sequential-content"/>
      </when>
      <when test="../.. = key('contentChronology','synchronous')">
        <call-template name="process-elements-with-synchronous-content"/>
      </when>
      <otherwise>
        <message terminate="yes">
          ERROR: <value-of select="local-name()"/> element <value-of select="@xml:id"/> has unexpected grandparent element <value-of select="local-name(../..)"/>  
        </message>
      </otherwise>
    </choose>
  </template>
  
  <!-- QUESTION: This almost the same as the template above. Is there a nice way to have a super-template that is called by both of them? -->
  <template mode="addDurations" match="key('contentChronology','seeParent')">
    <choose>
      <when test=".. = key('contentChronology','sequential')">
        <call-template name="process-elements-with-sequential-content"/>
      </when>
      <when test=".. = key('contentChronology','synchronous')">
        <call-template name="process-elements-with-synchronous-content"/>
      </when>
      <otherwise>
        <message terminate="yes">
          ERROR: <value-of select="local-name()"/> element <value-of select="@xml:id"/> has unexpected parent element <value-of select="local-name()"/>  
        </message>
      </otherwise>
    </choose>
  </template>
  
	<template mode="addDurations" match="key('timeConsumingElements','withDur')" priority="2">
    <variable name="rawNumerator" as="xs:integer">
      <apply-templates mode="get-raw-numerator" select="@dur"/>
    </variable>
    <variable name="rawDenominator" as="xs:integer">
      <apply-templates mode="get-raw-denominator" select="@dur"/>
    </variable>
    <variable name="augmentationDenominator" as="xs:integer">
      <apply-templates mode="get-augmentation-denominator" select="."/>
    </variable>
    <variable name="tupletNumerator" as="xs:integer">
      <apply-templates mode="get-tuplet-numerator" select="."/>
    </variable>
    <variable name="tupletDenominator" as="xs:integer">
      <apply-templates mode="get-tuplet-denominator" select="."/>
    </variable>
    <copy>
      <call-template name="write-duration">
        <with-param name="duration" select="frac:completelyReduce(
                                              $rawNumerator * $tupletNumerator * (2 * $augmentationDenominator - 1),
                                              $rawDenominator * $tupletDenominator * $augmentationDenominator
                                            )" as="xs:integer*"/>
      </call-template>
      <apply-templates mode="addDurations" select="@*|node()"/>
    </copy>
  </template>
	<template mode="addDurations" match="key('timeConsumingElements','withoutDur')" priority="2">
		<message terminate="yes">
			ERROR: @dur required on <value-of select="local-name()"/> element <value-of select="@xml:id"/>
		</message>
	</template>
  <!-- Be more tolerant with spaces -->
  <template mode="addDurations" match="mei:space[not(@dur)]" priority="3">
    <copy>
      <call-template name="write-duration">
        <with-param name="duration" select="(0,1)"/>
      </call-template>
      <apply-templates mode="addDurations"/>
    </copy>
  </template>
  <template mode="addDurations" match="mei:*[(self::mei:mRest or self::mei:mSpace) and not(@dur)]" priority="3">
		<variable name="staffN" select="ancestor::mei:staff/@n"/>
		<variable name="timeSignatureDef" select="    preceding::mei:*[      (        (          local-name() = 'staffDef' and @n = $staffN        )         or         (          local-name() = 'scoreDef' and .//mei:staffDef[@n = $staffN]        )      )       and       @meter.count and @meter.unit    ][1]"/>
		<copy>
		  <apply-templates select="@*|node()" mode="addDurations"/>
			<call-template name="write-duration">
				<with-param name="duration" select="frac:completelyReduce($timeSignatureDef/@meter.count,$timeSignatureDef/@meter.unit)" as="xs:integer*"/>
			</call-template>
		</copy>
	</template>
		
  <template match="@dur" mode="get-raw-numerator" priority="-1">
    <value-of select="1"/>
  </template>
  <template match="@dur[string()=('brevis','breve')]" mode="get-raw-numerator">
    <value-of select="2"/>
  </template>
  <template match="@dur[string()=('longa','long')]" mode="get-raw-numerator">
    <value-of select="4"/>
  </template>
  <template match="@dur[string()='maxima']" mode="get-raw-numerator">
    <value-of select="8"/>
  </template>
  
  <template match="@dur" mode="get-raw-denominator" priority="-1">
    <value-of select="number()"/>
  </template>
  <template match="@dur[string()='semifusa']" mode="get-raw-denominator">
    <value-of select="16"/>
  </template>
  <template match="@dur[string()='fusa']" mode="get-raw-denominator">
    <value-of select="8"/>
  </template>
  <template match="@dur[string()='semiminima']" mode="get-raw-denominator">
    <value-of select="4"/>
  </template>
  <template match="@dur[string()='minima']" mode="get-raw-denominator">
    <value-of select="2"/>
  </template>
  <template match="@dur[string()=('semibrevis','brevis','breve','longa','long','maxima')]" mode="get-raw-denominator">
    <value-of select="1"/>
  </template>
  
  <template match="mei:*" mode="get-augmentation-denominator" priority="-1">
    <sequence select="1"/>
  </template>
  <template match="mei:*[@dots]" mode="get-augmentation-denominator">
    <param name="augmentationDenominator" select="1" as="xs:integer"/>
    <param name="dots" select="@dots" as="xs:integer"/>
    <choose>
      <when test="$dots=0">
        <value-of select="$augmentationDenominator"/>
      </when>
      <otherwise>
        <apply-templates select="." mode="get-augmentation-denominator">
          <with-param name="augmentationDenominator" select="$augmentationDenominator * 2"/>
          <with-param name="dots" select="$dots - 1"/>
        </apply-templates>
      </otherwise>
    </choose>
  </template>
  
  <template match="mei:*" mode="get-tuplet-numerator" priority="-1">
    <value-of select="1"/>
  </template>
  <template match="mei:*[ancestor::mei:tuplet]" mode="get-tuplet-numerator">
    <value-of select="ancestor::mei:tuplet[last()]/@num"/>
  </template>
  <template match="mei:*[ancestor::mei:tuplet][not(@num)]" mode="get-tuplet-numerator" priority="1">
    <message terminate="yes">
      ERROR: @num required on tuplet <value-of select="@xml:id"/>
    </message>
  </template>
  
  <template match="mei:*" mode="get-tuplet-denominator" priority="-1">
    <value-of select="1"/>
  </template>
  <template mode="addDurations" match="mei:*[ancestor::mei:tuplet]">
    <value-of select="ancestor::mei:tuplet[last()]/@numbase"/>
  </template>
  <template mode="addDurations" match="mei:*[ancestor::mei:tuplet][not(@numbase)]" priority="1">
    <message terminate="yes">
      ERROR: @numbase required on tuplet <value-of select="@xml:id"/>
    </message>
  </template>
  
  <!-- QUESTION: This is basically identical to template "write-synch" from addSynchronicity.xsl 
    Generalize this template? -->
  <template name="write-duration">
    <!-- parameter duration is required to be a "fraction" (a two-element sequence) -->
  	<param name="duration" as="xs:integer*"/>
    <attribute name="numerator" namespace="NS:DURATION">
      <value-of select="$duration[1]"/>
    </attribute>
    <attribute name="denominator" namespace="NS:DURATION">
      <value-of select="$duration[2]"/>
    </attribute>
    <attribute name="rounded" namespace="NS:DURATION">
      <value-of select="$duration[1] div $duration[2]"/>
    </attribute>
  </template>
  
  <template name="write-summed-up-duration">
    <param name="duration" select="(0,1)" as="xs:integer*"/>
    <param name="elements" as="element()*"/>
    
    <choose>
      <!-- If there are no more elements to sum up, write the attributes -->
      <when test="$elements">
        <variable name="elementNumerator" select="$elements[1]/@duration:numerator" as="xs:integer"/>
        <variable name="elementDenominator" select="$elements[1]/@duration:denominator" as="xs:integer"/>
        <variable name="elementDuration" select="($elementNumerator,$elementDenominator)" as="xs:integer*"/>
        
        <!-- recurse -->
        <call-template name="write-summed-up-duration">
          <with-param name="elements" select="$elements except $elements[1]"/>
          <with-param name="duration" select="frac:add(                                                 $duration,                                                 $elementDuration                                               )"/>
        </call-template>
      </when>
      <otherwise>
        <call-template name="write-duration">
          <with-param name="duration" select="$duration" as="xs:integer*"/>
        </call-template>
      </otherwise>
    </choose>
  </template>
  
</stylesheet>
