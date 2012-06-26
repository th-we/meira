<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0" 
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:musx="NS:MUSX"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:g="NS:GET">
  
  <import href="../musx2svg/musx2svg.xsl"/>
  
  <param name="forceFormattingBeams" select="false()" as="xs:boolean"/>
  <param name="upperBoundForSlope" select=".5" as="xs:double"/>
  <param name="closestDistanceToNotehead" select="4" as="xs:double"/>
  <param name="distanceTolerance" select="1" as="xs:double"/>
  <!-- Just one go with no recursion seems to give quite acceptable results.
       For more recursions, at some places there are crazy things happening
       TODO: Debug those cases! -->
  <param name="maxBeamOptimizationRecursions" select="0" as="xs:integer"/>
  
  <template match="/">
    <apply-templates select="." mode="format-beams"/>
  </template>
  
  <template match="@*|node()" mode="format-beams">
    <copy>
      <apply-templates select="@*|node()" mode="format-beams"/>
    </copy>
  </template>
  
  <!-- Don't touch beams that already have positioning parameters, unless we force formatting of all beams -->
  <template match="musx:beam[not(@y1 or @y2 or @y) or $forceFormattingBeams]" mode="format-beams">
    <variable name="yValues" as="xs:double+">
      <apply-templates select="." mode="get-optimized-beam-y-values"/>
    </variable>
    <musx:beam y1="S{$yValues[1]}" y2="S{$yValues[2]}">
