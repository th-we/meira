<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="1.0" 
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:mei="http://www.music-encoding.org/ns/mei">
  
  <key name="contentChronology" use="'seeParent'" 
    match="mei:unclear|mei:damage|mei:del|mei:add|mei:supplied|mei:sic[not(parent::mei:choice or parent::mei:app)]"/>
  <key name="contentChronology" use="'seeGrandparent'"
    match="mei:lem|mei:rdg|mei:abbr|mei:corr|mei:expan|mei:orig|mei:reg|mei:sic[parent::mei:choice or parent::mei:app]"/>
  <key name="contentChronology" use="'sequential'" 
    match="mei:score|mei:part|mei:ending|mei:layer|mei:beam|mei:tuplet|mei:body|mei:section|mei:uneume|mei:ineume|mei:syllable"/>
  <key name="contentChronology" use="'synchronous'" 
    match="mei:staff|mei:chord|mei:app|mei:choice|mei:fTrem|mei:bTrem|mei:mdiv|mei:parts|mei:measure"/>
  
</stylesheet>