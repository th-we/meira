<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:musx="NS:MUSX"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <key name="clefsByStartEventId" match="musx:clef" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="timeSignaturesByStartEventId" match="musx:timeSignature" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="keySignaturesByStartEventId" match="musx:keySignature" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="staffsByStartEventId" match="musx:staff" use="(ancestor-or-self::*/@start)[last()]"/>
  <key name="staffsByEndEventId" match="musx:staff" use="(ancestor-or-self::*/@end)[last()]"/>
  <key name="barlinesByStartEventId" match="musx:barline" use="(ancestor-or-self::*/@start)[last()]"/>
<!--  <key name="barlinesByStartEventId" match="musx:barline[not(key('staffsByStartEventId',(ancestor-or-self::*/@start))[last()])]" 
    use="(ancestor-or-self::*/@start)[last()]"/>
-->
  
  <template match="/" priority="-10">
    <apply-templates select="." mode="create-subevents"/>
  </template>
  
  <template match="@*|node()" mode="create-subevents">
    <copy>
      <apply-templates select="@*|node()" mode="create-subevents"/>
    </copy>
  </template>
  
  <template match="musx:event" mode="create-subevents">
    <apply-templates select="key('staffsByEndEventId',          @xml:id)[1]" mode="add-subevent">
      <with-param name="suffix" select="'staff_end'"/>
      <with-param name="eventReference" select="@xml:id"/>
    </apply-templates>
    <apply-templates select="key('staffsByStartEventId',        @xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('clefsByStartEventId',         @xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('barlinesByStartEventId',      @xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('keySignaturesByStartEventId', @xml:id)[1]" mode="add-subevent"/>
    <apply-templates select="key('timeSignaturesByStartEventId',@xml:id)[1]" mode="add-subevent"/>
    <copy-of select="."/>
  </template>
  
  <template match="musx:*" mode="add-subevent">
    <param name="suffix" select="local-name()" as="xs:string"/>
    <param name="eventReference" select="(ancestor-or-self::*/@start)[last()]" as="xs:string"/>
    <musx:event>
      <copy-of select="id($eventReference)/@*"/>
      <attribute name="xml:id">
        <value-of select="concat($eventReference,'_',$suffix)"/>
      </attribute>
    </musx:event>
  </template>
  
  <template match="musx:clef|musx:barline|musx:keySignature|musx:timeSignature|musx:staff" mode="create-subevents">
    <copy>
      <copy-of select="@*"/>
      <attribute name="start">
        <value-of select="concat((ancestor-or-self::*/@start)[last()],'_',local-name())"/>
      </attribute>
      <apply-templates select="." mode="create-special-startend-attributes"/>
      <apply-templates select="node()" mode="create-subevents"/>
    </copy>
  </template>
  
  <template match="*" mode="create-special-startend-attributes"/>
  <template match="musx:staff" mode="create-special-startend-attributes">
    <attribute name="end">
      <value-of select="concat((ancestor-or-self::*/@end)[last()],'_staff_end')"/>
    </attribute>
  </template>
  <template match="musx:barline[key('staffsByEndEventId',(ancestor-or-self::*/@start)[last()])]" mode="create-special-startend-attributes">
    <attribute name="start">
      <value-of select="concat((ancestor-or-self::*/@start)[last()],'_staff_end')"/>
    </attribute>
  </template>
  <template match="musx:barline[@function='systemic']" mode="create-special-startend-attributes" priority="1">
    <attribute name="start">
      <value-of select="concat((ancestor-or-self::*/@start)[last()],'_staff')"/>
    </attribute>
  </template>
</stylesheet>