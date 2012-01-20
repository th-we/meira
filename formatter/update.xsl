<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:update="NS:UPDATE"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <key name="update:attribute" match="update:attribute" use="@element"/>
  
  <template match="@*|node()" mode="update">
    <param name="updateTree" as="node()*"/>
    <copy>
      <apply-templates select="@*|node()" mode="update">
        <with-param name="updateTree" select="$updateTree" as="node()*"/>
      </apply-templates>
      <!-- QUESTION: Why doesn't this work? -->
<!--      <apply-templates select="key('update:attribute',generate-id(),$updateTree)"/>-->
      <for-each select="key('update:attribute',generate-id(),$updateTree)">
        <attribute name="{@name}">
          <value-of select="@value"/>
        </attribute>
      </for-each>
    </copy>
  </template>
  
<!-- Doesn't seem to work by applying a template
  <template match="update:attribute">
    <message>matched</message>
    <attribute name="{@name}">
      <value-of select="@value"/>
    </attribute>
  </template>-->
</stylesheet>