<?xml version="1.0"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:update="NS:UPDATE" 
    xmlns:musx="NS:MUSX" 
    xmlns:xsb="http://www.expedimentum.org/XSLT/SB"
    xmlns:g="NS:GET">

<!--<import href="../musx2svg/math/math.xsl"/>-->
<!-- This stylesheet has the bounding box templates -->
<!--<import href="../musx2svg/musx2svg.xsl"/>-->
  
<param name="spacingBase" select="1.618" as="xs:double"/>
<param name="referenceNote.duration" select=".25" as="xs:double"/>
<param name="referenceNote.space" select="40" as="xs:double"/>
<param name="padding" select="4" as="xs:double"/>

<!-- We have to exclude rests with set @end because they move around flexibly. 
     They will otherwise irritate the spacing algorithm because they signal needing an amount of space that changes later anyway. -->
<key name="spacingRelevantElementsAtEvent" use="@start" match="musx:note|musx:rest[not(@end)]|musx:barline|musx:clef|musx:timeSignature|musx:keySignature|musx:symbolText"/>

<function name="musx:space" as="xs:double">
	<param name="duration" as="xs:double"/>
  <sequence select="xsb:pow($spacingBase,$duration div $referenceNote.duration - 1) * $referenceNote.space"/>
</function>
	
<template mode="spacing" match="*|@*">
	<copy>
		<apply-templates mode="spacing" select="node()|@*"/>
	</copy>
</template>
	
<template mode="spacing" match="text()">
  <copy-of select="."/>
</template>
	
<template mode="spacing" match="musx:eventList">
	<copy>
		<apply-templates mode="spacing" select="musx:event[1]"/>
	</copy>
</template>
  
<template mode="spacing" match="musx:page">
  <copy-of select="."/>
</template>
	
<template mode="spacing" match="musx:event">
	<param name="suggestedX" select="0" as="xs:double"/>
  <param name="availableSpaceToLeft" select="0" as="xs:double"/>

  <variable name="oldX" select="g:x(.)" as="xs:double"/>
  <variable name="nextEvent" select="following::musx:event[1]" as="element()?"/>
  <variable name="spacingRelevantElements" select="key('spacingRelevantElementsAtEvent',@xml:id)" as="element()*"/>
  <variable name="spacingRelevantBoundingBoxes" as="element()*">
    <apply-templates mode="get_OwnBoundingBox" select="$spacingRelevantElements/descendant-or-self::musx:*"/>
  </variable>
  <variable name="leftValues" as="xs:double*">
    <for-each select="$spacingRelevantBoundingBoxes">
      <sequence select="number(./@left)"/>
    </for-each>
  </variable>
  <variable name="spaceToLeft" select="$oldX - min(($leftValues,$oldX))" as="xs:double"/>
  <variable name="rightValues" as="xs:double*">
    <for-each select="$spacingRelevantBoundingBoxes">
      <sequence select="number(./@right)"/>
    </for-each>
  </variable>
  <variable name="spaceToRight" select="max(($rightValues,$oldX)) - $oldX" as="xs:double"/>
  
  <variable name="chosenX" select="$suggestedX + max(($spaceToLeft - $availableSpaceToLeft,0))" as="xs:double"/>
  
  <copy>
    <apply-templates mode="spacing" select="@*"/>
    <attribute name="x">
      <value-of select="$chosenX"/>
<!--      <value-of select="$suggestedX"/>-->
<!--      <value-of select="0"/>-->
    </attribute>
  </copy>
  <!--<copy-of select="following::text()[1]"/>-->
  
  <!--<if test="$suggestedX ne $chosenX">-->
<!--  <message>
<!-\-    $nextEvent/@synchTime = <value-of select="$nextEvent/@synchTime"/>
    @synchTime            = <value-of select="@synchTime"/>
    diff                  = <value-of select="$nextEvent/@synchTime - @synchTime"/>
    space                 = <value-of select="musx:space($nextEvent/@synchTime - @synchTime)"/>-\->
<!-\-    spaceToLeft = <value-of select="$spaceToLeft"/>
    spaceToRight = <value-of select="$spaceToRight"/>-\->
    ID          = <value-of select="@xml:id"/>
<!-\-    suggestedX = <value-of select="$suggestedX"/>
    chosenX    = <value-of select="$chosenX"/>-\->
    spaceToLeft = <value-of select="$spaceToLeft"/>
    availableSpaceToLeft <value-of select="$availableSpaceToLeft"/>
    <!-\-    oldX        = <value-of select="$oldX"/>
    rightValues = <copy-of select="$rightValues"/>
    spacingRelevantElements = <for-each select="$spacingRelevantElements"><value-of select="concat(local-name(),' ')"/></for-each>
    number of bboxes = <value-of select="count($spacingRelevantBoundingBoxes)"/>-\->
  </message>-->
  <!--</if>-->
  
  <if test="$nextEvent">
    <!-- This must be in an "if" because otherwise processor complains about parameter x being an empty sequence,
		     even though the template is not called -->
    <variable name="timeDifferenceToNextEvent" select="$nextEvent/ancestor-or-self::*/@synchTime - ancestor-or-self::*/@synchTime" as="xs:double"/>
    <variable name="nextSuggestedX" select="$chosenX + (if($timeDifferenceToNextEvent gt 0) 
                                                        then musx:space($timeDifferenceToNextEvent)
                                                        else 0)" as="xs:double"/>
    <variable name="nextAvailableSpaceToLeft" select="$nextSuggestedX - ($chosenX + $spaceToRight) - $padding" as="xs:double"/>
    
		<apply-templates mode="spacing" select="$nextEvent">
		  <with-param name="suggestedX" select="$nextSuggestedX" as="xs:double"/>
<!--		  <with-param name="suggestedX" select="$suggestedX + musx:space($nextEvent/@synchTime - @synchTime)" as="xs:double"/>-->
		  <with-param name="availableSpaceToLeft" select="$nextAvailableSpaceToLeft" as="xs:double"/>
		</apply-templates>
	</if>
</template>

<template match="/" priority="-10">
	<apply-templates select="." mode="spacing"/>
</template>

</stylesheet>
