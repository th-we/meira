<?xml version="1.0"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:update="NS:UPDATE" 
    xmlns:musx="NS:MUSX" 
    xmlns:xsb="http://www.expedimentum.org/XSLT/SB">

<import href="../musx2svg/math/math.xsl"/>

<param name="spacingBase" select="1.618" as="xs:double"/>
<param name="referenceNote.duration" select=".25" as="xs:double"/>
<param name="referenceNote.space" select="40" as="xs:double"/>
<!--<param name="taylorPolynomialDegree" select="20" as="xs:integer"/>-->
		
<function name="musx:space" as="xs:double">
	<param name="duration" as="xs:double"/>
  <!--<sequence select="musx:power($spacingBase,$duration div $referenceNote.duration - 1,$taylorPolynomialDegree) * $referenceNote.space"/>-->
  <sequence select="xsb:pow($spacingBase,$duration div $referenceNote.duration - 1) * $referenceNote.space"/>
</function>
	
<!-- The power function (f(x)=b^x) is emulated by a Taylor series, developed at b=1. 
	   The first terms of the series are
	       1 + x(b-1) + 1/2x(x-1)(b-1)^2 + 1/6x(x-1)(x-2)(b-1)^3 +  ...
	   This can be expressed as
			    n   1         i    i               n    i   (b-1)(x+1-j)
			   SUM === * (b-1) * PROD (x+1-j)  =  SUM PROD  ============ 
			   i=0  i!            j=1             i=0  j=1       j
	   The PROD (product) part is calculated by musx:polynomialTerm(), musx:power() sums up all polynomial terms.
	   In this context, we need base values from 1 (equidistant spacing) to 2 (proportional spacing).
	   Exponents lie in the range of 1/2048 (2048th note) to 8 (maxima).
	   The worst case scenario for reasonably small polynomial degrees (<=6) is a maxima in proportional spacing.  
	   For this situation and a polynomial degree of 5, a maxima's space is off by 14%.
	   All other notes' spacing is accurate within a tolerance of less than a percent.
	-->
	
<!--<function name="musx:power" as="xs:double">
	<!-\- Calculates the sum of polynomial terms recursively (does the "SUM" part of the above formula) -\->
	<param name="b" as="xs:double"/>
	<param name="x" as="xs:double"/>
	<param name="termIndex" as="xs:integer"/>
	<!-\- the higher $termIndex, the more terms are being calculated, the higher the accuracy -\->

	<sequence select="if($termIndex &gt;= 0)                   
	                  then musx:polynomialTerm($b,$x,$termIndex) + musx:power($b,$x,$termIndex - 1)                   
	                  else 0"/>
</function>
	
<function name="musx:polynomialTerm" as="xs:double">
	<!-\- Calculates the polynomial term recursively (does the "PROD" part of the above formula) -\->
	<param name="b" as="xs:double"/>
	<param name="x" as="xs:double"/>
	<param name="j" as="xs:integer"/>
	
	<sequence select="if($j &gt;= 1)
	                  then ($b - 1)*($x + 1 - $j) div $j * musx:polynomialTerm($b,$x,$j - 1)                    
	                  else 1"/> 
</function>-->

<template mode="spacing" match="node()|@*">
	<copy>
		<apply-templates mode="spacing" select="node()|@*"/>
	</copy>
</template>
	
<template mode="spacing" match="musx:eventList">
	<copy>
		<apply-templates mode="spacing" select="musx:event[1]"/>
	</copy>
</template>
	
<template mode="spacing" match="musx:event">
	<param name="x" select="0"/><!-- as="xs:double"/>-->
	<copy>
	  <apply-templates mode="spacing" select="node()|@*"/>
	  <attribute name="x">
	    <value-of select="$x"/>
	  </attribute>
	</copy>
	<variable name="nextEvent" select="following-sibling::musx:event[1]"/>
<!--	<message>
		match musx:event, @x = <value-of select="@x"/>
		$x = <value-of select="$x"/>
		@synchTime = <value-of select="@synchTime"/>
		$nextEvent/@synchTime = <value-of select="$nextEvent/@synchTime"/>
		$nextEvent/@synchTime - @synchTime = <value-of select="$nextEvent/@synchTime - @synchTime"/>
		<!-\-musx:space($nextEvent/@synchTime - @synchTime) = <value-of select="musx:space($nextEvent/@synchTime - @synchTime)"/>-\->
		$nextEvent = <copy-of select="$nextEvent"/>
	</message>-->
	<if test="$nextEvent">
		<!-- This must be in an "if" because otherwise processor complains about parameter x being an empty sequence,
		     even though the template is not called -->
		<apply-templates mode="spacing" select="$nextEvent">
			<with-param name="x" select="$x + musx:space($nextEvent/@synchTime - @synchTime)"/>
		</apply-templates>
	</if>
</template>

<template match="/" priority="-10">
	<apply-templates select="." mode="spacing"/>
</template>

<!-- This is only for testing -->
<!--<template match="/">
	<variable name="degree" select="5"/>
	<musx:out>
		2^4   = <value-of select="musx:power(2,4,$degree)"/>
		2^5   = <value-of select="musx:power(2,5,$degree)"/>
		1^4   = <value-of select="musx:power(1,4,$degree)"/>
		1^5   = <value-of select="musx:power(1,5,$degree)"/>
		1.5^4 = <value-of select="musx:power(1.5,4,$degree)"/>
		1.5^5 = <value-of select="musx:power(1.5,5,$degree)"/>
		1.5^.5 = <value-of select="musx:power(1.5,.5,$degree)"/>
		1.5^.75 = <value-of select="musx:power(1.5,.75,$degree)"/>
		1.5^.125 = <value-of select="musx:power(1.5,.5,$degree)"/>
		1.5^.0078125 = <value-of select="musx:power(1.5,.0078125,$degree)"/>
		
	</musx:out>
</template>-->

</stylesheet>
