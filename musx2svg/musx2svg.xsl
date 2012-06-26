<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns="http://www.w3.org/1999/XSL/Transform-alternate"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:def="NS:DEF"
                xmlns:g="NS:GET"
                xmlns:musx="NS:MUSX"
                xmlns:xsb="http://www.expedimentum.org/XSLT/SB"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"
                exclude-result-prefixes="xs def g musx svg">
   <xsl:import href="math/math.xsl"/>
   <xsl:param name="libDirectory"
              select="if (/musx:musx) then /musx:musx/musx:musxHead/musx:libDirectory/@xlink:href else 'lib'"
              as="xs:string"/>
   <xsl:param name="musicFont" select="'musicSymbols'" as="xs:string"/>
   <xsl:param name="symbolFile" select="'symbols.svg'" as="xs:string"/>
   <xsl:key name="class" match="*" use="tokenize(@class,'\s+')"/>
   <xsl:key name="elements-by-staff-and-start-event" match="*"
            use="concat(ancestor::musx:staff[1]/generate-id(),'$',g:start(.)/generate-id())"/>
   <xsl:template mode="get-start-event" match="*">
      <xsl:message>
          find start event of <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/>
      </xsl:message>
      <xsl:variable name="potentialStartEvent" as="element()*">
         <xsl:apply-templates select="g:start(.)" mode="get-start-event"/>
      </xsl:variable>
      <xsl:if test="generate-id($potentialStartEvent) != generate-id()">
         <xsl:sequence select="$potentialStartEvent"/>
      </xsl:if>
   </xsl:template>
   <xsl:template mode="get-start-event" match="musx:event">
      <xsl:message>
          found start event <xsl:value-of select="@xml:id"/>
      </xsl:message>
      <xsl:sequence select="."/>
   </xsl:template>
   <xsl:function name="g:end" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_end"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:x1" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_x1"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:x2" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_x2"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:y" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_y"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:x" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_x"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:y1" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_y1"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:y2" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_y2"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:size" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_size"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:start" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_start"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:lines" as="xs:integer*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:integer*">
         <xsl:apply-templates select="$elements" mode="get_lines"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:symbol" as="xs:string*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:string*">
         <xsl:apply-templates select="$elements" mode="get_symbol"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:placement" as="xs:string*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:string*">
         <xsl:apply-templates select="$elements" mode="get_placement"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="''"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:width" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_width"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:direction" as="xs:integer*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:integer*">
         <xsl:apply-templates select="$elements" mode="get_direction"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:step" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_step"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:topStaff" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_topStaff"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:bottomStaff" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_bottomStaff"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:brackettip" as="xs:string*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:string*">
         <xsl:apply-templates select="$elements" mode="get_brackettip"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:lineOffset" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_lineOffset"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:dotOffset" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_dotOffset"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:dotRadius" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_dotRadius"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:lineWidth" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_lineWidth"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:boldLineWidth" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_boldLineWidth"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:type" as="xs:string*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:string*">
         <xsl:apply-templates select="$elements" mode="get_type"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="''"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:function" as="xs:string*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:string*">
         <xsl:apply-templates select="$elements" mode="get_function"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="''"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:ledgerLines.direction" as="xs:integer*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:integer*">
         <xsl:apply-templates select="$elements" mode="get_ledgerLines.direction"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:ledgerLines.y1" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_ledgerLines.y1"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:ledgerLines.y2" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_ledgerLines.y2"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:ledgerLines.draw" as="xs:boolean*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:boolean*">
         <xsl:apply-templates select="$elements" mode="get_ledgerLines.draw"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="true()"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:ledgerLines.protrusion" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_ledgerLines.protrusion"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:flip" as="xs:integer*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:integer*">
         <xsl:apply-templates select="$elements" mode="get_flip"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:topNote" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_topNote"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:bottomNote" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_bottomNote"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:beam" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_beam"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:length" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_length"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:number" as="xs:integer*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:integer*">
         <xsl:apply-templates select="$elements" mode="get_number"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:offset" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_offset"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:distance" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_distance"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:radius" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_radius"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:startSpread" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_startSpread"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:endSpread" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_endSpread"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:slurNotes" as="node()*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="node()*">
         <xsl:apply-templates select="$elements" mode="get_slurNotes"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="$elements/.."/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:maxHeight" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_maxHeight"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:height" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_height"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:centerThickness" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_centerThickness"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:tipThickness" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_tipThickness"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:swellingRate" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_swellingRate"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:swellingRate1" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_swellingRate1"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:swellingRate2" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_swellingRate2"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:tilt" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_tilt"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:shift" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_shift"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:shoulder" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_shoulder"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:curvature" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_curvature"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:curvature1" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_curvature1"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:curvature2" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_curvature2"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:tipAngle" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_tipAngle"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:tipAngle1" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_tipAngle1"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:tipAngle2" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_tipAngle2"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:textAnchor" as="xs:double*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:double*">
         <xsl:apply-templates select="$elements" mode="get_textAnchor"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:function name="g:pattern" as="xs:string*">
      <xsl:param name="elements" as="element()*"/>
      <xsl:variable name="result" as="xs:string*">
         <xsl:apply-templates select="$elements" mode="get_pattern"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($result) != 0">
            <xsl:sequence select="$result"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="''"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   <xsl:template mode="get_end" match="musx:page" priority="-1">
      <xsl:sequence select="."/>
   </xsl:template>
   <xsl:template mode="get_end" match="musx:page[@end]">
      <xsl:variable name="referencedElement" select="id(@end)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@end"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_x1_page" use="substring(@x1,1,1)" match="musx:page"/>
   <xsl:template mode="get_x1" match="musx:page" priority="-2">
      <xsl:copy-of select="(0) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="musx:page[@x1]" priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_page','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(0) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_page','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_page','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(0) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_x2_page_system_staff_staffGroup_rest_group_hairpin"
            use="substring(@x2,1,1)"
            match="musx:page|musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin"/>
   <xsl:template mode="get_x2"
                 match="musx:page|musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin"
                 priority="-2">
      <xsl:copy-of select="(g:x(g:end(.))) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="musx:page[@x2]|musx:system[@x2]|musx:staff[@x2]|musx:staffGroup[@x2]|musx:rest[@x2]|musx:group[@x2]|musx:hairpin[@x2]"
                 priority="-1">
      <xsl:copy-of select="number(@x2)"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="key('get_x2_page_system_staff_staffGroup_rest_group_hairpin','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:end(.))) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="key('get_x2_page_system_staff_staffGroup_rest_group_hairpin','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="key('get_x2_page_system_staff_staffGroup_rest_group_hairpin','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:end(.))) + (g:size($staff) * number(substring(@x2,2)))"/>
   </xsl:template>
   <xsl:key name="get_y_page" use="substring(@y,1,1)" match="musx:page"/>
   <xsl:template mode="get_y" match="musx:page" priority="-2">
      <xsl:copy-of select="(0) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:page[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_page','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(0) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_page','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_page','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(0) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_page','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_page','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_x_page_event" use="substring(@x,1,1)" match="musx:page|musx:event"/>
   <xsl:template mode="get_x" match="musx:page|musx:event" priority="-2">
      <xsl:copy-of select="(0) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:page[@x]|musx:event[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_page_event','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(0) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_page_event','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_page_event','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(0) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_y1_page" use="substring(@y1,1,1)" match="musx:page"/>
   <xsl:template mode="get_y1" match="musx:page" priority="-2">
      <xsl:copy-of select="(0) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="musx:page[@y1]" priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_page','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(0) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_page','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_page','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(0) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_page','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_page','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_page" use="substring(@y2,1,1)" match="musx:page"/>
   <xsl:template mode="get_y2" match="musx:page" priority="-2">
      <xsl:copy-of select="(0) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:page[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_page','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(0) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_page','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_page','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(0) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_page','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_page','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_size_page" use="substring(@size,1,1)" match="musx:page"/>
   <xsl:template mode="get_size" priority="-2" match="musx:page">
      <xsl:copy-of select="(1) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_size" match="musx:page[@size]" priority="-1">
      <xsl:copy-of select="number(@size)"/>
   </xsl:template>
   <xsl:template mode="get_size" match="key('get_size_page','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@size,2))"/>
   </xsl:template>
   <xsl:template mode="get_size" match="key('get_size_page','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@size,2))"/>
   </xsl:template>
   <xsl:template mode="get_start"
                 match="musx:system|musx:svg|musx:clef|musx:rest|musx:barline|musx:note|musx:chord|musx:beam|musx:hairpin|musx:slur|musx:symbolText|musx:keySignature|musx:timeSignature|musx:articulation"
                 priority="-1">
      <xsl:sequence select=".."/>
   </xsl:template>
   <xsl:template mode="get_start"
                 match="musx:system[@start]|musx:svg[@start]|musx:clef[@start]|musx:rest[@start]|musx:barline[@start]|musx:note[@start]|musx:chord[@start]|musx:beam[@start]|musx:hairpin[@start]|musx:slur[@start]|musx:symbolText[@start]|musx:keySignature[@start]|musx:timeSignature[@start]|musx:articulation[@start]">
      <xsl:variable name="referencedElement" select="id(@start)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@start"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template mode="get_end" match="musx:system|musx:beam|musx:slur" priority="-1">
      <xsl:sequence select=".."/>
   </xsl:template>
   <xsl:template mode="get_end" match="musx:system[@end]|musx:beam[@end]|musx:slur[@end]">
      <xsl:variable name="referencedElement" select="id(@end)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@end"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_x1_system_staff_staffGroup_rest_group_hairpin"
            use="substring(@x1,1,1)"
            match="musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin"/>
   <xsl:template mode="get_x1"
                 match="musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin"
                 priority="-2">
      <xsl:copy-of select="(g:x(g:start(.))) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="musx:system[@x1]|musx:staff[@x1]|musx:staffGroup[@x1]|musx:rest[@x1]|musx:group[@x1]|musx:hairpin[@x1]"
                 priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="key('get_x1_system_staff_staffGroup_rest_group_hairpin','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="key('get_x1_system_staff_staffGroup_rest_group_hairpin','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="key('get_x1_system_staff_staffGroup_rest_group_hairpin','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation"
            use="substring(@y,1,1)"
            match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:group|musx:note|musx:head|musx:accidental|musx:hairpin|musx:keySignature|musx:fraction|musx:articulation"/>
   <xsl:template mode="get_y"
                 match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:group|musx:note|musx:head|musx:accidental|musx:hairpin|musx:keySignature|musx:fraction|musx:articulation"
                 priority="-2">
      <xsl:copy-of select="(g:y(..)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="musx:system[@y]|musx:staff[@y]|musx:staffGroup[@y]|musx:svg[@y]|musx:clef[@y]|musx:group[@y]|musx:note[@y]|musx:head[@y]|musx:accidental[@y]|musx:hairpin[@y]|musx:keySignature[@y]|musx:fraction[@y]|musx:articulation[@y]"
                 priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur"
            use="substring(@x,1,1)"
            match="musx:system|musx:staff|musx:staffGroup|musx:group|musx:beam|musx:subbeam|musx:hairpin|musx:slur"/>
   <xsl:template mode="get_x"
                 match="musx:system|musx:staff|musx:staffGroup|musx:group|musx:beam|musx:subbeam|musx:hairpin|musx:slur"
                 priority="-2">
      <xsl:copy-of select="(g:x1(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="musx:system[@x]|musx:staff[@x]|musx:staffGroup[@x]|musx:group[@x]|musx:beam[@x]|musx:subbeam[@x]|musx:hairpin[@x]|musx:slur[@x]"
                 priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x1(.)) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x1(.)) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation"
            use="substring(@y1,1,1)"
            match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <xsl:template mode="get_y1"
                 match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
                 priority="-2">
      <xsl:copy-of select="(g:y(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y1"
                 match="musx:system[@y1]|musx:staff[@y1]|musx:staffGroup[@y1]|musx:svg[@y1]|musx:clef[@y1]|musx:transposeNumber[@y1]|musx:rest[@y1]|musx:group[@y1]|musx:note[@y1]|musx:head[@y1]|musx:accidental[@y1]|musx:flags[@y1]|musx:dots[@y1]|musx:beam[@y1]|musx:hairpin[@y1]|musx:symbolText[@y1]|musx:keySignature[@y1]|musx:timeSignature[@y1]|musx:fraction[@y1]|musx:articulation[@y1]"
                 priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1"
                 match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(.)) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1"
                 match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1"
                 match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(.)) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1"
                 match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1"
                 match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation"
            use="substring(@y2,1,1)"
            match="musx:system|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <xsl:template mode="get_y2"
                 match="musx:system|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
                 priority="-2">
      <xsl:copy-of select="(g:y(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y2"
                 match="musx:system[@y2]|musx:staffGroup[@y2]|musx:svg[@y2]|musx:clef[@y2]|musx:transposeNumber[@y2]|musx:rest[@y2]|musx:group[@y2]|musx:note[@y2]|musx:head[@y2]|musx:accidental[@y2]|musx:flags[@y2]|musx:dots[@y2]|musx:beam[@y2]|musx:hairpin[@y2]|musx:symbolText[@y2]|musx:keySignature[@y2]|musx:timeSignature[@y2]|musx:fraction[@y2]|musx:articulation[@y2]"
                 priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2"
                 match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(.)) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2"
                 match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2"
                 match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(.)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2"
                 match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2"
                 match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_size_system_staff_staffGroup_svg_clef_rest_group_staffBracket_barline_note_head_accidental_chord_stem_flags_dots_beam_subbeam_hairpin_slur_symbolText_keySignature_timeSignature_fraction_articulation"
            use="substring(@size,1,1)"
            match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:rest|musx:group|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:dots|musx:beam|musx:subbeam|musx:hairpin|musx:slur|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <xsl:template mode="get_size" priority="-2"
                 match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:rest|musx:group|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:dots|musx:beam|musx:subbeam|musx:hairpin|musx:slur|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation">
      <xsl:copy-of select="(g:size(..)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_size"
                 match="musx:system[@size]|musx:staff[@size]|musx:staffGroup[@size]|musx:svg[@size]|musx:clef[@size]|musx:rest[@size]|musx:group[@size]|musx:staffBracket[@size]|musx:barline[@size]|musx:note[@size]|musx:head[@size]|musx:accidental[@size]|musx:chord[@size]|musx:stem[@size]|musx:flags[@size]|musx:dots[@size]|musx:beam[@size]|musx:subbeam[@size]|musx:hairpin[@size]|musx:slur[@size]|musx:symbolText[@size]|musx:keySignature[@size]|musx:timeSignature[@size]|musx:fraction[@size]|musx:articulation[@size]"
                 priority="-1">
      <xsl:copy-of select="number(@size)"/>
   </xsl:template>
   <xsl:template mode="get_size"
                 match="key('get_size_system_staff_staffGroup_svg_clef_rest_group_staffBracket_barline_note_head_accidental_chord_stem_flags_dots_beam_subbeam_hairpin_slur_symbolText_keySignature_timeSignature_fraction_articulation','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@size,2))"/>
   </xsl:template>
   <xsl:template mode="get_size"
                 match="key('get_size_system_staff_staffGroup_svg_clef_rest_group_staffBracket_barline_note_head_accidental_chord_stem_flags_dots_beam_subbeam_hairpin_slur_symbolText_keySignature_timeSignature_fraction_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@size,2))"/>
   </xsl:template>
   <xsl:template mode="get_start" match="musx:staff|musx:staffGroup|musx:group|musx:subbeam"
                 priority="-1">
      <xsl:sequence select="g:start(..)"/>
   </xsl:template>
   <xsl:template mode="get_start"
                 match="musx:staff[@start]|musx:staffGroup[@start]|musx:group[@start]|musx:subbeam[@start]">
      <xsl:variable name="referencedElement" select="id(@start)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@start"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template mode="get_end" match="musx:staff|musx:staffGroup|musx:group|musx:subbeam"
                 priority="-1">
      <xsl:sequence select="g:end(..)"/>
   </xsl:template>
   <xsl:template mode="get_end"
                 match="musx:staff[@end]|musx:staffGroup[@end]|musx:group[@end]|musx:subbeam[@end]">
      <xsl:variable name="referencedElement" select="id(@end)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@end"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_y2_staff" use="substring(@y2,1,1)" match="musx:staff"/>
   <xsl:template mode="get_y2" match="musx:staff" priority="-2">
      <xsl:copy-of select="(g:y1(.)) + (2 * g:size(.) * (g:lines(.) - 1))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:staff[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staff','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y1(.)) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staff','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staff','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1(.)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staff','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staff','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:template mode="get_lines" match="musx:staff" priority="-1">
      <xsl:copy-of select="5"/>
   </xsl:template>
   <xsl:template mode="get_lines" match="musx:staff[@lines]">
      <xsl:copy-of select="@lines cast as xs:integer"/>
   </xsl:template>
   <xsl:key name="get_x_svg_clef_barline_note_chord_keySignature_timeSignature"
            use="substring(@x,1,1)"
            match="musx:svg|musx:clef|musx:barline|musx:note|musx:chord|musx:keySignature|musx:timeSignature"/>
   <xsl:template mode="get_x"
                 match="musx:svg|musx:clef|musx:barline|musx:note|musx:chord|musx:keySignature|musx:timeSignature"
                 priority="-2">
      <xsl:copy-of select="(g:x(g:start(.))) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="musx:svg[@x]|musx:clef[@x]|musx:barline[@x]|musx:note[@x]|musx:chord[@x]|musx:keySignature[@x]|musx:timeSignature[@x]"
                 priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_svg_clef_barline_note_chord_keySignature_timeSignature','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_svg_clef_barline_note_chord_keySignature_timeSignature','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_svg_clef_barline_note_chord_keySignature_timeSignature','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation"
            use="substring(@x1,1,1)"
            match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <xsl:template mode="get_x1"
                 match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
                 priority="-2">
      <xsl:copy-of select="(g:x(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="musx:svg[@x1]|musx:clef[@x1]|musx:transposeNumber[@x1]|musx:staffBracket[@x1]|musx:barline[@x1]|musx:note[@x1]|musx:head[@x1]|musx:accidental[@x1]|musx:chord[@x1]|musx:stem[@x1]|musx:flags[@x1]|musx:keySignature[@x1]|musx:timeSignature[@x1]|musx:fraction[@x1]|musx:articulation[@x1]"
                 priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="key('get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="key('get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1"
                 match="key('get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation"
            use="substring(@x2,1,1)"
            match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <xsl:template mode="get_x2"
                 match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
                 priority="-2">
      <xsl:copy-of select="(g:x(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="musx:svg[@x2]|musx:clef[@x2]|musx:transposeNumber[@x2]|musx:staffBracket[@x2]|musx:barline[@x2]|musx:note[@x2]|musx:head[@x2]|musx:accidental[@x2]|musx:chord[@x2]|musx:stem[@x2]|musx:flags[@x2]|musx:keySignature[@x2]|musx:timeSignature[@x2]|musx:fraction[@x2]|musx:articulation[@x2]"
                 priority="-1">
      <xsl:copy-of select="number(@x2)"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="key('get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="key('get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2"
                 match="key('get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:clef|musx:timeSignature" priority="-1">
      <xsl:value-of select="concat($libDirectory,'/',$symbolFile,'#','clef.G')"/>
   </xsl:template>
   <xsl:template mode="get_symbol"
                 match="musx:clef[contains(@symbol,'.')]|musx:timeSignature[contains(@symbol,'.')]"
                 priority="2">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:clef[@symbol]|musx:timeSignature[@symbol]">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_OwnBoundingBox" match="musx:clef|musx:timeSignature" priority="-1">
      <xsl:variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <xsl:if test="$symbolBBox">
         <xsl:variable name="size" select="g:size(.)"/>
         <xsl:variable name="x" select="g:x(.)"/>
         <xsl:variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </xsl:if>
   </xsl:template>
   <xsl:key name="get_x_transposeNumber_staffBracket_flags_dots_fraction"
            use="substring(@x,1,1)"
            match="musx:transposeNumber|musx:staffBracket|musx:flags|musx:dots|musx:fraction"/>
   <xsl:template mode="get_x"
                 match="musx:transposeNumber|musx:staffBracket|musx:flags|musx:dots|musx:fraction"
                 priority="-2">
      <xsl:copy-of select="(g:x(..)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="musx:transposeNumber[@x]|musx:staffBracket[@x]|musx:flags[@x]|musx:dots[@x]|musx:fraction[@x]"
                 priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_transposeNumber_staffBracket_flags_dots_fraction','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_transposeNumber_staffBracket_flags_dots_fraction','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x"
                 match="key('get_x_transposeNumber_staffBracket_flags_dots_fraction','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_y_transposeNumber" use="substring(@y,1,1)"
            match="musx:transposeNumber"/>
   <xsl:template mode="get_y" match="musx:transposeNumber" priority="-2">
      <xsl:copy-of select="(       if(g:placement(.)='above')         then g:OwnBoundingBox(..)//@top         else g:OwnBoundingBox(..)//@bottom + g:size(.)       ) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:transposeNumber[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_transposeNumber','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(       if(g:placement(.)='above')         then g:OwnBoundingBox(..)//@top         else g:OwnBoundingBox(..)//@bottom + g:size(.)       ) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_transposeNumber','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_transposeNumber','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(       if(g:placement(.)='above')         then g:OwnBoundingBox(..)//@top         else g:OwnBoundingBox(..)//@bottom + g:size(.)       ) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_transposeNumber','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_transposeNumber','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:template mode="get_placement" match="musx:transposeNumber" priority="-1">
      <xsl:copy-of select="'top'"/>
   </xsl:template>
   <xsl:template mode="get_placement" match="musx:transposeNumber[@placement]">
      <xsl:copy-of select="@placement cast as xs:string"/>
   </xsl:template>
   <xsl:key name="get_size_transposeNumber" use="substring(@size,1,1)"
            match="musx:transposeNumber"/>
   <xsl:template mode="get_size" priority="-2" match="musx:transposeNumber">
      <xsl:copy-of select="(g:size(..)) * (4)"/>
   </xsl:template>
   <xsl:template mode="get_size" match="musx:transposeNumber[@size]" priority="-1">
      <xsl:copy-of select="number(@size)"/>
   </xsl:template>
   <xsl:template mode="get_size" match="key('get_size_transposeNumber','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@size,2))"/>
   </xsl:template>
   <xsl:template mode="get_size" match="key('get_size_transposeNumber','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@size,2))"/>
   </xsl:template>
   <xsl:template mode="get_end" match="musx:rest|musx:hairpin" priority="-1">
      <xsl:sequence select="g:start(.)"/>
   </xsl:template>
   <xsl:template mode="get_end" match="musx:rest[@end]|musx:hairpin[@end]">
      <xsl:variable name="referencedElement" select="id(@end)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@end"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_x_rest" use="substring(@x,1,1)" match="musx:rest"/>
   <xsl:template mode="get_x" match="musx:rest" priority="-2">
      <xsl:copy-of select="((g:x1(.) + g:x2(.)) div 2) + (if (@end or @x2)                                                                                     then g:width(.) div -2                                                                                     else 0)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:rest[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_rest','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="((g:x1(.) + g:x2(.)) div 2) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_rest','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_rest','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="((g:x1(.) + g:x2(.)) div 2) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_y_rest" use="substring(@y,1,1)" match="musx:rest"/>
   <xsl:template mode="get_y" match="musx:rest" priority="-2">
      <xsl:copy-of select="(g:y(..)) + (-4 * g:size(ancestor::staff))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:rest[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_rest','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_rest','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_rest','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_rest','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_rest','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_width_rest_head_articulation" use="substring(@width,1,1)"
            match="musx:rest|musx:head|musx:articulation"/>
   <xsl:template mode="get_width" priority="-2" match="musx:rest|musx:head|musx:articulation">
      <xsl:copy-of select="(g:size(.)) * (number(g:svgSymbolBoundingBox(g:symbol(.))//@right))"/>
   </xsl:template>
   <xsl:template mode="get_width"
                 match="musx:rest[@width]|musx:head[@width]|musx:articulation[@width]"
                 priority="-1">
      <xsl:copy-of select="number(@width)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_rest_head_articulation','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_rest_head_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:rest" priority="-1">
      <xsl:copy-of select="       if (musx:stem/@direction)       then g:direction(musx:stem[1])       else if (g:step(.) &lt; g:lines(ancestor::musx:staff[last()]))       then 1       else -1"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:rest[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_step" match="musx:rest" priority="-1">
      <xsl:copy-of select="       if(substring(@y,1,1)='S')       then number(substring(@y,2))       else (g:y(.) - g:y(ancestor::musx:staff[last()])) div g:staffSize(.)"/>
   </xsl:template>
   <xsl:template mode="get_step" match="musx:rest[@step]">
      <xsl:copy-of select="@step cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_symbol"
                 match="musx:rest|musx:accidental|musx:keySignature|musx:articulation"
                 priority="-1">
      <xsl:value-of select="concat($libDirectory,'/',$symbolFile,'#','')"/>
   </xsl:template>
   <xsl:template mode="get_symbol"
                 match="musx:rest[contains(@symbol,'.')]|musx:accidental[contains(@symbol,'.')]|musx:keySignature[contains(@symbol,'.')]|musx:articulation[contains(@symbol,'.')]"
                 priority="2">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_symbol"
                 match="musx:rest[@symbol]|musx:accidental[@symbol]|musx:keySignature[@symbol]|musx:articulation[@symbol]">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_OwnBoundingBox"
                 match="musx:rest|musx:accidental|musx:keySignature|musx:articulation"
                 priority="-1">
      <xsl:variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <xsl:if test="$symbolBBox">
         <xsl:variable name="size" select="g:size(.)"/>
         <xsl:variable name="x" select="g:x(.)"/>
         <xsl:variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </xsl:if>
   </xsl:template>
   <xsl:template mode="get_topStaff" match="musx:staffBracket|musx:barline" priority="-1">
      <xsl:sequence select="       (         for $staff in (ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff         return if (g:y($staff) &gt; g:y((ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff))           then ()           else $staff       )[1]"/>
   </xsl:template>
   <xsl:template mode="get_topStaff"
                 match="musx:staffBracket[@topStaff]|musx:barline[@topStaff]">
      <xsl:variable name="referencedElement" select="id(@topStaff)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@topStaff"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template mode="get_bottomStaff" match="musx:staffBracket|musx:barline" priority="-1">
      <xsl:sequence select="       (         for $staff in (ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff         return if (g:y($staff) &lt; g:y((ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff))           then ()           else $staff       )[1]"/>
   </xsl:template>
   <xsl:template mode="get_bottomStaff"
                 match="musx:staffBracket[@bottomStaff]|musx:barline[@bottomStaff]">
      <xsl:variable name="referencedElement" select="id(@bottomStaff)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@bottomStaff"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_y1_staffBracket_barline" use="substring(@y1,1,1)"
            match="musx:staffBracket|musx:barline"/>
   <xsl:template mode="get_y1" match="musx:staffBracket|musx:barline" priority="-2">
      <xsl:copy-of select="(g:y1(g:topStaff(.))) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="musx:staffBracket[@y1]|musx:barline[@y1]" priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_staffBracket_barline','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y1(g:topStaff(.))) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_staffBracket_barline','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_staffBracket_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1(g:topStaff(.))) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_staffBracket_barline','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_staffBracket_barline','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_staffBracket_barline" use="substring(@y2,1,1)"
            match="musx:staffBracket|musx:barline"/>
   <xsl:template mode="get_y2" match="musx:staffBracket|musx:barline" priority="-2">
      <xsl:copy-of select="(g:y2(g:bottomStaff(.))) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:staffBracket[@y2]|musx:barline[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staffBracket_barline','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y2(g:bottomStaff(.))) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staffBracket_barline','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staffBracket_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2(g:bottomStaff(.))) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staffBracket_barline','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_staffBracket_barline','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y_staffBracket_barline_chord_stem_subbeam_slur"
            use="substring(@y,1,1)"
            match="musx:staffBracket|musx:barline|musx:chord|musx:stem|musx:subbeam|musx:slur"/>
   <xsl:template mode="get_y"
                 match="musx:staffBracket|musx:barline|musx:chord|musx:stem|musx:subbeam|musx:slur"
                 priority="-2">
      <xsl:copy-of select="(g:y1(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="musx:staffBracket[@y]|musx:barline[@y]|musx:chord[@y]|musx:stem[@y]|musx:subbeam[@y]|musx:slur[@y]"
                 priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y1(.)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1(.)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y"
                 match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:template mode="get_brackettip" match="musx:staffBracket" priority="-1">
      <xsl:value-of select="concat($libDirectory,'/',$symbolFile,'#','brackettip')"/>
   </xsl:template>
   <xsl:template mode="get_brackettip" match="musx:staffBracket[contains(@brackettip,'.')]"
                 priority="2">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',@brackettip)"/>
   </xsl:template>
   <xsl:template mode="get_brackettip" match="musx:staffBracket[@brackettip]">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@brackettip)"/>
   </xsl:template>
   <xsl:template mode="get_OwnBoundingBox" match="musx:staffBracket" priority="-1">
      <xsl:variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:brackettip(.))" as="node()*"/>
      <xsl:if test="$symbolBBox">
         <xsl:variable name="size" select="g:size(.)"/>
         <xsl:variable name="x" select="g:x(.)"/>
         <xsl:variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </xsl:if>
   </xsl:template>
   <xsl:key name="get_lineOffset_barline" use="substring(@lineOffset,1,1)"
            match="musx:barline"/>
   <xsl:template mode="get_lineOffset" priority="-2" match="musx:barline">
      <xsl:copy-of select="(g:size(.)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_lineOffset" match="musx:barline[@lineOffset]" priority="-1">
      <xsl:copy-of select="number(@lineOffset)"/>
   </xsl:template>
   <xsl:template mode="get_lineOffset" match="key('get_lineOffset_barline','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@lineOffset,2))"/>
   </xsl:template>
   <xsl:template mode="get_lineOffset" match="key('get_lineOffset_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@lineOffset,2))"/>
   </xsl:template>
   <xsl:key name="get_dotOffset_barline" use="substring(@dotOffset,1,1)"
            match="musx:barline"/>
   <xsl:template mode="get_dotOffset" priority="-2" match="musx:barline">
      <xsl:copy-of select="(g:size(.)) * (1.25)"/>
   </xsl:template>
   <xsl:template mode="get_dotOffset" match="musx:barline[@dotOffset]" priority="-1">
      <xsl:copy-of select="number(@dotOffset)"/>
   </xsl:template>
   <xsl:template mode="get_dotOffset" match="key('get_dotOffset_barline','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@dotOffset,2))"/>
   </xsl:template>
   <xsl:template mode="get_dotOffset" match="key('get_dotOffset_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@dotOffset,2))"/>
   </xsl:template>
   <xsl:key name="get_dotRadius_barline" use="substring(@dotRadius,1,1)"
            match="musx:barline"/>
   <xsl:template mode="get_dotRadius" priority="-2" match="musx:barline">
      <xsl:copy-of select="(1) * (.4)"/>
   </xsl:template>
   <xsl:template mode="get_dotRadius" match="musx:barline[@dotRadius]" priority="-1">
      <xsl:copy-of select="number(@dotRadius)"/>
   </xsl:template>
   <xsl:template mode="get_dotRadius" match="key('get_dotRadius_barline','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@dotRadius,2))"/>
   </xsl:template>
   <xsl:template mode="get_dotRadius" match="key('get_dotRadius_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@dotRadius,2))"/>
   </xsl:template>
   <xsl:key name="get_lineWidth_barline" use="substring(@lineWidth,1,1)"
            match="musx:barline"/>
   <xsl:template mode="get_lineWidth" priority="-2" match="musx:barline">
      <xsl:copy-of select="(g:size(.)) * (.25)"/>
   </xsl:template>
   <xsl:template mode="get_lineWidth" match="musx:barline[@lineWidth]" priority="-1">
      <xsl:copy-of select="number(@lineWidth)"/>
   </xsl:template>
   <xsl:template mode="get_lineWidth" match="key('get_lineWidth_barline','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@lineWidth,2))"/>
   </xsl:template>
   <xsl:template mode="get_lineWidth" match="key('get_lineWidth_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@lineWidth,2))"/>
   </xsl:template>
   <xsl:key name="get_boldLineWidth_barline" use="substring(@boldLineWidth,1,1)"
            match="musx:barline"/>
   <xsl:template mode="get_boldLineWidth" priority="-2" match="musx:barline">
      <xsl:copy-of select="(g:size(.)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_boldLineWidth" match="musx:barline[@boldLineWidth]" priority="-1">
      <xsl:copy-of select="number(@boldLineWidth)"/>
   </xsl:template>
   <xsl:template mode="get_boldLineWidth" match="key('get_boldLineWidth_barline','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@boldLineWidth,2))"/>
   </xsl:template>
   <xsl:template mode="get_boldLineWidth" match="key('get_boldLineWidth_barline','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@boldLineWidth,2))"/>
   </xsl:template>
   <xsl:template mode="get_type" match="musx:barline" priority="-1">
      <xsl:copy-of select="'normal'"/>
   </xsl:template>
   <xsl:template mode="get_type" match="musx:barline[@type]">
      <xsl:copy-of select="@type cast as xs:string"/>
   </xsl:template>
   <xsl:template mode="get_function" match="musx:barline" priority="-1">
      <xsl:copy-of select="'normal'"/>
   </xsl:template>
   <xsl:template mode="get_function" match="musx:barline[@function]">
      <xsl:copy-of select="@function cast as xs:string"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.direction" match="musx:note" priority="-1">
      <xsl:copy-of select="if (g:step(.) lt 0)                                                   then -1                                                   else 1"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.direction" match="musx:note[@ledgerLines.direction]">
      <xsl:copy-of select="@ledgerLines.direction cast as xs:integer"/>
   </xsl:template>
   <xsl:key name="get_ledgerLines.y1_note" use="substring(@ledgerLines.y1,1,1)"
            match="musx:note"/>
   <xsl:template mode="get_ledgerLines.y1" match="musx:note" priority="-2">
      <xsl:copy-of select="(       for $staff in ancestor::musx:staff[last()] return         if (g:ledgerLines.direction(.) &lt; 0)         then g:y1($staff) - 2*g:size($staff)         else g:y2($staff) + 2*g:size($staff)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y1" match="musx:note[@ledgerLines.y1]" priority="-1">
      <xsl:copy-of select="number(@ledgerLines.y1)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(       for $staff in ancestor::musx:staff[last()] return         if (g:ledgerLines.direction(.) &lt; 0)         then g:y1($staff) - 2*g:size($staff)         else g:y2($staff) + 2*g:size($staff)) + g:size($page) * number(substring(@ledgerLines.y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@ledgerLines.y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(       for $staff in ancestor::musx:staff[last()] return         if (g:ledgerLines.direction(.) &lt; 0)         then g:y1($staff) - 2*g:size($staff)         else g:y2($staff) + 2*g:size($staff)) + (g:size($staff) * number(substring(@ledgerLines.y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@ledgerLines.y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@ledgerLines.y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_ledgerLines.y2_note" use="substring(@ledgerLines.y2,1,1)"
            match="musx:note"/>
   <xsl:template mode="get_ledgerLines.y2" match="musx:note" priority="-2">
      <xsl:copy-of select="(g:y(.)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y2" match="musx:note[@ledgerLines.y2]" priority="-1">
      <xsl:copy-of select="number(@ledgerLines.y2)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(.)) + g:size($page) * number(substring(@ledgerLines.y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@ledgerLines.y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(.)) + (g:size($staff) * number(substring(@ledgerLines.y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@ledgerLines.y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@ledgerLines.y2,2)) - 1)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.draw" match="musx:note" priority="-1">
      <xsl:copy-of select="g:step(.) &lt; -1 or g:step(.) &gt; 9"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.draw" match="musx:note[@ledgerLines.draw]">
      <xsl:copy-of select="if (@ledgerLines.draw = 'false')                            then false()                            else true()"/>
   </xsl:template>
   <xsl:key name="get_ledgerLines.protrusion_note"
            use="substring(@ledgerLines.protrusion,1,1)"
            match="musx:note"/>
   <xsl:template mode="get_ledgerLines.protrusion" priority="-2" match="musx:note">
      <xsl:copy-of select="(g:size(..)) * (.75)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.protrusion" match="musx:note[@ledgerLines.protrusion]"
                 priority="-1">
      <xsl:copy-of select="number(@ledgerLines.protrusion)"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.protrusion"
                 match="key('get_ledgerLines.protrusion_note','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@ledgerLines.protrusion,2))"/>
   </xsl:template>
   <xsl:template mode="get_ledgerLines.protrusion"
                 match="key('get_ledgerLines.protrusion_note','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@ledgerLines.protrusion,2))"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:note" priority="-1">
      <xsl:copy-of select="         if (musx:stem/@direction)         then g:direction(musx:stem[@direction][1])         else g:calculateDirection(.)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:note[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_step" match="musx:note" priority="-1">
      <xsl:copy-of select="           if(substring(@y,1,1)='S')           then number(substring(@y,2))           else (g:y(.) - g:y(ancestor::musx:staff[last()])) div g:staffSize(.)"/>
   </xsl:template>
   <xsl:template mode="get_step" match="musx:note[@step]">
      <xsl:copy-of select="@step cast as xs:double"/>
   </xsl:template>
   <xsl:key name="get_x_head" use="substring(@x,1,1)" match="musx:head"/>
   <xsl:template mode="get_x" match="musx:head" priority="-2">
      <xsl:copy-of select="(g:x(g:start(.))) + (       if (g:flip(.) = 0)       then 0       else g:flip(.) * g:width(.))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:head[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_head','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_head','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_head','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:template mode="get_flip" match="musx:head" priority="-1">
      <xsl:copy-of select="       if(../parent::musx:chord)       then (         for $chordDirection in g:direction(../..),             $noteStep in g:step(..),             $collisionStep in $noteStep - $chordDirection,             $otherNote in ../../musx:note         return           if (g:step($otherNote) = $collisionStep)           then (g:flip($otherNote/musx:head) - $chordDirection) mod 2           else ()       )[1]       else 0"/>
   </xsl:template>
   <xsl:template mode="get_flip" match="musx:head[@flip]">
      <xsl:copy-of select="@flip cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:head" priority="-1">
      <xsl:value-of select="concat($libDirectory,'/',$symbolFile,'#','notehead.quarter')"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:head[contains(@symbol,'.')]" priority="2">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:head[@symbol]">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_OwnBoundingBox" match="musx:head" priority="-1">
      <xsl:variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <xsl:if test="$symbolBBox">
         <xsl:variable name="size" select="g:size(.)"/>
         <xsl:variable name="x" select="g:x(.)"/>
         <xsl:variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </xsl:if>
   </xsl:template>
   <xsl:key name="get_x_accidental" use="substring(@x,1,1)" match="musx:accidental"/>
   <xsl:template mode="get_x" match="musx:accidental" priority="-2">
      <xsl:copy-of select="(g:x(..)) + (-3*g:size(.))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:accidental[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_accidental','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_accidental','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_accidental','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:template mode="get_topNote" match="musx:chord" priority="-1">
      <xsl:sequence select="musx:note[g:step(.) = min(g:step(../musx:note))][1]"/>
   </xsl:template>
   <xsl:template mode="get_topNote" match="musx:chord[@topNote]">
      <xsl:variable name="referencedElement" select="id(@topNote)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@topNote"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template mode="get_bottomNote" match="musx:chord" priority="-1">
      <xsl:sequence select="musx:note[g:step(.) = max(g:step(../musx:note))][1]"/>
   </xsl:template>
   <xsl:template mode="get_bottomNote" match="musx:chord[@bottomNote]">
      <xsl:variable name="referencedElement" select="id(@bottomNote)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@bottomNote"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:chord" priority="-1">
      <xsl:copy-of select="         if (musx:stem/@direction)         then g:direction(musx:stem[1])         else g:calculateDirection(.)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:chord[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:key name="get_y1_chord" use="substring(@y1,1,1)" match="musx:chord"/>
   <xsl:template mode="get_y1" match="musx:chord" priority="-2">
      <xsl:copy-of select="(       if (g:direction(.) = -1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))       ) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="musx:chord[@y1]" priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_chord','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(       if (g:direction(.) = -1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))       ) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_chord','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_chord','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(       if (g:direction(.) = -1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))       ) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_chord','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_chord','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_chord" use="substring(@y2,1,1)" match="musx:chord"/>
   <xsl:template mode="get_y2" match="musx:chord" priority="-2">
      <xsl:copy-of select="(       if (g:direction(.) = 1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))      ) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:chord[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_chord','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(       if (g:direction(.) = 1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))      ) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_chord','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_chord','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(       if (g:direction(.) = 1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))      ) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_chord','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_chord','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_x_stem" use="substring(@x,1,1)" match="musx:stem"/>
   <xsl:template mode="get_x" match="musx:stem" priority="-2">
      <xsl:copy-of select="(g:x(..)) + (         if (g:direction(.) = 1 or not(..//musx:head or parent::musx:rest))         then 0              (: the width of the first symbol found in this sequence gets returned                  if parent is a chord, g:topNote(..) will return something;                 if parent is a note, ../musx:head will return something,                 otherwise, this should be a rest :)         else g:width((g:topNote(..)/musx:head, ../musx:head, ..)[1]))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:stem[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_stem','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_stem','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_stem','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_y1_stem" use="substring(@y1,1,1)" match="musx:stem"/>
   <xsl:template mode="get_y1" match="musx:stem" priority="-2">
      <xsl:copy-of select="(g:y1(..)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="musx:stem[@y1]" priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_stem','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y1(..)) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_stem','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_stem','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1(..)) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_stem','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_stem','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_stem" use="substring(@y2,1,1)" match="musx:stem"/>
   <xsl:template mode="get_y2" match="musx:stem" priority="-2">
      <xsl:copy-of select="(           if (..//@beam)           then g:beamY(g:beam(.),g:x(.),true())           else g:y2(..)) + (           if (..//@beam)           then 0           else g:direction(.) * g:length(.) * g:staffSize(.))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:stem[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_stem','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(           if (..//@beam)           then g:beamY(g:beam(.),g:x(.),true())           else g:y2(..)) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_stem','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_stem','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(           if (..//@beam)           then g:beamY(g:beam(.),g:x(.),true())           else g:y2(..)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_stem','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_stem','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:stem" priority="-1">
      <xsl:copy-of select="         if (@beam)         then g:direction(g:beam(.))         else g:direction(..)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:stem[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_beam" match="musx:stem" priority="-1">
      <xsl:sequence select="()"/>
   </xsl:template>
   <xsl:template mode="get_beam" match="musx:stem[@beam]">
      <xsl:variable name="referencedElement" select="id(@beam)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@beam"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template mode="get_length" match="musx:stem" priority="-1">
      <xsl:copy-of select="g:defaultStemLength(.)"/>
   </xsl:template>
   <xsl:template mode="get_length" match="musx:stem[@length]">
      <xsl:copy-of select="@length cast as xs:double"/>
   </xsl:template>
   <xsl:key name="get_y_flags" use="substring(@y,1,1)" match="musx:flags"/>
   <xsl:template mode="get_y" match="musx:flags" priority="-2">
      <xsl:copy-of select="(g:y2(..)) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:flags[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_flags','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y2(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_flags','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_flags','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_flags','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_flags','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:flags|musx:dots|musx:subbeam" priority="-1">
      <xsl:copy-of select="g:direction(..)"/>
   </xsl:template>
   <xsl:template mode="get_direction"
                 match="musx:flags[@direction]|musx:dots[@direction]|musx:subbeam[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_number" match="musx:flags|musx:dots|musx:beam|musx:subbeam"
                 priority="-1">
      <xsl:copy-of select="1"/>
   </xsl:template>
   <xsl:template mode="get_number"
                 match="musx:flags[@number]|musx:dots[@number]|musx:beam[@number]|musx:subbeam[@number]">
      <xsl:copy-of select="@number cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:flags" priority="-1">
      <xsl:value-of select="concat($libDirectory,'/',$symbolFile,'#',concat('flags.',g:direction(.)*g:number(.)))"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:flags[contains(@symbol,'.')]" priority="2">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_symbol" match="musx:flags[@symbol]">
      <xsl:sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </xsl:template>
   <xsl:template mode="get_OwnBoundingBox" match="musx:flags" priority="-1">
      <xsl:variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <xsl:if test="$symbolBBox">
         <xsl:variable name="size" select="g:size(.)"/>
         <xsl:variable name="x" select="g:x(.)"/>
         <xsl:variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </xsl:if>
   </xsl:template>
   <xsl:key name="get_y_dots" use="substring(@y,1,1)" match="musx:dots"/>
   <xsl:template mode="get_y" match="musx:dots" priority="-2">
      <xsl:copy-of select="(g:y(..)) + (         if (g:step(..) mod 2 = 0)         then -g:staffSize(.)         else 0)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:dots[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_dots','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_dots','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_dots','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_dots','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_dots','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_x1_dots" use="substring(@x1,1,1)" match="musx:dots"/>
   <xsl:template mode="get_x1" match="musx:dots" priority="-2">
      <xsl:copy-of select="(g:x(..)) + (g:width((../musx:head, ..)[1]) + g:offset(.))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="musx:dots[@x1]" priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_dots','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_dots','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_dots','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_x2_dots" use="substring(@x2,1,1)" match="musx:dots"/>
   <xsl:template mode="get_x2" match="musx:dots" priority="-2">
      <xsl:copy-of select="(g:x1(.)) + ((g:number(.) - 1) * g:distance(.))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="musx:dots[@x2]" priority="-1">
      <xsl:copy-of select="number(@x2)"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_dots','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x1(.)) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_dots','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_dots','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x1(.)) + (g:size($staff) * number(substring(@x2,2)))"/>
   </xsl:template>
   <xsl:key name="get_offset_dots" use="substring(@offset,1,1)" match="musx:dots"/>
   <xsl:template mode="get_offset" priority="-2" match="musx:dots">
      <xsl:copy-of select="(g:size(.)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_offset" match="musx:dots[@offset]" priority="-1">
      <xsl:copy-of select="number(@offset)"/>
   </xsl:template>
   <xsl:template mode="get_offset" match="key('get_offset_dots','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@offset,2))"/>
   </xsl:template>
   <xsl:template mode="get_offset" match="key('get_offset_dots','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@offset,2))"/>
   </xsl:template>
   <xsl:key name="get_distance_dots" use="substring(@distance,1,1)" match="musx:dots"/>
   <xsl:template mode="get_distance" priority="-2" match="musx:dots">
      <xsl:copy-of select="(g:size(.)) * (1.2)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="musx:dots[@distance]" priority="-1">
      <xsl:copy-of select="number(@distance)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_dots','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_dots','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:key name="get_radius_dots" use="substring(@radius,1,1)" match="musx:dots"/>
   <xsl:template mode="get_radius" priority="-2" match="musx:dots">
      <xsl:copy-of select="(g:size(..)) * (.25)"/>
   </xsl:template>
   <xsl:template mode="get_radius" match="musx:dots[@radius]" priority="-1">
      <xsl:copy-of select="number(@radius)"/>
   </xsl:template>
   <xsl:template mode="get_radius" match="key('get_radius_dots','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@radius,2))"/>
   </xsl:template>
   <xsl:template mode="get_radius" match="key('get_radius_dots','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@radius,2))"/>
   </xsl:template>
   <xsl:key name="get_x1_beam_subbeam" use="substring(@x1,1,1)"
            match="musx:beam|musx:subbeam"/>
   <xsl:template mode="get_x1" match="musx:beam|musx:subbeam" priority="-2">
      <xsl:copy-of select="(g:x((g:start(.)//musx:stem, g:start(.))[1])) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="musx:beam[@x1]|musx:subbeam[@x1]" priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_beam_subbeam','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x((g:start(.)//musx:stem, g:start(.))[1])) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_beam_subbeam','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_beam_subbeam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x((g:start(.)//musx:stem, g:start(.))[1])) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_x2_beam_subbeam" use="substring(@x2,1,1)"
            match="musx:beam|musx:subbeam"/>
   <xsl:template mode="get_x2" match="musx:beam|musx:subbeam" priority="-2">
      <xsl:copy-of select="(g:x((g:end(.)//musx:stem, g:end(.))[1])) + (0)"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="musx:beam[@x2]|musx:subbeam[@x2]" priority="-1">
      <xsl:copy-of select="number(@x2)"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_beam_subbeam','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x((g:end(.)//musx:stem, g:end(.))[1])) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_beam_subbeam','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_beam_subbeam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x((g:end(.)//musx:stem, g:end(.))[1])) + (g:size($staff) * number(substring(@x2,2)))"/>
   </xsl:template>
   <xsl:key name="get_y_beam" use="substring(@y,1,1)" match="musx:beam"/>
   <xsl:template mode="get_y" match="musx:beam" priority="-2">
      <xsl:copy-of select="(g:y(..)) + (g:beamYLacuna(.))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:beam[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_beam','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_beam','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_beam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_beam','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_beam','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_width_beam" use="substring(@width,1,1)" match="musx:beam"/>
   <xsl:template mode="get_width" priority="-2" match="musx:beam">
      <xsl:copy-of select="(g:size(.)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="musx:beam[@width]" priority="-1">
      <xsl:copy-of select="number(@width)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_beam','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_beam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:key name="get_distance_beam" use="substring(@distance,1,1)" match="musx:beam"/>
   <xsl:template mode="get_distance" priority="-2" match="musx:beam">
      <xsl:copy-of select="(g:size(.)) * (1.5)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="musx:beam[@distance]" priority="-1">
      <xsl:copy-of select="number(@distance)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_beam','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_beam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:beam" priority="-1">
      <xsl:copy-of select="g:calculateDirection(.)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:beam[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:template mode="get_beam" match="musx:subbeam" priority="-1">
      <xsl:sequence select=".."/>
   </xsl:template>
   <xsl:template mode="get_beam" match="musx:subbeam[@beam]">
      <xsl:variable name="referencedElement" select="id(@beam)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@beam"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_y1_subbeam" use="substring(@y1,1,1)" match="musx:subbeam"/>
   <xsl:template mode="get_y1" match="musx:subbeam" priority="-2">
      <xsl:copy-of select="(g:beamY(..,g:x1(.),false())) + (- g:distance(..) * g:direction(..) * g:number(..))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="musx:subbeam[@y1]" priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_subbeam','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:beamY(..,g:x1(.),false())) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_subbeam','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_subbeam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:beamY(..,g:x1(.),false())) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_subbeam','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_subbeam','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_subbeam" use="substring(@y2,1,1)" match="musx:subbeam"/>
   <xsl:template mode="get_y2" match="musx:subbeam" priority="-2">
      <xsl:copy-of select="(g:beamY(..,g:x2(.),false())) + (- g:distance(..) * g:direction(..) * g:number(..))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:subbeam[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_subbeam','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:beamY(..,g:x2(.),false())) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_subbeam','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_subbeam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:beamY(..,g:x2(.),false())) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_subbeam','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_subbeam','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_width_subbeam" use="substring(@width,1,1)" match="musx:subbeam"/>
   <xsl:template mode="get_width" priority="-2" match="musx:subbeam">
      <xsl:copy-of select="(g:width(..)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="musx:subbeam[@width]" priority="-1">
      <xsl:copy-of select="number(@width)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_subbeam','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_subbeam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:key name="get_distance_subbeam" use="substring(@distance,1,1)" match="musx:subbeam"/>
   <xsl:template mode="get_distance" priority="-2" match="musx:subbeam">
      <xsl:copy-of select="(g:distance(..)) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="musx:subbeam[@distance]" priority="-1">
      <xsl:copy-of select="number(@distance)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_subbeam','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_subbeam','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:key name="get_startSpread_hairpin" use="substring(@startSpread,1,1)"
            match="musx:hairpin"/>
   <xsl:template mode="get_startSpread" priority="-2" match="musx:hairpin">
      <xsl:copy-of select="(g:size(..)) * (0)"/>
   </xsl:template>
   <xsl:template mode="get_startSpread" match="musx:hairpin[@startSpread]" priority="-1">
      <xsl:copy-of select="number(@startSpread)"/>
   </xsl:template>
   <xsl:template mode="get_startSpread" match="key('get_startSpread_hairpin','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@startSpread,2))"/>
   </xsl:template>
   <xsl:template mode="get_startSpread" match="key('get_startSpread_hairpin','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@startSpread,2))"/>
   </xsl:template>
   <xsl:key name="get_endSpread_hairpin" use="substring(@endSpread,1,1)"
            match="musx:hairpin"/>
   <xsl:template mode="get_endSpread" priority="-2" match="musx:hairpin">
      <xsl:copy-of select="(g:size(..)) * (0)"/>
   </xsl:template>
   <xsl:template mode="get_endSpread" match="musx:hairpin[@endSpread]" priority="-1">
      <xsl:copy-of select="number(@endSpread)"/>
   </xsl:template>
   <xsl:template mode="get_endSpread" match="key('get_endSpread_hairpin','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@endSpread,2))"/>
   </xsl:template>
   <xsl:template mode="get_endSpread" match="key('get_endSpread_hairpin','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@endSpread,2))"/>
   </xsl:template>
   <xsl:template mode="get_slurNotes" match="musx:slur" priority="-1">
      <xsl:sequence select="g:calculateSlurNotes(.)"/>
   </xsl:template>
   <xsl:template mode="get_slurNotes" match="musx:slur[@slurNotes]">
      <xsl:variable name="referencedElement" select="id(@slurNotes)" as="element()?"/>
      <xsl:choose>
         <xsl:when test="$referencedElement">
            <xsl:sequence select="$referencedElement"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="yes">
               <xsl:value-of select="local-name()"/> element <xsl:value-of select="@xml:id"/> references non-existent element <xsl:value-of select="@slurNotes"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:key name="get_x1_slur" use="substring(@x1,1,1)" match="musx:slur"/>
   <xsl:template mode="get_x1" match="musx:slur" priority="-2">
      <xsl:copy-of select="(g:x(g:start(.))) + ((: Why doesn't .=key('class','tie') work? :)                 if(. intersect key('class','tie'))                 then g:width(g:start(.)/musx:head) (: TODO: more sophisticated handling for ties :)                 else g:width(g:start(.)/musx:head)*.5                     (: If there is no head, g:width(.) will return the size                         property of the element referenced by start(.) :))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="musx:slur[@x1]" priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_slur','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_slur','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_x2_slur" use="substring(@x2,1,1)" match="musx:slur"/>
   <xsl:template mode="get_x2" match="musx:slur" priority="-2">
      <xsl:copy-of select="(g:x(g:end(.))) + ((: Why doesn't .=key('class','tie') work? :)                 if(. intersect key('class','tie'))                 then 0 (: TODO: More sophisticated handling for ties :)                 else g:width(g:end(.)/musx:head)*.5                     (: If there is no head, g:width(.) will return the size                      property of the element referenced by start(.) :))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="musx:slur[@x2]" priority="-1">
      <xsl:copy-of select="number(@x2)"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_slur','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:end(.))) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_slur','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:end(.))) + (g:size($staff) * number(substring(@x2,2)))"/>
   </xsl:template>
   <xsl:key name="get_y1_slur" use="substring(@y1,1,1)" match="musx:slur"/>
   <xsl:template mode="get_y1" match="musx:slur" priority="-2">
      <xsl:copy-of select="(for $start in g:start(.)                 return if($start/self::musx:note)                        then g:y($start)                        else g:y((g:slurNotes(.),..)[1])) + (for $start in g:start(.)                        (: g:direction() defaults to 0 if supplied with no argument.                           Therefore, if start isn't a note, we will not have a vertical slur offset :)                 return - g:direction($start/self::musx:note) * g:size($start) * (if(. intersect key('class','tie'))                                                                                  then .7                                                                                  else 2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="musx:slur[@y1]" priority="-1">
      <xsl:copy-of select="number(@y1)"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_slur','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(for $start in g:start(.)                 return if($start/self::musx:note)                        then g:y($start)                        else g:y((g:slurNotes(.),..)[1])) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_slur','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(for $start in g:start(.)                 return if($start/self::musx:note)                        then g:y($start)                        else g:y((g:slurNotes(.),..)[1])) + (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_slur','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y1" match="key('get_y1_slur','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_y2_slur" use="substring(@y2,1,1)" match="musx:slur"/>
   <xsl:template mode="get_y2" match="musx:slur" priority="-2">
      <xsl:copy-of select="(for $end in g:end(.)                 return if($end/self::musx:note)                        then g:y($end)                        else g:y((..,g:slurNotes(.))[last()])) + (for $end in g:end(.)                       (: g:direction() defaults to 0 if supplied with no argument.                          Therefore, if end isn't a note, we will not have a vertical slur offset :)                 return if(. intersect key('class','tie'))                        then for $start in g:start(.)                             return - g:direction($start/self::musx:note) * g:size($start)                        else - g:direction($end/self::musx:note) * g:size($end) * 2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="musx:slur[@y2]" priority="-1">
      <xsl:copy-of select="number(@y2)"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_slur','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(for $end in g:end(.)                 return if($end/self::musx:note)                        then g:y($end)                        else g:y((..,g:slurNotes(.))[last()])) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_slur','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(for $end in g:end(.)                 return if($end/self::musx:note)                        then g:y($end)                        else g:y((..,g:slurNotes(.))[last()])) + (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_slur','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y2" match="key('get_y2_slur','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_maxHeight_slur" use="substring(@maxHeight,1,1)" match="musx:slur"/>
   <xsl:template mode="get_maxHeight" priority="-2" match="musx:slur">
      <xsl:copy-of select="(g:size(.)) * (10)"/>
   </xsl:template>
   <xsl:template mode="get_maxHeight" match="musx:slur[@maxHeight]" priority="-1">
      <xsl:copy-of select="number(@maxHeight)"/>
   </xsl:template>
   <xsl:template mode="get_maxHeight" match="key('get_maxHeight_slur','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@maxHeight,2))"/>
   </xsl:template>
   <xsl:template mode="get_maxHeight" match="key('get_maxHeight_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@maxHeight,2))"/>
   </xsl:template>
   <xsl:key name="get_height_slur" use="substring(@height,1,1)" match="musx:slur"/>
   <xsl:template mode="get_height" priority="-2" match="musx:slur">
      <xsl:copy-of select="(g:size(.)) * (       for $length in (g:x2(.) - g:x1(.)) div g:size(.)       return g:maxHeight(.) div g:size(.) * $length div ($length + 50))"/>
   </xsl:template>
   <xsl:template mode="get_height" match="musx:slur[@height]" priority="-1">
      <xsl:copy-of select="number(@height)"/>
   </xsl:template>
   <xsl:template mode="get_height" match="key('get_height_slur','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@height,2))"/>
   </xsl:template>
   <xsl:template mode="get_height" match="key('get_height_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@height,2))"/>
   </xsl:template>
   <xsl:key name="get_centerThickness_slur" use="substring(@centerThickness,1,1)"
            match="musx:slur"/>
   <xsl:template mode="get_centerThickness" priority="-2" match="musx:slur">
      <xsl:copy-of select="(g:size(.)) * (.5)"/>
   </xsl:template>
   <xsl:template mode="get_centerThickness" match="musx:slur[@centerThickness]" priority="-1">
      <xsl:copy-of select="number(@centerThickness)"/>
   </xsl:template>
   <xsl:template mode="get_centerThickness" match="key('get_centerThickness_slur','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@centerThickness,2))"/>
   </xsl:template>
   <xsl:template mode="get_centerThickness" match="key('get_centerThickness_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@centerThickness,2))"/>
   </xsl:template>
   <xsl:key name="get_tipThickness_slur" use="substring(@tipThickness,1,1)"
            match="musx:slur"/>
   <xsl:template mode="get_tipThickness" priority="-2" match="musx:slur">
      <xsl:copy-of select="(g:centerThickness(.)) * (.618)"/>
   </xsl:template>
   <xsl:template mode="get_tipThickness" match="musx:slur[@tipThickness]" priority="-1">
      <xsl:copy-of select="number(@tipThickness)"/>
   </xsl:template>
   <xsl:template mode="get_tipThickness" match="key('get_tipThickness_slur','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@tipThickness,2))"/>
   </xsl:template>
   <xsl:template mode="get_tipThickness" match="key('get_tipThickness_slur','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@tipThickness,2))"/>
   </xsl:template>
   <xsl:template mode="get_swellingRate" match="musx:slur" priority="-1">
      <xsl:copy-of select=".618"/>
   </xsl:template>
   <xsl:template mode="get_swellingRate" match="musx:slur[@swellingRate]">
      <xsl:copy-of select="@swellingRate cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_swellingRate1" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:swellingRate(.)"/>
   </xsl:template>
   <xsl:template mode="get_swellingRate1" match="musx:slur[@swellingRate1]">
      <xsl:copy-of select="@swellingRate1 cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_swellingRate2" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:swellingRate(.)"/>
   </xsl:template>
   <xsl:template mode="get_swellingRate2" match="musx:slur[@swellingRate2]">
      <xsl:copy-of select="@swellingRate2 cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_tilt" match="musx:slur" priority="-1">
      <xsl:copy-of select=".618"/>
   </xsl:template>
   <xsl:template mode="get_tilt" match="musx:slur[@tilt]">
      <xsl:copy-of select="@tilt cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_shift" match="musx:slur" priority="-1">
      <xsl:copy-of select="0"/>
   </xsl:template>
   <xsl:template mode="get_shift" match="musx:slur[@shift]">
      <xsl:copy-of select="@shift cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_shoulder" match="musx:slur" priority="-1">
      <xsl:copy-of select="         for $startShoulder in .6,             $length in (g:x2(.) - g:x1(.)) div g:size(.)             return $startShoulder + (1-$startShoulder)*$length*$length div (100*$length + $length*$length)"/>
   </xsl:template>
   <xsl:template mode="get_shoulder" match="musx:slur[@shoulder]">
      <xsl:copy-of select="@shoulder cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_curvature" match="musx:slur" priority="-1">
      <xsl:copy-of select=".5"/>
   </xsl:template>
   <xsl:template mode="get_curvature" match="musx:slur[@curvature]">
      <xsl:copy-of select="@curvature cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_curvature1" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:curvature(.)"/>
   </xsl:template>
   <xsl:template mode="get_curvature1" match="musx:slur[@curvature1]">
      <xsl:copy-of select="@curvature1 cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_curvature2" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:curvature(.)"/>
   </xsl:template>
   <xsl:template mode="get_curvature2" match="musx:slur[@curvature2]">
      <xsl:copy-of select="@curvature2 cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_tipAngle" match="musx:slur" priority="-1">
      <xsl:copy-of select=".618"/>
   </xsl:template>
   <xsl:template mode="get_tipAngle" match="musx:slur[@tipAngle]">
      <xsl:copy-of select="@tipAngle cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_tipAngle1" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:tipAngle(.)"/>
   </xsl:template>
   <xsl:template mode="get_tipAngle1" match="musx:slur[@tipAngle1]">
      <xsl:copy-of select="@tipAngle1 cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_tipAngle2" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:tipAngle(.)"/>
   </xsl:template>
   <xsl:template mode="get_tipAngle2" match="musx:slur[@tipAngle2]">
      <xsl:copy-of select="@tipAngle2 cast as xs:double"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:slur" priority="-1">
      <xsl:copy-of select="g:slurDirection(.)"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:slur[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:key name="get_x_symbolText" use="substring(@x,1,1)" match="musx:symbolText"/>
   <xsl:template mode="get_x" match="musx:symbolText" priority="-2">
      <xsl:copy-of select="(g:x(g:start(.))) + (if (parent::musx:fraction)                                                          then .5*(g:width(..) - g:width(.))                                                          else 0)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:symbolText[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_symbolText','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_symbolText','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_symbolText','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:key name="get_y_symbolText" use="substring(@y,1,1)" match="musx:symbolText"/>
   <xsl:template mode="get_y" match="musx:symbolText" priority="-2">
      <xsl:copy-of select="(g:y(..)) + (if (parent::musx:fraction)                                                  then (4*count(preceding-sibling::musx:symbolText)-2)*g:staffSize(.)                                                  else 0)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:symbolText[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_symbolText','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_symbolText','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_symbolText','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_symbolText','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_symbolText','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_x1_symbolText" use="substring(@x1,1,1)" match="musx:symbolText"/>
   <xsl:template mode="get_x1" match="musx:symbolText" priority="-2">
      <xsl:copy-of select="(g:x(.)) + (0 - g:width(.) * g:textAnchor(.))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="musx:symbolText[@x1]" priority="-1">
      <xsl:copy-of select="number(@x1)"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_symbolText','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_symbolText','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </xsl:template>
   <xsl:template mode="get_x1" match="key('get_x1_symbolText','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x1,2)))"/>
   </xsl:template>
   <xsl:key name="get_x2_symbolText" use="substring(@x2,1,1)" match="musx:symbolText"/>
   <xsl:template mode="get_x2" match="musx:symbolText" priority="-2">
      <xsl:copy-of select="(g:x(.)) + ((1 - g:textAnchor(.)) * g:width(.))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="musx:symbolText[@x2]" priority="-1">
      <xsl:copy-of select="number(@x2)"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_symbolText','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_symbolText','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </xsl:template>
   <xsl:template mode="get_x2" match="key('get_x2_symbolText','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x2,2)))"/>
   </xsl:template>
   <xsl:template mode="get_textAnchor" match="musx:symbolText" priority="-1">
      <xsl:copy-of select="0"/>
   </xsl:template>
   <xsl:template mode="get_textAnchor" match="musx:symbolText[@textAnchor]">
      <xsl:copy-of select="@textAnchor cast as xs:double"/>
   </xsl:template>
   <xsl:key name="get_width_symbolText" use="substring(@width,1,1)" match="musx:symbolText"/>
   <xsl:template mode="get_width" priority="-2" match="musx:symbolText">
      <xsl:copy-of select="(g:size(.)) * (sum(def:getGlyphWidth(text())))"/>
   </xsl:template>
   <xsl:template mode="get_width" match="musx:symbolText[@width]" priority="-1">
      <xsl:copy-of select="number(@width)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_symbolText','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_symbolText','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_pattern" match="musx:keySignature" priority="-1">
      <xsl:copy-of select="''''"/>
   </xsl:template>
   <xsl:template mode="get_pattern" match="musx:keySignature[@pattern]">
      <xsl:copy-of select="@pattern cast as xs:string"/>
   </xsl:template>
   <xsl:key name="get_distance_keySignature" use="substring(@distance,1,1)"
            match="musx:keySignature"/>
   <xsl:template mode="get_distance" priority="-2" match="musx:keySignature">
      <xsl:copy-of select="(g:size(.)) * (2)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="musx:keySignature[@distance]" priority="-1">
      <xsl:copy-of select="number(@distance)"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_keySignature','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:template mode="get_distance" match="key('get_distance_keySignature','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </xsl:template>
   <xsl:key name="get_y_timeSignature" use="substring(@y,1,1)" match="musx:timeSignature"/>
   <xsl:template mode="get_y" match="musx:timeSignature" priority="-2">
      <xsl:copy-of select="(g:y(..)) + (6*g:staffSize(.))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="musx:timeSignature[@y]" priority="-1">
      <xsl:copy-of select="number(@y)"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_timeSignature','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_timeSignature','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_timeSignature','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_timeSignature','S')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </xsl:template>
   <xsl:template mode="get_y" match="key('get_y_timeSignature','L')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </xsl:template>
   <xsl:key name="get_width_fraction" use="substring(@width,1,1)" match="musx:fraction"/>
   <xsl:template mode="get_width" priority="-2" match="musx:fraction">
      <xsl:copy-of select="(max((g:width(*),0))) * (1)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="musx:fraction[@width]" priority="-1">
      <xsl:copy-of select="number(@width)"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_fraction','p')">
      <xsl:variable name="page" select="ancestor::musx:page" as="node()"/>
      <xsl:copy-of select="g:size($page) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:template mode="get_width" match="key('get_width_fraction','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <xsl:copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </xsl:template>
   <xsl:key name="get_x_articulation" use="substring(@x,1,1)" match="musx:articulation"/>
   <xsl:template mode="get_x" match="musx:articulation" priority="-2">
      <xsl:copy-of select="(g:x(g:start(.))) + (.5*g:width(ancestor::musx:note[1]/musx:head[1]))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="musx:articulation[@x]" priority="-1">
      <xsl:copy-of select="number(@x)"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_articulation','p')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_articulation','P')">
      <xsl:variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <xsl:copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </xsl:template>
   <xsl:template mode="get_x" match="key('get_x_articulation','s')">
      <xsl:variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <xsl:copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:articulation" priority="-1">
      <xsl:copy-of select="-1*g:direction(ancestor::musx:note[1])"/>
   </xsl:template>
   <xsl:template mode="get_direction" match="musx:articulation[@direction]">
      <xsl:copy-of select="@direction cast as xs:integer"/>
   </xsl:template>
   <xsl:template match="musx:page" mode="draw">
      <svg:g class="{normalize-space(concat('page ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:rect xmlns="NS:DEF" stroke="black" fill="#fffffc" x="{g:x1(.)}"
                   width="{g:x2(.) - g:x1(.)}"
                   y="{g:y1(.)}"
                   height="{g:y2(.) - g:y1(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:system" mode="draw">
      <svg:g class="{normalize-space(concat('system ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template xmlns="NS:DEF" name="addStaffLines">
      <xsl:param name="yPosition" select="g:y1(.)"/>
    
                                   <!--   + g:size(.) to avoid missing staff lines due to roundoff errors -->
    <xsl:if test="$yPosition &lt; g:y2(.) + g:size(.)">
         <svg:line x1="{g:x1(.)}" x2="{g:x2(.)}" y1="{$yPosition}" y2="{$yPosition}"/>
         <xsl:call-template name="addStaffLines">
            <xsl:with-param name="yPosition" select="$yPosition + 2 * g:size(.)"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>
   <xsl:template match="musx:staff" mode="get_OwnBoundingBox" priority="1">
      <BoundingBox xmlns="NS:DEF" left="{g:x1(.)}" right="{g:x2(.)}" top="{g:y1(.)}"
                   bottom="{g:y2(.)}"/>
   </xsl:template>
   <xsl:template match="musx:staff" mode="draw">
      <svg:g class="{normalize-space(concat('staff ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:g xmlns="NS:DEF" class="stafflines" stroke="currentColor">
            <xsl:call-template name="addStaffLines"/>
         </svg:g>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:staffGroup" mode="draw">
      <svg:g class="{normalize-space(concat('staffGroup ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template xmlns="NS:DEF" match="svg:*" mode="draw">
      <xsl:copy-of select="."/>
  </xsl:template>
   <xsl:template match="musx:svg" mode="draw">
      <svg:g class="{normalize-space(concat('svg ',@class))}"
             transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:clef" mode="draw">
      <svg:g class="{normalize-space(concat('clef ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:transposeNumber" mode="draw">
      <svg:g class="{normalize-space(concat('transposeNumber ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:text xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                   font-size="1">
            <xsl:copy-of select="node()"/>
         </svg:text>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:rest" mode="draw">
      <svg:g class="{normalize-space(concat('rest ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:group" mode="draw">
      <svg:g class="{normalize-space(concat('group ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:staffBracket" mode="draw">
      <svg:g class="{normalize-space(concat('staffBracket ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:line xmlns="NS:DEF" x1="{g:x(.) - 1.5 * g:size(.)}" x2="{g:x(.) - 1.5 * g:size(.)}"
                   y1="{g:y1(.) - 1.4 * g:size(.)}"
                   y2="{g:y2(.) + 1.4 * g:size(.)}"
                   stroke-width="{1.2 * g:size(.)}"
                   fill="none"
                   stroke="currentColor"/>
         <svg:use xmlns="NS:DEF" xlink:href="{g:brackettip(.)}"
                  transform="translate({g:x(.) - g:size(.)},{g:y2(.) + g:size(.)}) scale({g:size(.)},{- g:size(.)})"/>
         <svg:use xmlns="NS:DEF" xlink:href="{g:brackettip(.)}"
                  transform="translate({g:x(.) - g:size(.)},{g:y1(.) - g:size(.)}) scale({g:size(.)})"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template xmlns="NS:DEF" name="drawThinBarline">
      <xsl:param name="offsetDirection" select="0" as="xs:integer*"/>
      <xsl:variable name="barlineElement" select="."/>
      <xsl:variable name="rawX" select="g:x(.)"/>
      <xsl:variable name="y1" select="g:y1(.)"/>
      <xsl:variable name="y2" select="g:y2(.)"/>
      <xsl:variable name="dotRadius" select="g:dotRadius(.)"/>
      <xsl:variable name="dotOffset" select="g:dotOffset(.)"/>
      <xsl:variable name="lineOffset" select="g:lineOffset(.)"/>
      <xsl:variable name="lineWidth" select="g:lineWidth(.)"/>
      <xsl:variable name="boldLineWidth" select="g:boldLineWidth(.)"/>
      <xsl:variable name="type" select="g:type(.)"/>
    
      <xsl:for-each select="$offsetDirection">
         <xsl:variable name="x">
            <xsl:choose>
               <xsl:when test="current() = 0">
                  <xsl:sequence select="$rawX"/>
               </xsl:when>
               <xsl:when test="$type='double' and current() = -1">
                  <xsl:sequence select="$rawX - $lineOffset"/>
               </xsl:when>
               <xsl:when test="$type='repeatDouble'">
                  <xsl:sequence select="$rawX + current()*((.5*$boldLineWidth - $lineWidth) + $lineOffset)"/>
               </xsl:when>
               <xsl:otherwise> <!-- repeatStart, repeatEnd and end -->
            <xsl:sequence select="$rawX + current()*(($boldLineWidth - $lineWidth) + $lineOffset)"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
      
         <svg:line x1="{$x}" x2="{$x}" y1="{$y1}" y2="{$y2}"/>
      
         <!-- Draw dots if we have a repeat barline -->
      <xsl:if test="starts-with($barlineElement/@type,'repeat')">
            <xsl:variable name="dotX" select="$x + current() * $dotOffset"/>
            <xsl:for-each select="$barlineElement/(ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff">
               <xsl:variable name="spaces" select="g:lines(.) - 1"/>
               <!-- $dotStraddle tells us the distance from the staff "center" (which is the center line for 
            staffs with an odd number of lines, and the center space for those with an even number).
            For staffs with an odd number of lines, $dotStraddle is 1, otherwise 2 -->
          <xsl:variable name="dotStraddle" select="$spaces mod 2 + 1"/>
               <xsl:variable name="staffSize" select="g:size(.)"/>
               <svg:g transform="translate({$dotX},{g:y1(.)}) scale({$staffSize})" stroke="none">
                  <svg:circle cy="{$spaces + $dotStraddle}" r="{$dotRadius}"/>
                  <svg:circle cy="{$spaces - $dotStraddle}" r="{$dotRadius}"/>
               </svg:g>
            </xsl:for-each>
         </xsl:if>
      </xsl:for-each>
  </xsl:template>
   <xsl:template match="musx:barline" mode="get_OwnBoundingBox" priority="1">
      <xsl:variable xmlns="NS:DEF" name="staffs"
                    select="(ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff"/>
      <xsl:variable xmlns="NS:DEF" name="maxDotRadius" select="max(g:size($staffs))*g:dotRadius(.)"/>
      <xsl:variable xmlns="NS:DEF" name="distanceFromBoldLineToFarSideOfDots"
                    select="g:lineOffset(.) - g:lineWidth(.) + g:dotOffset(.) + $maxDotRadius"/>
      <xsl:choose xmlns="NS:DEF">
         <xsl:when test="g:type(.)='normal'">
            <BoundingBox left="{g:x(.)}" right="{g:x(.)}" top="{g:y1(.)}" bottom="{g:y2(.)}"/>
         </xsl:when>
         <xsl:when test="g:type(.)='double'">
            <BoundingBox left="{g:x(.) - g:lineOffset(.)}" right="{g:x(.)}" top="{g:y1(.)}"
                         bottom="{g:y2(.)}"/>
         </xsl:when>
         <xsl:when test="g:type(.)='end'">
            <BoundingBox left="{g:x(.) - g:lineOffset(.) - g:boldLineWidth(.) + g:lineWidth(.)}"
                         right="{g:x(.)}"
                         top="{g:y1(.)}"
                         bottom="{g:y2(.)}"/>
         </xsl:when>
         <xsl:when test="g:type(.)='repeatEnd'">
            <BoundingBox left="{g:x(.) - g:boldLineWidth(.) - $distanceFromBoldLineToFarSideOfDots}"
                         right="{g:x(.)}"
                         top="{g:y1(.)}"
                         bottom="{g:y2(.)}"/>
         </xsl:when>
         <xsl:when test="g:type(.)='repeatStart'">
            <BoundingBox left="{g:x(.)}"
                         right="{g:x(.) + g:boldLineWidth(.) + $distanceFromBoldLineToFarSideOfDots}"
                         top="{g:y1(.)}"
                         bottom="{g:y2(.)}"/>
         </xsl:when>
         <xsl:when test="g:type(.)='repeatDouble'">
            <xsl:variable name="distanceFromCenter"
                          select=".5*g:boldLineWidth(.) + $distanceFromBoldLineToFarSideOfDots"/>
            <BoundingBox left="{g:x(.) - $distanceFromCenter}" right="{g:x(.) + $distanceFromCenter}"
                         top="{g:y1(.)}"
                         bottom="{g:y2(.)}"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message>
          WARNING: Barline <xsl:value-of select="@xml:id"/> of invalid type "<xsl:value-of select="g:type(.)"/>" is ignored.
        </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="musx:barline" mode="draw">
      <svg:g class="{normalize-space(concat('barline ',@class))}" stroke="currentColor">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:choose xmlns="NS:DEF">
            <xsl:when test="g:type(.)='normal'">
               <xsl:call-template name="drawThinBarline"/>
            </xsl:when>
            <xsl:when test="g:type(.)='double'">
               <xsl:call-template name="drawThinBarline">
                  <xsl:with-param name="offsetDirection" select="(0,-1)"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="g:type(.)=('end','repeatStart','repeatEnd')">
               <xsl:variable name="offsetDirection"
                             select="if (g:type(.)='repeatStart')                                                      then 1                                                      else -1"/>
               <xsl:variable name="boldX"
                             select="g:x(.) + $offsetDirection*.5*(g:boldLineWidth(.) - g:lineWidth(.))"/>
               <svg:line x1="{$boldX}" x2="{$boldX}" y1="{g:y1(.)}" y2="{g:y2(.)}"
                         stroke-width="{g:boldLineWidth(.)}"/>
               <xsl:call-template name="drawThinBarline">
                  <xsl:with-param name="offsetDirection" select="$offsetDirection"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="g:type(.)='repeatDouble'">
               <svg:line x1="{g:x(.)}" x2="{g:x(.)}" y1="{g:y1(.)}" y2="{g:y2(.)}"
                         stroke-width="{g:boldLineWidth(.)}"/>
               <xsl:call-template name="drawThinBarline">
                  <xsl:with-param name="offsetDirection" select="(-1,1)"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message>
          WARNING: Barline <xsl:value-of select="@xml:id"/> of invalid type "<xsl:value-of select="g:type(.)"/>" is ignored.
        </xsl:message>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template xmlns="NS:DEF" name="addLedgerLines">
    <!-- QUESTION: Allow shortened ledger lines after accidentals? (like Lilypond) -->
    <!-- $direction is set to -1 if head is above staff, else 1 -->
    <xsl:param name="direction" select="g:ledgerLines.direction(.)"/>
      <xsl:param name="staffSize" select="g:staffSize(.)"/>
      <xsl:param name="increment" select="2 * $direction * $staffSize"/>
      <xsl:param name="y" select="g:ledgerLines.y1(.)"/>
      <xsl:param name="headBoundingBox" select="g:OwnBoundingBox(musx:head)"/>
      <xsl:param name="protrusion" select="g:ledgerLines.protrusion(.)"/>
      <xsl:param name="x1" select="number($headBoundingBox//@left) - $protrusion"/>
      <xsl:param name="x2" select="number($headBoundingBox//@right) + $protrusion"/>
      <xsl:param name="finalYPlusTolerance" select="$direction * g:y(.) + .5 * $staffSize"/>
           <!-- Added tolerance ".5 * $staffSize" is for avoiding missed ledgerLines because of rounding errors -->
    
    <xsl:if test="$direction*$y &lt; $finalYPlusTolerance">
         <svg:line x1="{$x1}" x2="{$x2}" y1="{$y}" y2="{$y}"/>
         <xsl:call-template name="addLedgerLines">
            <xsl:with-param name="increment" select="$increment"/>
            <xsl:with-param name="y" select="$y + $increment"/>
            <xsl:with-param name="x1" select="$x1"/>
            <xsl:with-param name="x2" select="$x2"/>
            <xsl:with-param name="finalYPlusTolerance" select="$finalYPlusTolerance"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>
   <xsl:key xmlns="NS:DEF" name="topNote"
            match="musx:note[g:step(.) = min(g:step(key('beamNotes',ancestor-or-self::*/musx:stem/@beam)))]"
            use="generate-id(id(ancestor-or-self::*/musx:stem/@beam))"/>
   <xsl:key xmlns="NS:DEF" name="bottomNote"
            match="musx:note[g:step(.) = max(g:step(key('beamNotes',ancestor-or-self::*/musx:stem/@beam)))]"
            use="generate-id(id(ancestor-or-self::*/musx:stem/@beam))"/>
   <xsl:key xmlns="NS:DEF" name="topNote"
            match="musx:note[g:step(.) = min(g:step(parent::musx:chord/musx:note))]"
            use="generate-id(parent::musx:chord)"/>
   <xsl:key xmlns="NS:DEF" name="bottomNote"
            match="musx:note[g:step(.) = max(g:step(parent::musx:chord/musx:note))]"
            use="generate-id(parent::musx:chord)"/>
   <xsl:function xmlns="NS:DEF" name="g:calculateDirection" as="xs:integer">
      <xsl:param name="element" as="node()"/>

      <xsl:variable name="notes"
                    select="$element/(self::musx:note, self::musx:chord/musx:note, key('beamNotes',@xml:id))"/>
      <xsl:variable name="genID" select="generate-id($element)" as="xs:string"/>
      <xsl:variable name="staffCenter" select="g:lines($notes[1]/ancestor::musx:staff[last()]) - 1"
                    as="xs:integer"/>

      <!-- if average of top and bottom note is above staff center, stem goes down, otherwise up
         (if $element is a note, avg(...) returns the note's own step) -->
    <xsl:sequence select="         if (avg(               for $note in (key('topNote',$genID,$element),key('bottomNote',$genID,$element),$element/self::musx:note)                return g:step($note)            ) gt $staffCenter)         then -1         else 1"/>
  </xsl:function>
   <xsl:template match="musx:note" mode="get_OwnBoundingBox" priority="1">
      <xsl:if xmlns="NS:DEF" test="g:ledgerLines.draw(.)">
         <xsl:variable name="headBoundingBox" select="g:OwnBoundingBox(musx:head)"/>
         <xsl:variable name="protrusion" select="g:ledgerLines.protrusion(.)"/>
         <xsl:variable name="y1" select="g:ledgerLines.y1(.)"/>
         <xsl:variable name="headY" select="g:y(musx:head)"/>
         <BoundingBox left="{number($headBoundingBox//@left) - $protrusion}"
                      right="{number($headBoundingBox//@right) + $protrusion}"
                      top="{min(($headY,$y1))}"
                      bottom="{max(($headY,$y1))}"/>
      </xsl:if>
   </xsl:template>
   <xsl:template match="musx:note" mode="draw">
      <svg:g class="{normalize-space(concat('note ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:g xmlns="NS:DEF" class="ledgerlines" stroke="currentColor">
            <xsl:call-template name="addLedgerLines"/>
         </svg:g>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:head" mode="draw">
      <svg:g class="{normalize-space(concat('head ',@class))}" fill="currentColor">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:accidental" mode="draw">
      <svg:g class="{normalize-space(concat('accidental ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:chord" mode="draw">
      <svg:g class="{normalize-space(concat('chord ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:function xmlns="NS:DEF" name="g:defaultStemLength" as="xs:double">
      <xsl:param name="stem" as="element()"/>
      <xsl:for-each select="$stem">
         <xsl:sequence select="           max((             for $direction in g:direction(.),                 $stemOutletStep in   (: QUESTION: Find a better name? '$stemOutletStep' is where the stem 'leaves' a chord :)                     if (not(parent::musx:chord))                   then g:step(..)                   else if ($direction = 1)                        then g:step(g:bottomNote(..))                        else g:step(g:topNote(..)),                 $distanceFromCenter in g:direction(.) * (g:lines(ancestor::musx:staff[last()]) - 1 - $stemOutletStep)              return               if ($distanceFromCenter &gt; 7)                 then $distanceFromCenter               else if ($distanceFromCenter &gt;= 0)                 then 7               else if ($distanceFromCenter &gt; -5)                 then .4 * $distanceFromCenter + 7               else 5             ,             if (musx:flags)  (: if there are flags, the stem must be at least as long as the flags symbol :)              then for $symbolBB in g:svgSymbolBoundingBox(g:symbol(musx:flags)) return                  max((abs($symbolBB//@top),abs($symbolBB//@bottom)))                   + (if (g:direction(.) = 1) then 1 else 0)                  (: For downstemmed notes, we need to make the stem at least one step longer than the flag                   because otherwise the flag runs into the head :)             else ()           ))"/>
      </xsl:for-each>

  </xsl:function>
   <xsl:template match="musx:stem" mode="get_OwnBoundingBox" priority="1">
      <BoundingBox xmlns="NS:DEF" left="{g:x(.)}" right="{g:x(.)}" top="{min((g:y1(.),g:y2(.)))}"
                   bottom="{max((g:y1(.),g:y2(.)))}"/>
   </xsl:template>
   <xsl:template match="musx:stem" mode="draw">
      <svg:g class="{normalize-space(concat('stem ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:line xmlns="NS:DEF" x1="{g:x1(.)}" x2="{g:x2(.)}" y1="{g:y1(.)}" y2="{g:y2(.)}"
                   stroke="currentColor"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:flags" mode="draw">
      <svg:g class="{normalize-space(concat('flags ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template xmlns="NS:DEF" name="addDots">
    <!-- Start with furthest away dot. -->
    <xsl:param name="x" select="g:x1(.)"/>
      <xsl:param name="y" select="g:y(.)"/>
      <xsl:param name="distance" select="g:distance(.)"/>
      <xsl:param name="x2plusTolerance" select="g:x2(.) + .5*$distance"/>
      <xsl:param name="radius" select="g:radius(.)"/>
    
      <xsl:if test="$x &lt; $x2plusTolerance">
         <svg:circle cx="{$x}" cy="{$y}" r="{$radius}"/>
         <xsl:call-template name="addDots">
            <xsl:with-param name="x" select="$x + $distance"/>
            <xsl:with-param name="y" select="$y"/>
            <xsl:with-param name="radius" select="$radius"/>
            <xsl:with-param name="x2plusTolerance" select="$x2plusTolerance"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>
   <xsl:template match="musx:dots" mode="get_OwnBoundingBox" priority="1">
      <BoundingBox xmlns="NS:DEF" left="{g:x1(.) - g:radius(.)}" right="{g:x2(.) + g:radius(.)}"
                   top=" {g:y(.)  - g:radius(.)}"
                   bottom="{g:y(.) + g:radius(.)}"/>
   </xsl:template>
   <xsl:template match="musx:dots" mode="draw">
      <svg:g class="{normalize-space(concat('dots ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:call-template xmlns="NS:DEF" name="addDots"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:BoundingBox" mode="draw">
      <svg:g class="{normalize-space(concat('BoundingBox ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:polygon xmlns="NS:DEF" class="bbox"
                      points="{@left},{@top} {@left},{@bottom} {@right},{@bottom} {@right},{@top}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:key xmlns="NS:DEF" name="beamNotes" match="musx:note"
            use="ancestor-or-self::*/musx:stem/@beam"/>
   <xsl:key xmlns="NS:DEF" name="beamStems" match="musx:stem" use="@beam"/>
   <xsl:function xmlns="NS:DEF" name="g:beamYLacuna">
      <xsl:param name="beam" as="node()"/>
      <xsl:variable name="direction" select="g:direction($beam)" as="xs:double"/>
      <xsl:variable name="steps"
                    select="g:step(key('beamNotes',$beam/@xml:id,$beam/ancestor::document-node()))"
                    as="xs:double*"/>
      <xsl:variable name="centerStep" select="g:lines($beam/ancestor::musx:staff[last()]) - 1"
                    as="xs:double"/>
      <xsl:variable name="staffSize" select="g:staffSize($beam)" as="xs:double"/>
      <xsl:variable name="stepsSortedInBeamDirection" as="xs:double*">
         <xsl:for-each select="$steps">
            <xsl:sort select=". * $direction"/>
            <xsl:sequence select=". * $direction"/>
         </xsl:for-each>
      </xsl:variable>
      <xsl:variable name="stepClosestToBeam"
                    select="$stepsSortedInBeamDirection[last()] - $centerStep * $direction"
                    as="xs:double"/>
      <xsl:variable name="stepFurthestFromBeam"
                    select="$stepsSortedInBeamDirection[1] - $centerStep * $direction"
                    as="xs:double"/>
      <xsl:variable name="beamHeightInSteps"
                    select="((g:summedBeamNumber($beam) - 1) * g:distance($beam) + g:width($beam)) div $staffSize"
                    as="xs:double"/>
    
      <xsl:variable name="beamStepsFromCenter"
                    select="         max((           0,            $stepClosestToBeam + 4 + $beamHeightInSteps,            $stepFurthestFromBeam + 7         ))"
                    as="xs:double"/>
      <xsl:sequence select="($direction * $beamStepsFromCenter + $centerStep) * $staffSize"/>

  </xsl:function>
   <xsl:function xmlns="NS:DEF" name="g:summedBeamNumber">
      <xsl:param name="beam" as="node()*"/>
      <xsl:for-each select="$beam">
         <xsl:sequence select="max((g:summedBeamNumber(musx:subbeam), 0)) + g:number(.)"/>
      </xsl:for-each>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" name="g:beamY">
      <xsl:param name="beam" as="node()"/>
      <xsl:param name="x" as="xs:double"/>
      <xsl:param name="centerPosition" as="xs:boolean"/>
      <!-- Use basic line equation 
      y = mx + n 
      to calculate y at point x.  We move x1 of the beam to the origin, therefore we have
      y = m(x-x1) + n
      Our y-intercept is then y1, therefore
      y = m(x-x1) + y1
      m is the usual difference quotient, therefore
      y = (y2-y1)/(x2-x1) * (x-x1) + y1
      We must be careful not to divide by zero (if x2-x1=0)
    -->
    <xsl:variable name="dx" select="g:x2($beam) - g:x1($beam)"/>
      <xsl:sequence select="sum(         if($dx = 0)         then g:y1($beam)         else for $m in (g:y2($beam) - g:y1($beam)) div $dx              return $m * ($x - g:x1($beam)) + g:y1($beam)         ,         if($centerPosition)         then -.5*g:direction($beam)*g:width($beam)         else 0       )"/>
  </xsl:function>
   <xsl:template xmlns="NS:DEF" name="drawBeam">
      <xsl:param name="number" select="g:number(.)"/>
      <xsl:param name="direction" select="g:direction(.)"/>
      <xsl:param name="points">
         <xsl:variable name="x1" select="g:x1(.)"/>
         <xsl:variable name="x2" select="g:x2(.)"/>
         <xsl:variable name="y1" select="g:y1(.)"/>
         <xsl:variable name="y2" select="g:y2(.)"/>
         <xsl:variable name="directedWidth" select="$direction * g:width(.)"/>
         <xsl:value-of select="concat($x1,',',$y1,' ',                                    $x2,',',$y2,' ',                                    $x2,',',$y2 - $directedWidth,' ',                                    $x1,',',$y1 - $directedWidth)"/>
      </xsl:param> 
      <xsl:param name="yIncrement" select="g:distance(.)*$direction"/>
      <xsl:param name="yTranslate" select="0"/>
    
    
      <xsl:if test="$number &gt; 0">
         <svg:polygon points="{$points}" transform="translate(0,{$yTranslate})"/>
         <xsl:call-template name="drawBeam">
            <xsl:with-param name="yIncrement" select="$yIncrement"/>
            <xsl:with-param name="yTranslate" select="$yTranslate - $yIncrement"/>
            <xsl:with-param name="points" select="$points"/>
            <xsl:with-param name="number" select="$number - 1"/>
         </xsl:call-template>
      </xsl:if>
    
  </xsl:template>
   <xsl:template xmlns="NS:DEF" name="beamBoundingBox">
      <xsl:variable name="beamHeight"
                    select="(g:summedBeamNumber(.) - 1) * g:distance(.) + g:width(.)"/>
      <xsl:variable name="yValues" select="(g:y1(.),g:y2(.))"/>
      <xsl:choose>
         <xsl:when test="g:direction(.)=1">
            <BoundingBox left="{g:x1(.)}" right="{g:x2(.)}" top="{min($yValues) - $beamHeight}"
                         bottom="{max($yValues)}"/>
         </xsl:when>
         <xsl:otherwise>
            <BoundingBox left="{g:x1(.)}" right="{g:x2(.)}" top="{min($yValues)}"
                         bottom="{max($yValues) + $beamHeight}"/>
         </xsl:otherwise> 
      </xsl:choose>
  </xsl:template>
   <xsl:template match="musx:beam" mode="get_OwnBoundingBox" priority="1">
      <xsl:call-template xmlns="NS:DEF" name="beamBoundingBox"/>
   </xsl:template>
   <xsl:template match="musx:subbeam" mode="get_OwnBoundingBox" priority="1">
      <xsl:call-template xmlns="NS:DEF" name="beamBoundingBox"/>
   </xsl:template>
   <xsl:template match="musx:beam" mode="draw">
      <svg:g class="{normalize-space(concat('beam ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:call-template xmlns="NS:DEF" name="drawBeam"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:subbeam" mode="draw">
      <svg:g class="{normalize-space(concat('subbeam ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:call-template xmlns="NS:DEF" name="drawBeam"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:hairpin" mode="get_OwnBoundingBox" priority="1">
      <xsl:variable xmlns="NS:DEF" name="y1" select="g:y1(.)" as="xs:double"/>
      <xsl:variable xmlns="NS:DEF" name="y2" select="g:y2(.)" as="xs:double"/>
      <xsl:variable xmlns="NS:DEF" name="halfStartSpread" select="g:startSpread(.) div 2"
                    as="xs:double"/>
      <xsl:variable xmlns="NS:DEF" name="halfEndSpread" select="g:endSpread(.) div 2" as="xs:double"/>
      <BoundingBox xmlns="NS:DEF" left="{g:x1(.)}" right="{g:x2(.)}"
                   top="{   min(($y1 - $halfStartSpread,$y2 - $halfEndSpread))}"
                   bottom="{max(($y1 + $halfStartSpread,$y2 + $halfEndSpread))}"/>
   </xsl:template>
   <xsl:template match="musx:hairpin" mode="draw">
      <svg:g class="{normalize-space(concat('hairpin ',@class))}" fill="none"
             stroke="currentColor">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:variable xmlns="NS:DEF" name="x1" select="g:x1(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="x2" select="g:x2(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="y1" select="g:y1(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="y2" select="g:y2(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="halfStartSpread" select="g:startSpread(.) div 2"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="halfEndSpread" select="g:endSpread(.) div 2" as="xs:double"/>
         <svg:line xmlns="NS:DEF" x1="{$x1}" y1="{$y1 + $halfStartSpread}" x2="{$x2}"
                   y2="{$y2 + $halfEndSpread}"/>
         <svg:line xmlns="NS:DEF" x1="{$x1}" y1="{$y1 - $halfStartSpread}" x2="{$x2}"
                   y2="{$y2 - $halfEndSpread}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:function xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="g:slurDirection" as="xs:integer">
      <xsl:param name="slur" as="node()"/>
      <xsl:variable name="slurNotes" select="g:slurNotes($slur)" as="node()*"/>
      <!--    <xsl:message>
      slur notes: <xsl:copy-of select="$slurNotes"/>
    </xsl:message>-->
    <!-- TODO: Document this! -->
    <xsl:variable name="stemDirections" select="g:direction($slurNotes)" as="xs:integer*"/>
      <!-- If there are multiple voices, the slur gets the same direction as the noteheads,
         otherwise it goes into the opposite direction. That's why we're checking for other layers. -->
    <xsl:variable name="slurNotesWithConcurrentLayer"
                    select="         $slurNotes[ancestor::musx:group[@class='layer'][1]/../count(musx:group[@class='layer']) gt 1]"
                    as="element()*"/>
   
      <xsl:variable name="relevantStemDirection" as="xs:integer"
                    select="         (:(           g:direction($slurNotesWithConcurrentLayer[1]),                    )[1]:)         if ($slurNotes)         then if (count(distinct-values($stemDirections))=1 or $slurNotesWithConcurrentLayer)              then (g:direction($slurNotesWithConcurrentLayer[1]),$stemDirections)[1]              else g:calculateDirection($slurNotes)         else 1"/>
      <xsl:sequence select="if ($slurNotesWithConcurrentLayer)                           then  $relevantStemDirection                           else -$relevantStemDirection"/>
      <xsl:message>
      slurNotesWithConcurrentLayer: <xsl:value-of select="$slurNotesWithConcurrentLayer/@xml:id"/>
      </xsl:message>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="g:calculateSlurNotes" as="element()*">
      <xsl:param name="slurElement" as="element()"/>
    
      <xsl:variable name="startElement" select="g:start($slurElement)" as="element()"/>
      <xsl:variable name="endElement" select="g:end($slurElement)" as="element()"/>
    
      <xsl:variable name="startEvent" as="element()?">
         <xsl:apply-templates select="$startElement" mode="get-start-event"/>
      </xsl:variable>
      <xsl:variable name="endEvent" as="element()?">
         <xsl:apply-templates select="$endElement" mode="get-start-event"/>
      </xsl:variable>
    
      <xsl:choose>
         <xsl:when test="$slurElement = key('class','tie',$slurElement)">
            <xsl:sequence select="($startElement,$endElement)"/>
         </xsl:when>
         <xsl:when test="$startElement/self::musx:note and $endElement/self::musx:note">
            <xsl:sequence select="($startElement,                                (: QUESTION: Why doesn't $startElement/following::musx:note[following::musx:note = $endElement] work? :)                                $startElement/following::musx:note intersect $endElement/preceding::musx:note,                                $endElement)"/>
         </xsl:when>
         <xsl:when test="$startEvent and $endEvent">
        <!-- TODO: Only select notes of relevant voice => Transfer layer information from MEI. -->
        <xsl:variable name="staffID" select="$slurElement/ancestor::musx:staff[1]/generate-id()"/>
            <xsl:message>calculate slur notes for slur <xsl:value-of select="$slurElement/@xml:id"/>
            </xsl:message>
            <xsl:variable name="slurNotes">
               <xsl:for-each select="($startEvent,             $startEvent/following::musx:event intersect $endEvent/preceding::musx:event,             $endEvent)">
                  <xsl:message>test</xsl:message>
                  <xsl:sequence select="key('elements-by-staff-and-start-event',concat($staffID,'$',generate-id()))[self::musx:note]"/>
                  <!-- TODO: Restrict to one staff -->
          </xsl:for-each>
            </xsl:variable>
            <xsl:message>
               <xsl:copy-of select="$slurNotes"/>
            </xsl:message>
            <xsl:sequence select="$slurNotes"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message>
          found no slur notes
          $startEvent = <xsl:copy-of select="$startEvent"/>
          $endEvent   = <xsl:copy-of select="$endEvent"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="v:sub">
      <xsl:param name="v1" as="xs:double+"/>
      <xsl:param name="v2" as="xs:double+"/>
    
      <xsl:sequence select="($v1[1]-$v2[1],$v1[2]-$v2[2])"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="v:add">
      <xsl:param name="v1" as="xs:double+"/>
      <xsl:param name="v2" as="xs:double+"/>
    
      <xsl:sequence select="($v1[1]+$v2[1],$v1[2]+$v2[2])"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="v:pointAtDivisionRatio">
      <xsl:param name="v1" as="xs:double+"/>
      <xsl:param name="v2" as="xs:double+"/>
      <xsl:param name="divisionRatio" as="xs:double"/>
    
      <xsl:sequence select="(         $v1[1]+$divisionRatio*($v2[1]-$v1[1]),         $v1[2]+$divisionRatio*($v2[2]-$v1[2]))"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="v:mul">
      <xsl:param name="v" as="xs:double+"/>
      <xsl:param name="c" as="xs:double"/>
    
      <xsl:sequence select="($v[1]*$c,$v[2]*$c)"/>
  </xsl:function>
   <xsl:template match="musx:slur" mode="draw">
      <svg:g class="{normalize-space(concat('slur ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="El" select="(g:x1(.),g:y1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Er" select="(g:x2(.),g:y2(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="d" select="v:sub($Er,$El)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="t" select="g:tilt(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="h" select="g:height(.)*g:direction(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="s" select="g:shoulder(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="v" select="($t*$d[2],$d[1])"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="vLength"
                       select="xsb:sqrt($v[1]*$v[1]+$v[2]*$v[2])"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="vNorm"
                       select="($v[1] div $vLength,$v[2] div $vLength)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="c"
                       select="(1-$t)*$d[1]*$d[2] div (2*$vLength)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Pl"
                       select="(       $El[1]+($h + $c)*$vNorm[1],       $El[2]+($h + $c)*$vNorm[2])"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Pr"
                       select="(       $Er[1]+($h - $c)*$vNorm[1],       $Er[2]+($h - $c)*$vNorm[2])"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="M"
                       select="v:pointAtDivisionRatio($Pl,$Pr,.5*(g:shift(.)+1))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Sl"
                       select="v:pointAtDivisionRatio($M ,$Pl,$s)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Sr"
                       select="v:pointAtDivisionRatio($M ,$Pr,$s)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Ql"
                       select="v:pointAtDivisionRatio($Sl,$Pl,g:tipAngle1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Qr"
                       select="v:pointAtDivisionRatio($Sr,$Pr,g:tipAngle2(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Cl"
                       select="v:pointAtDivisionRatio($El,$Ql,g:curvature1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="Cr"
                       select="v:pointAtDivisionRatio($Er,$Qr,g:curvature2(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="thicknessDelta"
                       select="g:centerThickness(.)-g:tipThickness(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="o" select="v:mul($vNorm,$thicknessDelta)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="ol" select="v:mul($o,g:swellingRate1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:v="NS:VECTOR" name="or" select="v:mul($o,g:swellingRate2(.))"
                       as="xs:double+"/>
         <svg:path xmlns="NS:DEF" xmlns:v="NS:VECTOR" fill="currentColor" stroke="currentColor"
                   stroke-width="{g:tipThickness(.)}"
                   d="M{$El}         C{(v:add($Cl,$ol),v:add($Sl,$o ),v:add($M,$o))}         C{(v:add($Sr,$o ),v:add($Cr,$or),$Er)}         C{(v:sub($Cr,$or),v:sub($Sr,$o ),v:sub($M,$o))}         C{(v:sub($Sl,$o ),v:sub($Cl,$ol),$El)}         z"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:key xmlns="NS:DEF" name="unicode-glyph" match="svg:glyph"
            use="string-to-codepoints(@unicode)"/>
   <xsl:function xmlns="NS:DEF" name="def:getGlyphWidth" as="xs:double*">
			   <xsl:param name="string" as="xs:string"/>
			   <xsl:for-each select="string-to-codepoints($string)">
				<!-- TODO: Modify this so that document() can also take the URI of a file with other font metadata -->
				<xsl:sequence select="number(key('unicode-glyph',.,document(concat($libDirectory,'/',$symbolFile)))/@horiz-adv-x)"/>
			   </xsl:for-each>
		</xsl:function>
   <xsl:function xmlns="NS:DEF" name="def:drawSymbols" as="node()*">
			   <xsl:param name="string" as="xs:string"/>
			   <xsl:param name="x" as="xs:double"/>
			
			   <xsl:variable name="char" select="substring($string,1,1)"/>
			
			   <xsl:variable name="symbolName"
                    select="       if($char='.') then 'period'       else if($char='+') then 'plus'       else $char"
                    as="xs:string"/>
			
			   <xsl:if test="string-length($string) gt 0">
				     <svg:use xlink:href="{$libDirectory}/{$symbolFile}#ascii.{$symbolName}" x="{$x}"/>
				     <xsl:sequence select="def:drawSymbols(substring($string,2),$x + def:getGlyphWidth($char))"/>
			   </xsl:if>
		</xsl:function>
   <xsl:template match="musx:symbolText" mode="draw">
      <svg:g class="{normalize-space(concat('symbolText ',@class))}"
             transform="translate({g:x1(.)},{g:y(.)}) scale({g:size(.)})">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:sequence xmlns="NS:DEF" select="def:drawSymbols(text(), 0)"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:keySignature" mode="get_OwnBoundingBox" priority="1">
      <xsl:variable xmlns="NS:DEF" name="x" select="g:x(.)"/>
      <xsl:variable xmlns="NS:DEF" name="y" select="g:y(.)"/>
      <xsl:variable xmlns="NS:DEF" name="size" select="g:size(.)"/>
      <xsl:variable xmlns="NS:DEF" name="staffSize" select="g:staffSize(.)"/>
      <xsl:variable xmlns="NS:DEF" name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))"
                    as="element()"/>
      <xsl:variable xmlns="NS:DEF" name="steps" as="xs:integer*">
         <xsl:for-each select="tokenize(normalize-space(g:pattern(.)),'\s+')">
            <xsl:sequence select=". cast as xs:integer"/>
         </xsl:for-each>
      </xsl:variable>
      <BoundingBox xmlns="NS:DEF" left="{$x}"
                   right="{$x + count($steps)*g:distance(.) + $symbolBBox/@right*$size}"
                   top="{   $y + min($steps)*$staffSize + $symbolBBox/@top*$size}"
                   bottom="{$y + max($steps)*$staffSize + $symbolBBox/@bottom*$size}"/>
   </xsl:template>
   <xsl:template match="musx:keySignature" mode="draw">
      <svg:g class="{normalize-space(concat('keySignature ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:variable xmlns="NS:DEF" name="steps"
                       select="tokenize(normalize-space(g:pattern(.)),'\s+')"
                       as="xs:string*"/>
         <xsl:variable xmlns="NS:DEF" name="staffSize" select="g:staffSize(.)" as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="distance" select="g:distance(.) div $staffSize"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" name="symbol" select="g:symbol(.)"/>
         <svg:g xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({$staffSize})">
            <xsl:for-each select="$steps">
               <svg:use x="{(position()-1) * $distance}" y="{number(.)}" xlink:href="{$symbol}"/>
            </xsl:for-each>
         </svg:g>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template xmlns="NS:DEF" match="@symbol" mode="render-time-signature">
      <svg:use transform="translate({g:x(..)},{g:y(..)}) scale({g:size(..)})"
               xlink:href="{g:symbol(..)}"/>
  </xsl:template>
   <xsl:template match="musx:timeSignature" mode="draw">
      <svg:g class="{normalize-space(concat('timeSignature ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates xmlns="NS:DEF" select="@symbol" mode="render-time-signature"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:fraction" mode="draw">
      <svg:g class="{normalize-space(concat('fraction ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="musx:articulation" mode="draw">
      <svg:g class="{normalize-space(concat('articulation ',@class))}">
         <xsl:apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <xsl:apply-templates mode="draw"/>
      </svg:g>
   </xsl:template>
   <xsl:template match="@xml:id" mode="copy-svg-and-id-attributes">
      <xsl:attribute name="id">
         <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@svg:*" mode="copy-svg-and-id-attributes">
      <xsl:attribute name="{local-name()}">
         <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@*" mode="copy-svg-and-id-attributes"/>
   <xsl:template match="node()" mode="draw" priority="-5"/>
   <xsl:template match="musx:musxHead" mode="generate-defs">
      <svg:defs>
         <xsl:apply-templates mode="generate-defs"/>
      </svg:defs>
   </xsl:template>
   <xsl:template match="*" mode="generate-defs" priority="-1"/>
   <xsl:template match="svg:*" mode="generate-defs">
      <xsl:copy-of select="."/>
   </xsl:template>
   <xsl:template match="/" priority="-10">
      <xsl:apply-templates select="." mode="musx2svg"/>
   </xsl:template>
   <xsl:template match="/musx:musx" mode="musx2svg">
      <svg:svg width="{g:x2(//musx:page[1])}" height="{g:y2(//musx:page[1])}">
         <xsl:apply-templates select="musx:musxHead[*]" mode="generate-defs"/>
         <xsl:apply-templates mode="draw"/>
      </svg:svg>
   </xsl:template>
   <xsl:template match="@*|node()" mode="add-bounding-boxes">
      <xsl:copy>
         <xsl:apply-templates mode="add-bounding-boxes" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template match="musx:*" mode="add-bounding-boxes" priority="1">
      <xsl:variable name="children" as="node()*">
         <xsl:apply-templates mode="add-bounding-boxes" select="node()"/>
      </xsl:variable>
      <xsl:variable name="allBoundingBoxes" as="element()*">
         <xsl:sequence select="$children/musx:BoundingBox"/>
         <xsl:apply-templates mode="get_OwnBoundingBox" select="."/>
      </xsl:variable>
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:copy-of select="$children"/>
         <xsl:if test="$allBoundingBoxes">
            <musx:BoundingBox left="{min($allBoundingBoxes//@left)}" right="{max($allBoundingBoxes//@right)}"
                              top="{min($allBoundingBoxes//@top)}"
                              bottom="{max($allBoundingBoxes//@bottom)}"/>
         </xsl:if>
      </xsl:copy>
   </xsl:template>
   <xsl:template match="node()|@*" mode="get_OwnBoundingBox" priority="-2"/>
   <xsl:function name="g:OwnBoundingBox" as="element()*">
      <xsl:param name="element" as="element()*"/>
      <xsl:apply-templates select="$element" mode="get_OwnBoundingBox"/>
   </xsl:function>
   <xsl:function name="g:staffSize" as="xs:double*">
      <xsl:param name="element" as="element()*"/>
      <xsl:sequence select="g:size($element/ancestor::musx:staff[last()])"/>
   </xsl:function>
   <xsl:key name="svgID" match="svg:*[@id]" use="@id"/>
   <xsl:function name="g:svgSymbolBoundingBox" as="element()*">
      <xsl:param name="symbolURI" as="xs:string*"/>
      <xsl:for-each select="$symbolURI">
         <xsl:variable name="symbolID" select="substring-after(.,'#')" as="xs:string"/>
         <xsl:variable name="documentURI" select="substring-before(.,'#')" as="xs:string"/>
         <xsl:sequence select="key('svgID',$symbolID,document($documentURI))/svg:metadata/*:bbox"/>
      </xsl:for-each>
   </xsl:function>
   <xsl:template match="/" mode="svg-with-bounding-boxes">
      <xsl:variable name="musxWithBoundingBoxes">
         <xsl:apply-templates select="." mode="add-bounding-boxes"/>
      </xsl:variable>
      <xsl:apply-templates select="$musxWithBoundingBoxes/musx:musx" mode="musx2svg"/>
   </xsl:template>
</xsl:stylesheet>