<!--    <musx:beam y1="$yValues[1]" y2="$yValues[2]">-->
      <apply-templates select="@*[not(local-name()=('y1','y2'))]|node()" mode="format-beams"/>
    </musx:beam>
  </template>
  
  <template match="musx:beam" mode="get-optimized-beam-y-values">
    <param name="recursion" select="0" as="xs:integer"/>
    <param name="direction" select="g:direction(.)" as="xs:integer"/>
    <param name="beamStems" select="key('beamStems',@xml:id)" as="node()+"/>
    <param name="staffSize" select="g:staffSize(.)" as="xs:double"/>
    <param name="x" select="g:x($beamStems)" as="xs:double+"/>
    <param name="indexList" as="xs:integer+">
      <variable name="stemIDs" select="for $stem in $beamStems return generate-id($stem)" as="xs:string*"/>
      <sequence select="for $id in $stemIDs return index-of($stemIDs,$id)"/>
    </param> 
    <!-- To make things simpler, we're "mirroring" beams that are pointing up so that we always 
         handle beams that are pointing down (direction=1). The mirrored y values may be outside the page, 
         which doesn't matter as eventually, we'll be mirroring back. -->
    <!-- For each stem, find the noteY value that's closest to the beam -->
    <param name="noteY" select="for $stem in $beamStems
                                return max(
                                  for $note in $stem/../descendant-or-self::musx:note
                                  return $direction * g:y($note)
                                )" as="xs:double+" />
    <param name="idealY" select="for $i in $indexList
                                 return $noteY[$i] + $staffSize * g:defaultStemLength($beamStems[$i])" as="xs:double+"/>
    <param name="s" select="0" as="xs:double"/>
    <param name="t" select="max($idealY)" as="xs:double"/>
    <!-- QUESTION: Is calcualtion of closestD correct like this? -->
    <param name="closestD" select="for $i in $indexList
                                   return $noteY[$i] - $idealY[$i] + $staffSize*$closestDistanceToNotehead" as="xs:double*"/>
    <param name="d" select="for $i in $indexList
                            return $s*$x[$i]+$t - $idealY[$i]" as="xs:double*"/>
    <!-- As in the first iteration, we know that there are no negative values in $d, we can simplify the penalty calculation. 
         This value is only calculated in the first iteration and passed on to subsequent iterations. -->
    <param name="maxPenalty" select="sum(
        for $di in $d
        return $di*$di 
      )" as="xs:double"/>
    <param name="slopePenaltyCoefficient" select="2*$maxPenalty div ($upperBoundForSlope * $upperBoundForSlope)" as="xs:double"/>
    <!--<param name="slopePenaltyCoefficient" select="0" as="xs:double"/>-->
    <param name="a" select="for $Tolerance in $distanceTolerance*$staffSize,
                                $i in $indexList,
                                $closestD-Tolerance in $closestD[$i] - $Tolerance
                            return ($closestD-Tolerance*$closestD-Tolerance - $maxPenalty)
                                   div
                                   ($closestD-Tolerance*$closestD-Tolerance*$closestD-Tolerance*$Tolerance)" as="xs:double*"/>
    <!-- coefficients needed in the Jacobian matrix -->
    <variable name="j" select="for $i in $indexList,
                                   $di in $d[$i]
                               return $di*(2+ (if($di lt 0) 
                                               then $a[$i]*$di*(4*$di - 3*$closestD[$i]) 
                                               else 0
                                              )
                                          )" as="xs:double*"/>
    <!-- coefficients needed in the Hessian matrix -->
    <variable name="h" select="for $i in $indexList,
                                   $di in $d[$i]
                               return 2 + (if($di lt 0)
                                           then 6*$a[$i]*$di*(2*$di - $closestD[$i])
                                           else 0
                                          )" as="xs:double*"/>
    <!-- Elements of the Jacobian matrix -->
    <variable name="Js" select="sum( 
                                  for $i in $indexList
                                  return $x[$i]*$j[$i]
                                ) + $slopePenaltyCoefficient * $s" as="xs:double"/>
    <variable name="Jt" select="sum($j)" as="xs:double"/>
    <!-- Elements of the Hessian Matrix -->
    <variable name="Hss" select="sum(
                                   for $i in $indexList
                                   return $x[$i]*$x[$i]*$h[$i]
                                 ) + $slopePenaltyCoefficient" as="xs:double"/>
    <variable name="Hst" select="sum(
                                   for $i in $indexList
                                   return $x[$i]*$h[$i]
                                 )" as="xs:double"/>
    <variable name="Htt" select="sum($h)" as="xs:double"/>
    
    <variable name="hesseDeterminant" select="$Hss*$Htt - $Hst*$Hst" as="xs:double"/>
    <variable name="nextS" select="$s - ($Htt*$Js - $Hst*$Jt) div $hesseDeterminant" as="xs:double"/>
    <variable name="nextT" select="$t - ($Hss*$Jt - $Hst*$Js) div $hesseDeterminant" as="xs:double"/>
    
    <message terminate="no">
      s = <value-of select="$s"/>
      t = <value-of select="$t"/>
      <if test="$recursion=0">
      $noteY = <value-of select="$noteY"/>
      $idealY = <value-of select="$idealY"/>
      $closestD = <value-of select="$closestD"/>
      $d = <value-of select="$d"/>
      $maxPenalty = <value-of select="$maxPenalty"/>
      $a = <value-of select="$a"/>
      $j = <value-of select="$j"/>
      $h = <value-of select="$h"/>
      $slopePenaltyCoefficient = <value-of select="$slopePenaltyCoefficient"/>
      $Js = <value-of select="$Js"/>
      $Jt = <value-of select="$Jt"/>
      $Hss = <value-of select="$Hss"/>
      $Hst = <value-of select="$Hst"/>
      $Htt = <value-of select="$Htt"/>
      </if>
    </message>
    
    <choose>
      <!-- TODO: Find good stop criterion other than a fixed number of recursions.
                 It should be based on the penalty or the quotient ration of $s and $nextS -->
      <when test="$recursion ge $maxBeamOptimizationRecursions">
      <message>
        finalS = <value-of select="$nextS"/>
        finalT = <value-of select="$nextT"/>
      </message>
        <variable name="staffY" select="g:y(ancestor::musx:staff[1])" as="xs:double"/>
        <sequence select="for $x in ($x[1],$x[last()])
                          return ($direction*($nextS * $x + $nextT) - $staffY) div $staffSize"/>
      </when>
      <otherwise>
        <apply-templates select="." mode="get-optimized-beam-y-values">
          <with-param name="recursion" select="$recursion + 1" as="xs:integer"/>
          <with-param name="s" select="$nextS" as="xs:double"/>
          <with-param name="t" select="$nextT" as="xs:double"/>
          
          <with-param name="a" select="$a"/>
          <with-param name="direction" select="$direction"/>
          <with-param name="x" select="$x" as="xs:double*"/>
          <with-param name="indexList" select="$indexList" as="xs:integer*"/>
          <with-param name="idealY" select="$idealY" as="xs:double*"/>
          <with-param name="closestD" select="$closestD" as="xs:double*"/>
          <with-param name="maxPenalty" select="$maxPenalty" as="xs:double"/>
          <with-param name="slopePenaltyCoefficient" select="$slopePenaltyCoefficient" as="xs:double"/>
        </apply-templates>
      </otherwise>
    </choose>
<!--    <variable name="staffY" select="g:y(ancestor::musx:staff[1])" as="xs:double"/>
    <sequence select="for $x in ($x[1],$x[last()])
      return $direction*($s * $x + $t)"/>-->
  </template>
  
</stylesheet>