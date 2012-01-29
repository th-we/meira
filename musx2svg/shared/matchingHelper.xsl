<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform-alternate"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:def="NS:DEF"
    xmlns:g="NS:GET">
  <namespace-alias stylesheet-prefix="xsl" result-prefix=""/>
 
  <!-- Define prefix in a function because other templates can't access
       a variable that's defined here, can they? -->
  <function name="g:musxPrefix">
    <value-of select="'musx:'"/>
  </function>
  
  <function name="g:createKeyName">
    <param name="popertyName"/>
    <param name="matchingElementNames"/>
    
    <value-of select="concat('get_',$popertyName,'_')"/>
    <value-of select="$matchingElementNames" separator="_"/>
  </function>
  
  <template name="createKeyElement">
    <param name="elementNames"/>
    <xsl:key name="{g:createKeyName(@name,$elementNames)}" use="substring(@{@name},1,1)">
      <attribute name="match">
        <value-of select="g:matchPattern($elementNames)"/>
      </attribute>
    </xsl:key>
  </template>
  
  <function name="g:matchPattern">
    <param name="elementNames"/>
    
    <value-of select="g:matchPattern($elementNames,'')"/>
  </function>
  
  <function name="g:matchPattern">
    <param name="elementNames"/>
    <param name="condition"/>
    
    <variable name="prefix" select="g:musxPrefix()"/>
    
    <value-of select="$prefix"/>
    <value-of select="$elementNames" separator="{$condition}|{g:musxPrefix()}"/>
    <value-of select="$condition"/>
  </function>
  
</stylesheet>