<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:musx="NS:MUSX">
  
  <key name="clefsByStartEventId" match="musx:clef" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="timeSignaturesByStartEventId" match="musx:timeSignature" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="keySignaturesByStartEventId" match="musx:keySignature" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="barlinesByStartEventId" match="musx:barline" use="(ancestor-or-self::*/@start)[last()]"/>
  
  <template match="/" priority="-10">
    <apply-templates select="." mode="create-subevents"/>
  </template>
  
  <template match="@*|node()" mode="create-subevents">
    <copy>
      <apply-templates select="@*|node()" mode="create-subevents"/>
    </copy>
  </template>
  
  <template match="musx:event" mode="create-subevents">
    <apply-templates select="key('clefsByStartEventId',@xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('barlinesByStartEventId',@xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('keySignaturesByStartEventId',@xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('timeSignaturesByStartEventId',@xml:id)[1]" mode="add-subevent"/>
    <copy-of select="."/>
  </template>
  
  <template match="musx:*" mode="add-subevent">
    <musx:event>
      <copy-of select="id((ancestor-or-self::*/@start)[last()])/@*"/>
      <attribute name="xml:id">
        <value-of select="concat((ancestor-or-self::*/@start)[last()],'_',local-name())"/>
      </attribute>
    </musx:event>
  </template>
  
  <template match="musx:clef|musx:barline|musx:keySignature|musx:timeSignature" mode="create-subevents">
    <copy>
      <copy-of select="@*"/>
      <attribute name="start">
        <value-of select="concat((ancestor-or-self::*/@start)[last()],'_',local-name())"/>
      </attribute>
      <apply-templates select="node()" mode="create-subevents"/>
    </copy>
  </template>
</stylesheet>