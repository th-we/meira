<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0" 
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:mei="http://www.music-encoding.org/ns/mei">
  
  <template match="/" priority="-10">
    <apply-templates select="." mode="anyuri2idref"/>
  </template>
  
  <template match="@*|node()" mode="anyuri2idref">
    <copy>
      <apply-templates select="@*|node()" mode="anyuri2idref"/>
    </copy>
  </template>
  
  <!-- We turn the syntax of @plist, @startid and @endid from official 
       anyURI to IDREF because it saves us trouble later not having to deal with the hash.
       CAUTION: This creates invalid MEI and is only useful inside mei2musx -->
  
  <template match="@plist|@startid|@endid" mode="anyuri2idref">
    <attribute name="{name()}">
      <value-of select="for $token in tokenize(.,'\s+')
                        return replace($token,'^#','')"/>
    </attribute>
  </template>
</stylesheet>