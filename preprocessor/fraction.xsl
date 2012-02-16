<?xml version="1.0"?>
<stylesheet version="2.0" 
    xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:frac="NS:FRAC"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <function name="frac:add" as="xs:integer*">
    <param name="a" as="xs:integer*"/>
    <param name="b" as="xs:integer*"/>
    
    <variable name="numerator" select="$a[1] * $b[2] + $b[1] * $a[2]"/>
    <variable name="denominator" select="$a[2] * $b[2]"/>
    <sequence select="frac:completelyReduce($a[1] * $b[2] + $b[1] * $a[2], $a[2] * $b[2])"/>
  </function>
  
  <function name="frac:completelyReduce" as="xs:integer*">
    <param name="numerator" as="xs:integer"/>
    <param name="denominator" as="xs:integer"/>
    
    <variable name="greatestCommonFactor" select="frac:greatestCommonFactor($numerator,$denominator)"/>
    <sequence select="$numerator idiv $greatestCommonFactor, $denominator idiv $greatestCommonFactor"/>
  </function>
  
  <!-- Euclidean algorithm -->
  <function name="frac:greatestCommonFactor">
    <param name="a" as="xs:integer"/>
    <param name="b" as="xs:integer"/>
    
    <value-of select="if($b = 0) then $a 
                                 else frac:greatestCommonFactor($b, $a mod $b)"/>
  </function>
  
</stylesheet>