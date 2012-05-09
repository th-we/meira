<?xml version="1.0" encoding="UTF-8"?>

<stylesheet xmlns:musx="NS:MUSX" xmlns:xsl-ns="http://www.w3.org/1999/XSL/Transform"
            xmlns:xsb="http://www.expedimentum.org/XSLT/SB"
            xmlns="http://www.w3.org/1999/XSL/Transform"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:svg="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:def="NS:DEF"
            xmlns:g="NS:GET"
            version="2.0"
            exclude-result-prefixes="xs def g musx svg">
   <import href="math/math.xsl"/>
   <param name="libDirectory"
          select="if (/musx:musx) then /musx:musx/musx:musxHead/musx:libDirectory/@xlink:href else 'lib'"
          as="xs:string"/>
   <param name="musicFont" select="'musicSymbols'" as="xs:string"/>
   <param name="symbolFile" select="'symbols.svg'" as="xs:string"/>
   <function name="g:end" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_end"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:x1" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_x1"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:x2" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_x2"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:y" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_y"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:x" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_x"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:y1" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_y1"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:y2" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_y2"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:size" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_size"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:start" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_start"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:lines" as="xs:integer*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:integer*">
         <apply-templates select="$elements" mode="get_lines"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:symbol" as="xs:string*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:string*">
         <apply-templates select="$elements" mode="get_symbol"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise/>
      </choose>
   </function>
   <function name="g:placement" as="xs:string*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:string*">
         <apply-templates select="$elements" mode="get_placement"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise/>
      </choose>
   </function>
   <function name="g:width" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_width"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:direction" as="xs:integer*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:integer*">
         <apply-templates select="$elements" mode="get_direction"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:step" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_step"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:topStaff" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_topStaff"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:bottomStaff" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_bottomStaff"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:brackettip" as="xs:string*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:string*">
         <apply-templates select="$elements" mode="get_brackettip"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise/>
      </choose>
   </function>
   <function name="g:lineOffset" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_lineOffset"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:dotOffset" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_dotOffset"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:dotRadius" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_dotRadius"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:lineWidth" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_lineWidth"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:boldLineWidth" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_boldLineWidth"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:type" as="xs:string*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:string*">
         <apply-templates select="$elements" mode="get_type"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise/>
      </choose>
   </function>
   <function name="g:function" as="xs:string*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:string*">
         <apply-templates select="$elements" mode="get_function"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise/>
      </choose>
   </function>
   <function name="g:ledgerLines.direction" as="xs:integer*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:integer*">
         <apply-templates select="$elements" mode="get_ledgerLines.direction"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:ledgerLines.y1" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_ledgerLines.y1"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:ledgerLines.y2" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_ledgerLines.y2"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="0"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:ledgerLines.draw" as="xs:boolean*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:boolean*">
         <apply-templates select="$elements" mode="get_ledgerLines.draw"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="true()"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:ledgerLines.protrusion" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_ledgerLines.protrusion"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:flip" as="xs:integer*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:integer*">
         <apply-templates select="$elements" mode="get_flip"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:topNote" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_topNote"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:bottomNote" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_bottomNote"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:beam" as="node()*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="node()*">
         <apply-templates select="$elements" mode="get_beam"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <sequence select="$elements/.."/>
         </otherwise>
      </choose>
   </function>
   <function name="g:length" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_length"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:number" as="xs:integer*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:integer*">
         <apply-templates select="$elements" mode="get_number"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:offset" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_offset"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:distance" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_distance"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:radius" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_radius"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:startSpread" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_startSpread"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:endSpread" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_endSpread"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:height" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_height"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:centerThickness" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_centerThickness"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:tipThickness" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_tipThickness"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>
            <copy-of select="1"/>
         </otherwise>
      </choose>
   </function>
   <function name="g:swellingRate" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_swellingRate"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:swellingRate1" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_swellingRate1"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:swellingRate2" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_swellingRate2"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:tilt" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_tilt"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:shift" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_shift"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:shoulder" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_shoulder"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:curvature" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_curvature"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:curvature1" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_curvature1"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:curvature2" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_curvature2"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:tipAngle" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_tipAngle"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:tipAngle1" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_tipAngle1"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:tipAngle2" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_tipAngle2"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:textAnchor" as="xs:double*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:double*">
         <apply-templates select="$elements" mode="get_textAnchor"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise>0</otherwise>
      </choose>
   </function>
   <function name="g:pattern" as="xs:string*">
      <param name="elements" as="element()*"/>
      <variable name="result" as="xs:string*">
         <apply-templates select="$elements" mode="get_pattern"/>
      </variable>
      <choose>
         <when test="count($result) != 0">
            <sequence select="$result"/>
         </when>
         <otherwise/>
      </choose>
   </function>
   <template mode="get_end" match="musx:page" priority="-1">
      <sequence select="."/>
   </template>
   <template mode="get_end" match="musx:page[@end]">
      <sequence select="id(@end)"/>
   </template>
   <key name="get_x1_page" use="substring(@x1,1,1)" match="musx:page"/>
   <template mode="get_x1" match="musx:page" priority="-2">
      <copy-of select="(0) + (0)"/>
   </template>
   <template mode="get_x1" match="musx:page[@x1]" priority="-1">
      <copy-of select="number(@x1)"/>
   </template>
   <template mode="get_x1" match="key('get_x1_page','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(0) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_page','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_page','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(0) + (g:size($staff) * number(substring(@x1,2)))"/>
   </template>
   <key name="get_x2_page_system_staff_staffGroup_rest_group_hairpin_slur"
        use="substring(@x2,1,1)"
        match="musx:page|musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin|musx:slur"/>
   <template mode="get_x2"
             match="musx:page|musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin|musx:slur"
             priority="-2">
      <copy-of select="(g:x(g:end(.))) + (0)"/>
   </template>
   <template mode="get_x2"
             match="musx:page[@x2]|musx:system[@x2]|musx:staff[@x2]|musx:staffGroup[@x2]|musx:rest[@x2]|musx:group[@x2]|musx:hairpin[@x2]|musx:slur[@x2]"
             priority="-1">
      <copy-of select="number(@x2)"/>
   </template>
   <template mode="get_x2"
             match="key('get_x2_page_system_staff_staffGroup_rest_group_hairpin_slur','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(g:end(.))) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2"
             match="key('get_x2_page_system_staff_staffGroup_rest_group_hairpin_slur','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2"
             match="key('get_x2_page_system_staff_staffGroup_rest_group_hairpin_slur','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(g:end(.))) + (g:size($staff) * number(substring(@x2,2)))"/>
   </template>
   <key name="get_y_page" use="substring(@y,1,1)" match="musx:page"/>
   <template mode="get_y" match="musx:page" priority="-2">
      <copy-of select="(0) + (0)"/>
   </template>
   <template mode="get_y" match="musx:page[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_page','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(0) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_page','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_page','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(0) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_page','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_page','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_x_page_event" use="substring(@x,1,1)" match="musx:page|musx:event"/>
   <template mode="get_x" match="musx:page|musx:event" priority="-2">
      <copy-of select="(0) + (0)"/>
   </template>
   <template mode="get_x" match="musx:page[@x]|musx:event[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_page_event','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(0) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_page_event','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_page_event','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(0) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_y1_page" use="substring(@y1,1,1)" match="musx:page"/>
   <template mode="get_y1" match="musx:page" priority="-2">
      <copy-of select="(0) + (0)"/>
   </template>
   <template mode="get_y1" match="musx:page[@y1]" priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1" match="key('get_y1_page','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(0) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_page','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_page','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(0) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_page','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_page','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_page" use="substring(@y2,1,1)" match="musx:page"/>
   <template mode="get_y2" match="musx:page" priority="-2">
      <copy-of select="(0) + (0)"/>
   </template>
   <template mode="get_y2" match="musx:page[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_page','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(0) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_page','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_page','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(0) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_page','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_page','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <key name="get_size_page" use="substring(@size,1,1)" match="musx:page"/>
   <template mode="get_size" priority="-2" match="musx:page">
      <copy-of select="(1) * (1)"/>
   </template>
   <template mode="get_size" match="musx:page[@size]" priority="-1">
      <copy-of select="number(@size)"/>
   </template>
   <template mode="get_size" match="key('get_size_page','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@size,2))"/>
   </template>
   <template mode="get_size" match="key('get_size_page','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@size,2))"/>
   </template>
   <template mode="get_start"
             match="musx:system|musx:svg|musx:clef|musx:rest|musx:barline|musx:note|musx:chord|musx:beam|musx:hairpin|musx:slur|musx:symbolText|musx:keySignature|musx:timeSignature|musx:articulation"
             priority="-1">
      <sequence select=".."/>
   </template>
   <template mode="get_start"
             match="musx:system[@start]|musx:svg[@start]|musx:clef[@start]|musx:rest[@start]|musx:barline[@start]|musx:note[@start]|musx:chord[@start]|musx:beam[@start]|musx:hairpin[@start]|musx:slur[@start]|musx:symbolText[@start]|musx:keySignature[@start]|musx:timeSignature[@start]|musx:articulation[@start]">
      <sequence select="id(@start)"/>
   </template>
   <template mode="get_end" match="musx:system|musx:beam|musx:slur" priority="-1">
      <sequence select=".."/>
   </template>
   <template mode="get_end" match="musx:system[@end]|musx:beam[@end]|musx:slur[@end]">
      <sequence select="id(@end)"/>
   </template>
   <key name="get_x1_system_staff_staffGroup_rest_group_hairpin_slur"
        use="substring(@x1,1,1)"
        match="musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin|musx:slur"/>
   <template mode="get_x1"
             match="musx:system|musx:staff|musx:staffGroup|musx:rest|musx:group|musx:hairpin|musx:slur"
             priority="-2">
      <copy-of select="(g:x(g:start(.))) + (0)"/>
   </template>
   <template mode="get_x1"
             match="musx:system[@x1]|musx:staff[@x1]|musx:staffGroup[@x1]|musx:rest[@x1]|musx:group[@x1]|musx:hairpin[@x1]|musx:slur[@x1]"
             priority="-1">
      <copy-of select="number(@x1)"/>
   </template>
   <template mode="get_x1"
             match="key('get_x1_system_staff_staffGroup_rest_group_hairpin_slur','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1"
             match="key('get_x1_system_staff_staffGroup_rest_group_hairpin_slur','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1"
             match="key('get_x1_system_staff_staffGroup_rest_group_hairpin_slur','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x1,2)))"/>
   </template>
   <key name="get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation"
        use="substring(@y,1,1)"
        match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:group|musx:note|musx:head|musx:accidental|musx:hairpin|musx:keySignature|musx:fraction|musx:articulation"/>
   <template mode="get_y"
             match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:group|musx:note|musx:head|musx:accidental|musx:hairpin|musx:keySignature|musx:fraction|musx:articulation"
             priority="-2">
      <copy-of select="(g:y(..)) + (0)"/>
   </template>
   <template mode="get_y"
             match="musx:system[@y]|musx:staff[@y]|musx:staffGroup[@y]|musx:svg[@y]|musx:clef[@y]|musx:group[@y]|musx:note[@y]|musx:head[@y]|musx:accidental[@y]|musx:hairpin[@y]|musx:keySignature[@y]|musx:fraction[@y]|musx:articulation[@y]"
             priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y"
             match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_system_staff_staffGroup_svg_clef_group_note_head_accidental_hairpin_keySignature_fraction_articulation','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur"
        use="substring(@x,1,1)"
        match="musx:system|musx:staff|musx:staffGroup|musx:group|musx:beam|musx:subbeam|musx:hairpin|musx:slur"/>
   <template mode="get_x"
             match="musx:system|musx:staff|musx:staffGroup|musx:group|musx:beam|musx:subbeam|musx:hairpin|musx:slur"
             priority="-2">
      <copy-of select="(g:x1(.)) + (0)"/>
   </template>
   <template mode="get_x"
             match="musx:system[@x]|musx:staff[@x]|musx:staffGroup[@x]|musx:group[@x]|musx:beam[@x]|musx:subbeam[@x]|musx:hairpin[@x]|musx:slur[@x]"
             priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x"
             match="key('get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x1(.)) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x"
             match="key('get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x"
             match="key('get_x_system_staff_staffGroup_group_beam_subbeam_hairpin_slur','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x1(.)) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation"
        use="substring(@y1,1,1)"
        match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <template mode="get_y1"
             match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
             priority="-2">
      <copy-of select="(g:y(.)) + (0)"/>
   </template>
   <template mode="get_y1"
             match="musx:system[@y1]|musx:staff[@y1]|musx:staffGroup[@y1]|musx:svg[@y1]|musx:clef[@y1]|musx:transposeNumber[@y1]|musx:rest[@y1]|musx:group[@y1]|musx:note[@y1]|musx:head[@y1]|musx:accidental[@y1]|musx:flags[@y1]|musx:dots[@y1]|musx:beam[@y1]|musx:hairpin[@y1]|musx:symbolText[@y1]|musx:keySignature[@y1]|musx:timeSignature[@y1]|musx:fraction[@y1]|musx:articulation[@y1]"
             priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1"
             match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(.)) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1"
             match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1"
             match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(.)) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1"
             match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1"
             match="key('get_y1_system_staff_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation"
        use="substring(@y2,1,1)"
        match="musx:system|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <template mode="get_y2"
             match="musx:system|musx:staffGroup|musx:svg|musx:clef|musx:transposeNumber|musx:rest|musx:group|musx:note|musx:head|musx:accidental|musx:flags|musx:dots|musx:beam|musx:hairpin|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
             priority="-2">
      <copy-of select="(g:y(.)) + (0)"/>
   </template>
   <template mode="get_y2"
             match="musx:system[@y2]|musx:staffGroup[@y2]|musx:svg[@y2]|musx:clef[@y2]|musx:transposeNumber[@y2]|musx:rest[@y2]|musx:group[@y2]|musx:note[@y2]|musx:head[@y2]|musx:accidental[@y2]|musx:flags[@y2]|musx:dots[@y2]|musx:beam[@y2]|musx:hairpin[@y2]|musx:symbolText[@y2]|musx:keySignature[@y2]|musx:timeSignature[@y2]|musx:fraction[@y2]|musx:articulation[@y2]"
             priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2"
             match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(.)) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2"
             match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2"
             match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(.)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2"
             match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2"
             match="key('get_y2_system_staffGroup_svg_clef_transposeNumber_rest_group_note_head_accidental_flags_dots_beam_hairpin_symbolText_keySignature_timeSignature_fraction_articulation','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <key name="get_size_system_staff_staffGroup_svg_clef_rest_group_staffBracket_barline_note_head_accidental_chord_stem_flags_dots_beam_subbeam_hairpin_slur_symbolText_keySignature_timeSignature_fraction_articulation"
        use="substring(@size,1,1)"
        match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:rest|musx:group|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:dots|musx:beam|musx:subbeam|musx:hairpin|musx:slur|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <template mode="get_size" priority="-2"
             match="musx:system|musx:staff|musx:staffGroup|musx:svg|musx:clef|musx:rest|musx:group|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:dots|musx:beam|musx:subbeam|musx:hairpin|musx:slur|musx:symbolText|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation">
      <copy-of select="(g:size(..)) * (1)"/>
   </template>
   <template mode="get_size"
             match="musx:system[@size]|musx:staff[@size]|musx:staffGroup[@size]|musx:svg[@size]|musx:clef[@size]|musx:rest[@size]|musx:group[@size]|musx:staffBracket[@size]|musx:barline[@size]|musx:note[@size]|musx:head[@size]|musx:accidental[@size]|musx:chord[@size]|musx:stem[@size]|musx:flags[@size]|musx:dots[@size]|musx:beam[@size]|musx:subbeam[@size]|musx:hairpin[@size]|musx:slur[@size]|musx:symbolText[@size]|musx:keySignature[@size]|musx:timeSignature[@size]|musx:fraction[@size]|musx:articulation[@size]"
             priority="-1">
      <copy-of select="number(@size)"/>
   </template>
   <template mode="get_size"
             match="key('get_size_system_staff_staffGroup_svg_clef_rest_group_staffBracket_barline_note_head_accidental_chord_stem_flags_dots_beam_subbeam_hairpin_slur_symbolText_keySignature_timeSignature_fraction_articulation','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@size,2))"/>
   </template>
   <template mode="get_size"
             match="key('get_size_system_staff_staffGroup_svg_clef_rest_group_staffBracket_barline_note_head_accidental_chord_stem_flags_dots_beam_subbeam_hairpin_slur_symbolText_keySignature_timeSignature_fraction_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@size,2))"/>
   </template>
   <template mode="get_start" match="musx:staff|musx:staffGroup|musx:group|musx:subbeam"
             priority="-1">
      <sequence select="g:start(..)"/>
   </template>
   <template mode="get_start"
             match="musx:staff[@start]|musx:staffGroup[@start]|musx:group[@start]|musx:subbeam[@start]">
      <sequence select="id(@start)"/>
   </template>
   <template mode="get_end" match="musx:staff|musx:staffGroup|musx:group|musx:subbeam"
             priority="-1">
      <sequence select="g:end(..)"/>
   </template>
   <template mode="get_end"
             match="musx:staff[@end]|musx:staffGroup[@end]|musx:group[@end]|musx:subbeam[@end]">
      <sequence select="id(@end)"/>
   </template>
   <key name="get_y2_staff" use="substring(@y2,1,1)" match="musx:staff"/>
   <template mode="get_y2" match="musx:staff" priority="-2">
      <copy-of select="(g:y1(.)) + (2 * g:size(.) * (g:lines(.) - 1))"/>
   </template>
   <template mode="get_y2" match="musx:staff[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staff','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y1(.)) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staff','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staff','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1(.)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staff','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staff','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <template mode="get_lines" match="musx:staff" priority="-1">
      <copy-of select="5"/>
   </template>
   <template mode="get_lines" match="musx:staff[@lines]">
      <copy-of select="@lines cast as xs:integer"/>
   </template>
   <key name="get_x_svg_clef_barline_note_chord_keySignature_timeSignature"
        use="substring(@x,1,1)"
        match="musx:svg|musx:clef|musx:barline|musx:note|musx:chord|musx:keySignature|musx:timeSignature"/>
   <template mode="get_x"
             match="musx:svg|musx:clef|musx:barline|musx:note|musx:chord|musx:keySignature|musx:timeSignature"
             priority="-2">
      <copy-of select="(g:x(g:start(.))) + (0)"/>
   </template>
   <template mode="get_x"
             match="musx:svg[@x]|musx:clef[@x]|musx:barline[@x]|musx:note[@x]|musx:chord[@x]|musx:keySignature[@x]|musx:timeSignature[@x]"
             priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x"
             match="key('get_x_svg_clef_barline_note_chord_keySignature_timeSignature','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x"
             match="key('get_x_svg_clef_barline_note_chord_keySignature_timeSignature','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x"
             match="key('get_x_svg_clef_barline_note_chord_keySignature_timeSignature','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation"
        use="substring(@x1,1,1)"
        match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <template mode="get_x1"
             match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
             priority="-2">
      <copy-of select="(g:x(.)) + (0)"/>
   </template>
   <template mode="get_x1"
             match="musx:svg[@x1]|musx:clef[@x1]|musx:transposeNumber[@x1]|musx:staffBracket[@x1]|musx:barline[@x1]|musx:note[@x1]|musx:head[@x1]|musx:accidental[@x1]|musx:chord[@x1]|musx:stem[@x1]|musx:flags[@x1]|musx:keySignature[@x1]|musx:timeSignature[@x1]|musx:fraction[@x1]|musx:articulation[@x1]"
             priority="-1">
      <copy-of select="number(@x1)"/>
   </template>
   <template mode="get_x1"
             match="key('get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(.)) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1"
             match="key('get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1"
             match="key('get_x1_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x1,2)))"/>
   </template>
   <key name="get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation"
        use="substring(@x2,1,1)"
        match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"/>
   <template mode="get_x2"
             match="musx:svg|musx:clef|musx:transposeNumber|musx:staffBracket|musx:barline|musx:note|musx:head|musx:accidental|musx:chord|musx:stem|musx:flags|musx:keySignature|musx:timeSignature|musx:fraction|musx:articulation"
             priority="-2">
      <copy-of select="(g:x(.)) + (0)"/>
   </template>
   <template mode="get_x2"
             match="musx:svg[@x2]|musx:clef[@x2]|musx:transposeNumber[@x2]|musx:staffBracket[@x2]|musx:barline[@x2]|musx:note[@x2]|musx:head[@x2]|musx:accidental[@x2]|musx:chord[@x2]|musx:stem[@x2]|musx:flags[@x2]|musx:keySignature[@x2]|musx:timeSignature[@x2]|musx:fraction[@x2]|musx:articulation[@x2]"
             priority="-1">
      <copy-of select="number(@x2)"/>
   </template>
   <template mode="get_x2"
             match="key('get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(.)) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2"
             match="key('get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2"
             match="key('get_x2_svg_clef_transposeNumber_staffBracket_barline_note_head_accidental_chord_stem_flags_keySignature_timeSignature_fraction_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x2,2)))"/>
   </template>
   <template mode="get_symbol" match="musx:clef|musx:timeSignature" priority="-1">
      <value-of select="concat($libDirectory,'/',$symbolFile,'#','clef.G')"/>
   </template>
   <template mode="get_symbol"
             match="musx:clef[contains(@symbol,'.')]|musx:timeSignature[contains(@symbol,'.')]"
             priority="2">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </template>
   <template mode="get_symbol" match="musx:clef[@symbol]|musx:timeSignature[@symbol]">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </template>
   <template mode="get_OwnBoundingBox" match="musx:clef|musx:timeSignature" priority="-1">
      <variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <if test="$symbolBBox">
         <variable name="size" select="g:size(.)"/>
         <variable name="x" select="g:x(.)"/>
         <variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </if>
   </template>
   <key name="get_x_transposeNumber_staffBracket_flags_dots_fraction"
        use="substring(@x,1,1)"
        match="musx:transposeNumber|musx:staffBracket|musx:flags|musx:dots|musx:fraction"/>
   <template mode="get_x"
             match="musx:transposeNumber|musx:staffBracket|musx:flags|musx:dots|musx:fraction"
             priority="-2">
      <copy-of select="(g:x(..)) + (0)"/>
   </template>
   <template mode="get_x"
             match="musx:transposeNumber[@x]|musx:staffBracket[@x]|musx:flags[@x]|musx:dots[@x]|musx:fraction[@x]"
             priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x"
             match="key('get_x_transposeNumber_staffBracket_flags_dots_fraction','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(..)) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x"
             match="key('get_x_transposeNumber_staffBracket_flags_dots_fraction','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x"
             match="key('get_x_transposeNumber_staffBracket_flags_dots_fraction','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_y_transposeNumber" use="substring(@y,1,1)"
        match="musx:transposeNumber"/>
   <template mode="get_y" match="musx:transposeNumber" priority="-2">
      <copy-of select="(       if(g:placement(.)='above')         then g:OwnBoundingBox(..)//@top         else g:OwnBoundingBox(..)//@bottom + g:size(.)       ) + (0)"/>
   </template>
   <template mode="get_y" match="musx:transposeNumber[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_transposeNumber','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(       if(g:placement(.)='above')         then g:OwnBoundingBox(..)//@top         else g:OwnBoundingBox(..)//@bottom + g:size(.)       ) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_transposeNumber','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_transposeNumber','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(       if(g:placement(.)='above')         then g:OwnBoundingBox(..)//@top         else g:OwnBoundingBox(..)//@bottom + g:size(.)       ) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_transposeNumber','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_transposeNumber','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <template mode="get_placement" match="musx:transposeNumber" priority="-1">
      <copy-of select="'top'"/>
   </template>
   <template mode="get_placement" match="musx:transposeNumber[@placement]">
      <copy-of select="@placement cast as xs:string"/>
   </template>
   <key name="get_size_transposeNumber" use="substring(@size,1,1)"
        match="musx:transposeNumber"/>
   <template mode="get_size" priority="-2" match="musx:transposeNumber">
      <copy-of select="(g:size(..)) * (4)"/>
   </template>
   <template mode="get_size" match="musx:transposeNumber[@size]" priority="-1">
      <copy-of select="number(@size)"/>
   </template>
   <template mode="get_size" match="key('get_size_transposeNumber','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@size,2))"/>
   </template>
   <template mode="get_size" match="key('get_size_transposeNumber','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@size,2))"/>
   </template>
   <template mode="get_end" match="musx:rest|musx:hairpin" priority="-1">
      <sequence select="g:start(.)"/>
   </template>
   <template mode="get_end" match="musx:rest[@end]|musx:hairpin[@end]">
      <sequence select="id(@end)"/>
   </template>
   <key name="get_x_rest" use="substring(@x,1,1)" match="musx:rest"/>
   <template mode="get_x" match="musx:rest" priority="-2">
      <copy-of select="((g:x1(.) + g:x2(.)) div 2) + (if (@end or @x2)                                                                                     then g:width(.) div -2                                                                                     else 0)"/>
   </template>
   <template mode="get_x" match="musx:rest[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_rest','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="((g:x1(.) + g:x2(.)) div 2) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_rest','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_rest','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="((g:x1(.) + g:x2(.)) div 2) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_y_rest" use="substring(@y,1,1)" match="musx:rest"/>
   <template mode="get_y" match="musx:rest" priority="-2">
      <copy-of select="(g:y(..)) + (-4 * g:size(ancestor::staff))"/>
   </template>
   <template mode="get_y" match="musx:rest[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_rest','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_rest','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_rest','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_rest','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_rest','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_width_rest_head_articulation" use="substring(@width,1,1)"
        match="musx:rest|musx:head|musx:articulation"/>
   <template mode="get_width" priority="-2" match="musx:rest|musx:head|musx:articulation">
      <copy-of select="(g:size(.)) * (number(g:svgSymbolBoundingBox(g:symbol(.))//@right))"/>
   </template>
   <template mode="get_width"
             match="musx:rest[@width]|musx:head[@width]|musx:articulation[@width]"
             priority="-1">
      <copy-of select="number(@width)"/>
   </template>
   <template mode="get_width" match="key('get_width_rest_head_articulation','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@width,2))"/>
   </template>
   <template mode="get_width" match="key('get_width_rest_head_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </template>
   <template mode="get_direction" match="musx:rest" priority="-1">
      <copy-of select="       if (musx:stem/@direction)       then g:direction(musx:stem[1])       else if (g:step(.) &lt; g:lines(ancestor::musx:staff[last()]))       then 1       else -1"/>
   </template>
   <template mode="get_direction" match="musx:rest[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <template mode="get_step" match="musx:rest" priority="-1">
      <copy-of select="       if(substring(@y,1,1)='S')       then number(substring(@y,2))       else (g:y(.) - g:y(ancestor::musx:staff[last()])) div g:staffSize(.)"/>
   </template>
   <template mode="get_step" match="musx:rest[@step]">
      <copy-of select="@step cast as xs:double"/>
   </template>
   <template mode="get_symbol"
             match="musx:rest|musx:accidental|musx:keySignature|musx:articulation"
             priority="-1">
      <value-of select="concat($libDirectory,'/',$symbolFile,'#','')"/>
   </template>
   <template mode="get_symbol"
             match="musx:rest[contains(@symbol,'.')]|musx:accidental[contains(@symbol,'.')]|musx:keySignature[contains(@symbol,'.')]|musx:articulation[contains(@symbol,'.')]"
             priority="2">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </template>
   <template mode="get_symbol"
             match="musx:rest[@symbol]|musx:accidental[@symbol]|musx:keySignature[@symbol]|musx:articulation[@symbol]">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </template>
   <template mode="get_OwnBoundingBox"
             match="musx:rest|musx:accidental|musx:keySignature|musx:articulation"
             priority="-1">
      <variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <if test="$symbolBBox">
         <variable name="size" select="g:size(.)"/>
         <variable name="x" select="g:x(.)"/>
         <variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </if>
   </template>
   <template mode="get_topStaff" match="musx:staffBracket|musx:barline" priority="-1">
      <sequence select="       (         for $staff in (ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff         return if (g:y($staff) &gt; g:y((ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff))           then ()           else $staff       )[1]"/>
   </template>
   <template mode="get_topStaff"
             match="musx:staffBracket[@topStaff]|musx:barline[@topStaff]">
      <sequence select="id(@topStaff)"/>
   </template>
   <template mode="get_bottomStaff" match="musx:staffBracket|musx:barline" priority="-1">
      <sequence select="       (         for $staff in (ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff         return if (g:y($staff) &lt; g:y((ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff))           then ()           else $staff       )[1]"/>
   </template>
   <template mode="get_bottomStaff"
             match="musx:staffBracket[@bottomStaff]|musx:barline[@bottomStaff]">
      <sequence select="id(@bottomStaff)"/>
   </template>
   <key name="get_y1_staffBracket_barline" use="substring(@y1,1,1)"
        match="musx:staffBracket|musx:barline"/>
   <template mode="get_y1" match="musx:staffBracket|musx:barline" priority="-2">
      <copy-of select="(g:y1(g:topStaff(.))) + (0)"/>
   </template>
   <template mode="get_y1" match="musx:staffBracket[@y1]|musx:barline[@y1]" priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1" match="key('get_y1_staffBracket_barline','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y1(g:topStaff(.))) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_staffBracket_barline','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_staffBracket_barline','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1(g:topStaff(.))) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_staffBracket_barline','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_staffBracket_barline','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_staffBracket_barline" use="substring(@y2,1,1)"
        match="musx:staffBracket|musx:barline"/>
   <template mode="get_y2" match="musx:staffBracket|musx:barline" priority="-2">
      <copy-of select="(g:y2(g:bottomStaff(.))) + (0)"/>
   </template>
   <template mode="get_y2" match="musx:staffBracket[@y2]|musx:barline[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staffBracket_barline','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y2(g:bottomStaff(.))) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staffBracket_barline','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staffBracket_barline','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2(g:bottomStaff(.))) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staffBracket_barline','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_staffBracket_barline','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <key name="get_y_staffBracket_barline_chord_stem_subbeam_slur"
        use="substring(@y,1,1)"
        match="musx:staffBracket|musx:barline|musx:chord|musx:stem|musx:subbeam|musx:slur"/>
   <template mode="get_y"
             match="musx:staffBracket|musx:barline|musx:chord|musx:stem|musx:subbeam|musx:slur"
             priority="-2">
      <copy-of select="(g:y1(.)) + (0)"/>
   </template>
   <template mode="get_y"
             match="musx:staffBracket[@y]|musx:barline[@y]|musx:chord[@y]|musx:stem[@y]|musx:subbeam[@y]|musx:slur[@y]"
             priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y"
             match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y1(.)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1(.)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y"
             match="key('get_y_staffBracket_barline_chord_stem_subbeam_slur','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <template mode="get_brackettip" match="musx:staffBracket" priority="-1">
      <value-of select="concat($libDirectory,'/',$symbolFile,'#','brackettip')"/>
   </template>
   <template mode="get_brackettip" match="musx:staffBracket[contains(@brackettip,'.')]"
             priority="2">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',@brackettip)"/>
   </template>
   <template mode="get_brackettip" match="musx:staffBracket[@brackettip]">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@brackettip)"/>
   </template>
   <template mode="get_OwnBoundingBox" match="musx:staffBracket" priority="-1">
      <variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:brackettip(.))" as="node()*"/>
      <if test="$symbolBBox">
         <variable name="size" select="g:size(.)"/>
         <variable name="x" select="g:x(.)"/>
         <variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </if>
   </template>
   <key name="get_lineOffset_barline" use="substring(@lineOffset,1,1)"
        match="musx:barline"/>
   <template mode="get_lineOffset" priority="-2" match="musx:barline">
      <copy-of select="(g:size(.)) * (1)"/>
   </template>
   <template mode="get_lineOffset" match="musx:barline[@lineOffset]" priority="-1">
      <copy-of select="number(@lineOffset)"/>
   </template>
   <template mode="get_lineOffset" match="key('get_lineOffset_barline','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@lineOffset,2))"/>
   </template>
   <template mode="get_lineOffset" match="key('get_lineOffset_barline','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@lineOffset,2))"/>
   </template>
   <key name="get_dotOffset_barline" use="substring(@dotOffset,1,1)"
        match="musx:barline"/>
   <template mode="get_dotOffset" priority="-2" match="musx:barline">
      <copy-of select="(g:size(.)) * (1.25)"/>
   </template>
   <template mode="get_dotOffset" match="musx:barline[@dotOffset]" priority="-1">
      <copy-of select="number(@dotOffset)"/>
   </template>
   <template mode="get_dotOffset" match="key('get_dotOffset_barline','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@dotOffset,2))"/>
   </template>
   <template mode="get_dotOffset" match="key('get_dotOffset_barline','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@dotOffset,2))"/>
   </template>
   <key name="get_dotRadius_barline" use="substring(@dotRadius,1,1)"
        match="musx:barline"/>
   <template mode="get_dotRadius" priority="-2" match="musx:barline">
      <copy-of select="(1) * (.4)"/>
   </template>
   <template mode="get_dotRadius" match="musx:barline[@dotRadius]" priority="-1">
      <copy-of select="number(@dotRadius)"/>
   </template>
   <template mode="get_dotRadius" match="key('get_dotRadius_barline','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@dotRadius,2))"/>
   </template>
   <template mode="get_dotRadius" match="key('get_dotRadius_barline','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@dotRadius,2))"/>
   </template>
   <key name="get_lineWidth_barline" use="substring(@lineWidth,1,1)"
        match="musx:barline"/>
   <template mode="get_lineWidth" priority="-2" match="musx:barline">
      <copy-of select="(g:size(.)) * (.25)"/>
   </template>
   <template mode="get_lineWidth" match="musx:barline[@lineWidth]" priority="-1">
      <copy-of select="number(@lineWidth)"/>
   </template>
   <template mode="get_lineWidth" match="key('get_lineWidth_barline','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@lineWidth,2))"/>
   </template>
   <template mode="get_lineWidth" match="key('get_lineWidth_barline','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@lineWidth,2))"/>
   </template>
   <key name="get_boldLineWidth_barline" use="substring(@boldLineWidth,1,1)"
        match="musx:barline"/>
   <template mode="get_boldLineWidth" priority="-2" match="musx:barline">
      <copy-of select="(g:size(.)) * (1)"/>
   </template>
   <template mode="get_boldLineWidth" match="musx:barline[@boldLineWidth]" priority="-1">
      <copy-of select="number(@boldLineWidth)"/>
   </template>
   <template mode="get_boldLineWidth" match="key('get_boldLineWidth_barline','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@boldLineWidth,2))"/>
   </template>
   <template mode="get_boldLineWidth" match="key('get_boldLineWidth_barline','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@boldLineWidth,2))"/>
   </template>
   <template mode="get_type" match="musx:barline" priority="-1">
      <copy-of select="'normal'"/>
   </template>
   <template mode="get_type" match="musx:barline[@type]">
      <copy-of select="@type cast as xs:string"/>
   </template>
   <template mode="get_function" match="musx:barline" priority="-1">
      <copy-of select="'normal'"/>
   </template>
   <template mode="get_function" match="musx:barline[@function]">
      <copy-of select="@function cast as xs:string"/>
   </template>
   <template mode="get_ledgerLines.direction" match="musx:note" priority="-1">
      <copy-of select="if (g:step(.) lt 0)                                                   then -1                                                   else 1"/>
   </template>
   <template mode="get_ledgerLines.direction" match="musx:note[@ledgerLines.direction]">
      <copy-of select="@ledgerLines.direction cast as xs:integer"/>
   </template>
   <key name="get_ledgerLines.y1_note" use="substring(@ledgerLines.y1,1,1)"
        match="musx:note"/>
   <template mode="get_ledgerLines.y1" match="musx:note" priority="-2">
      <copy-of select="(       for $staff in ancestor::musx:staff[last()] return         if (g:ledgerLines.direction(.) &lt; 0)         then g:y1($staff) - 2*g:size($staff)         else g:y2($staff) + 2*g:size($staff)) + (0)"/>
   </template>
   <template mode="get_ledgerLines.y1" match="musx:note[@ledgerLines.y1]" priority="-1">
      <copy-of select="number(@ledgerLines.y1)"/>
   </template>
   <template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(       for $staff in ancestor::musx:staff[last()] return         if (g:ledgerLines.direction(.) &lt; 0)         then g:y1($staff) - 2*g:size($staff)         else g:y2($staff) + 2*g:size($staff)) + g:size($page) * number(substring(@ledgerLines.y1,2))"/>
   </template>
   <template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@ledgerLines.y1,2))"/>
   </template>
   <template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(       for $staff in ancestor::musx:staff[last()] return         if (g:ledgerLines.direction(.) &lt; 0)         then g:y1($staff) - 2*g:size($staff)         else g:y2($staff) + 2*g:size($staff)) + (g:size($staff) * number(substring(@ledgerLines.y1,2)))"/>
   </template>
   <template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@ledgerLines.y1,2)))"/>
   </template>
   <template mode="get_ledgerLines.y1" match="key('get_ledgerLines.y1_note','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@ledgerLines.y1,2)) - 1)"/>
   </template>
   <key name="get_ledgerLines.y2_note" use="substring(@ledgerLines.y2,1,1)"
        match="musx:note"/>
   <template mode="get_ledgerLines.y2" match="musx:note" priority="-2">
      <copy-of select="(g:y(.)) + (0)"/>
   </template>
   <template mode="get_ledgerLines.y2" match="musx:note[@ledgerLines.y2]" priority="-1">
      <copy-of select="number(@ledgerLines.y2)"/>
   </template>
   <template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(.)) + g:size($page) * number(substring(@ledgerLines.y2,2))"/>
   </template>
   <template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@ledgerLines.y2,2))"/>
   </template>
   <template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(.)) + (g:size($staff) * number(substring(@ledgerLines.y2,2)))"/>
   </template>
   <template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@ledgerLines.y2,2)))"/>
   </template>
   <template mode="get_ledgerLines.y2" match="key('get_ledgerLines.y2_note','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@ledgerLines.y2,2)) - 1)"/>
   </template>
   <template mode="get_ledgerLines.draw" match="musx:note" priority="-1">
      <copy-of select="g:step(.) &lt; -1 or g:step(.) &gt; 9"/>
   </template>
   <template mode="get_ledgerLines.draw" match="musx:note[@ledgerLines.draw]">
      <copy-of select="if (@ledgerLines.draw = 'false')                            then false()                            else true()"/>
   </template>
   <key name="get_ledgerLines.protrusion_note"
        use="substring(@ledgerLines.protrusion,1,1)"
        match="musx:note"/>
   <template mode="get_ledgerLines.protrusion" priority="-2" match="musx:note">
      <copy-of select="(g:size(..)) * (.75)"/>
   </template>
   <template mode="get_ledgerLines.protrusion" match="musx:note[@ledgerLines.protrusion]"
             priority="-1">
      <copy-of select="number(@ledgerLines.protrusion)"/>
   </template>
   <template mode="get_ledgerLines.protrusion"
             match="key('get_ledgerLines.protrusion_note','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@ledgerLines.protrusion,2))"/>
   </template>
   <template mode="get_ledgerLines.protrusion"
             match="key('get_ledgerLines.protrusion_note','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@ledgerLines.protrusion,2))"/>
   </template>
   <template mode="get_direction" match="musx:note" priority="-1">
      <copy-of select="         if (musx:stem/@direction)         then g:direction(musx:stem[@direction][1])         else g:calculateDirection(.)"/>
   </template>
   <template mode="get_direction" match="musx:note[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <template mode="get_step" match="musx:note" priority="-1">
      <copy-of select="           if(substring(@y,1,1)='S')           then number(substring(@y,2))           else (g:y(.) - g:y(ancestor::musx:staff[last()])) div g:staffSize(.)"/>
   </template>
   <template mode="get_step" match="musx:note[@step]">
      <copy-of select="@step cast as xs:double"/>
   </template>
   <key name="get_x_head" use="substring(@x,1,1)" match="musx:head"/>
   <template mode="get_x" match="musx:head" priority="-2">
      <copy-of select="(g:x(g:start(.))) + (       if (g:flip(.) = 0)       then 0       else g:flip(.) * g:width(.))"/>
   </template>
   <template mode="get_x" match="musx:head[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_head','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_head','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_head','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <template mode="get_flip" match="musx:head" priority="-1">
      <copy-of select="       if(../parent::musx:chord)       then (         for $chordDirection in g:direction(../..),             $noteStep in g:step(..),             $collisionStep in $noteStep - $chordDirection,             $otherNote in ../../musx:note         return           if (g:step($otherNote) = $collisionStep)           then (g:flip($otherNote/musx:head) - $chordDirection) mod 2           else ()       )[1]       else 0"/>
   </template>
   <template mode="get_flip" match="musx:head[@flip]">
      <copy-of select="@flip cast as xs:integer"/>
   </template>
   <template mode="get_symbol" match="musx:head" priority="-1">
      <value-of select="concat($libDirectory,'/',$symbolFile,'#','notehead.quarter')"/>
   </template>
   <template mode="get_symbol" match="musx:head[contains(@symbol,'.')]" priority="2">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </template>
   <template mode="get_symbol" match="musx:head[@symbol]">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </template>
   <template mode="get_OwnBoundingBox" match="musx:head" priority="-1">
      <variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <if test="$symbolBBox">
         <variable name="size" select="g:size(.)"/>
         <variable name="x" select="g:x(.)"/>
         <variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </if>
   </template>
   <key name="get_x_accidental" use="substring(@x,1,1)" match="musx:accidental"/>
   <template mode="get_x" match="musx:accidental" priority="-2">
      <copy-of select="(g:x(..)) + (-3*g:size(.))"/>
   </template>
   <template mode="get_x" match="musx:accidental[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_accidental','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(..)) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_accidental','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_accidental','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <template mode="get_topNote" match="musx:chord" priority="-1">
      <sequence select="musx:note[g:step(.) = min(g:step(../musx:note))][1]"/>
   </template>
   <template mode="get_topNote" match="musx:chord[@topNote]">
      <sequence select="id(@topNote)"/>
   </template>
   <template mode="get_bottomNote" match="musx:chord" priority="-1">
      <sequence select="musx:note[g:step(.) = max(g:step(../musx:note))][1]"/>
   </template>
   <template mode="get_bottomNote" match="musx:chord[@bottomNote]">
      <sequence select="id(@bottomNote)"/>
   </template>
   <template mode="get_direction" match="musx:chord" priority="-1">
      <copy-of select="         if (musx:stem/@direction)         then g:direction(musx:stem[1])         else g:calculateDirection(.)"/>
   </template>
   <template mode="get_direction" match="musx:chord[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <key name="get_y1_chord" use="substring(@y1,1,1)" match="musx:chord"/>
   <template mode="get_y1" match="musx:chord" priority="-2">
      <copy-of select="(       if (g:direction(.) = -1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))       ) + (0)"/>
   </template>
   <template mode="get_y1" match="musx:chord[@y1]" priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1" match="key('get_y1_chord','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(       if (g:direction(.) = -1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))       ) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_chord','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_chord','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(       if (g:direction(.) = -1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))       ) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_chord','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_chord','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_chord" use="substring(@y2,1,1)" match="musx:chord"/>
   <template mode="get_y2" match="musx:chord" priority="-2">
      <copy-of select="(       if (g:direction(.) = 1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))      ) + (0)"/>
   </template>
   <template mode="get_y2" match="musx:chord[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_chord','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(       if (g:direction(.) = 1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))      ) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_chord','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_chord','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(       if (g:direction(.) = 1)       then g:y(g:bottomNote(.))       else g:y(g:topNote(.))      ) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_chord','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_chord','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <key name="get_x_stem" use="substring(@x,1,1)" match="musx:stem"/>
   <template mode="get_x" match="musx:stem" priority="-2">
      <copy-of select="(g:x(..)) + (         if (g:direction(.) = 1 or not(..//musx:head or parent::musx:rest))         then 0              (: the width of the first symbol found in this sequence gets returned                  if parent is a chord, g:topNote(..) will return something;                 if parent is a note, ../musx:head will return something,                 otherwise, this should be a rest :)         else g:width((g:topNote(..)/musx:head, ../musx:head, ..)[1]))"/>
   </template>
   <template mode="get_x" match="musx:stem[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_stem','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(..)) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_stem','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_stem','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_y1_stem" use="substring(@y1,1,1)" match="musx:stem"/>
   <template mode="get_y1" match="musx:stem" priority="-2">
      <copy-of select="(g:y1(..)) + (0)"/>
   </template>
   <template mode="get_y1" match="musx:stem[@y1]" priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1" match="key('get_y1_stem','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y1(..)) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_stem','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_stem','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1(..)) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_stem','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_stem','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_stem" use="substring(@y2,1,1)" match="musx:stem"/>
   <template mode="get_y2" match="musx:stem" priority="-2">
      <copy-of select="(           if (..//@beam)           then g:beamY(.)           else g:y2(..)) + (           if (..//@beam)           then 0           else g:direction(.) * g:length(.) * g:staffSize(.))"/>
   </template>
   <template mode="get_y2" match="musx:stem[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_stem','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(           if (..//@beam)           then g:beamY(.)           else g:y2(..)) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_stem','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_stem','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(           if (..//@beam)           then g:beamY(.)           else g:y2(..)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_stem','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_stem','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <template mode="get_direction" match="musx:stem" priority="-1">
      <copy-of select="         if (@beam)         then g:direction(g:beam(.))         else g:direction(..)"/>
   </template>
   <template mode="get_direction" match="musx:stem[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <template mode="get_beam" match="musx:stem" priority="-1">
      <sequence select="()"/>
   </template>
   <template mode="get_beam" match="musx:stem[@beam]">
      <sequence select="id(@beam)"/>
   </template>
   <template mode="get_length" match="musx:stem" priority="-1">
      <copy-of select="       max((         for $direction in g:direction(.),             $stemOutletStep in   (: QUESTION: Find a better name? '$stemOutletStep' is where the stem 'leaves' a chord :)                 if (not(parent::musx:chord))               then g:step(..)               else if ($direction = 1)               then g:step(g:bottomNote(..))               else g:step(g:topNote(..)),             $distanceFromCenter in g:direction(.) * (g:lines(ancestor::musx:staff[last()]) - 1 - $stemOutletStep)          return           if ($distanceFromCenter &gt; 7)             then $distanceFromCenter           else if ($distanceFromCenter &gt;= 0)             then 7           else if ($distanceFromCenter &gt; -5)             then .4 * $distanceFromCenter + 7           else 5         ,         if (musx:flags)  (: if there are flags, the stem must be at least as long as the flags symbol :)          then for $symbolBB in g:svgSymbolBoundingBox(g:symbol(musx:flags)) return              max((abs($symbolBB//@top),abs($symbolBB//@bottom)))               + (if (g:direction(.) = 1) then 1 else 0)              (: For downstemmed notes, we need to make the stem at least one step longer than the flag               because otherwise the flag runs into the head :)         else ()       ))"/>
   </template>
   <template mode="get_length" match="musx:stem[@length]">
      <copy-of select="@length cast as xs:double"/>
   </template>
   <key name="get_y_flags" use="substring(@y,1,1)" match="musx:flags"/>
   <template mode="get_y" match="musx:flags" priority="-2">
      <copy-of select="(g:y2(..)) + (0)"/>
   </template>
   <template mode="get_y" match="musx:flags[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_flags','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y2(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_flags','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_flags','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_flags','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_flags','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <template mode="get_direction" match="musx:flags|musx:dots|musx:subbeam" priority="-1">
      <copy-of select="g:direction(..)"/>
   </template>
   <template mode="get_direction"
             match="musx:flags[@direction]|musx:dots[@direction]|musx:subbeam[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <template mode="get_number" match="musx:flags|musx:dots|musx:beam|musx:subbeam"
             priority="-1">
      <copy-of select="1"/>
   </template>
   <template mode="get_number"
             match="musx:flags[@number]|musx:dots[@number]|musx:beam[@number]|musx:subbeam[@number]">
      <copy-of select="@number cast as xs:integer"/>
   </template>
   <template mode="get_symbol" match="musx:flags" priority="-1">
      <value-of select="concat($libDirectory,'/',$symbolFile,'#',concat('flags.',g:direction(.)*g:number(.)))"/>
   </template>
   <template mode="get_symbol" match="musx:flags[contains(@symbol,'.')]" priority="2">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',@symbol)"/>
   </template>
   <template mode="get_symbol" match="musx:flags[@symbol]">
      <sequence select="concat($libDirectory,'/',$symbolFile,'#',local-name(),'.',@symbol)"/>
   </template>
   <template mode="get_OwnBoundingBox" match="musx:flags" priority="-1">
      <variable name="symbolBBox" select="g:svgSymbolBoundingBox(g:symbol(.))" as="node()*"/>
      <if test="$symbolBBox">
         <variable name="size" select="g:size(.)"/>
         <variable name="x" select="g:x(.)"/>
         <variable name="y" select="g:y(.)"/>
         <musx:BoundingBox left="{  $x + $size*number($symbolBBox/@left)}"
                           right="{ $x + $size*number($symbolBBox/@right)}"
                           top="{   $y + $size*number($symbolBBox/@top)}"
                           bottom="{$y + $size*number($symbolBBox/@bottom)}"/>
      </if>
   </template>
   <key name="get_y_dots" use="substring(@y,1,1)" match="musx:dots"/>
   <template mode="get_y" match="musx:dots" priority="-2">
      <copy-of select="(g:y(..)) + (         if (g:step(..) mod 2 = 0)         then -g:staffSize(.)         else 0)"/>
   </template>
   <template mode="get_y" match="musx:dots[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_dots','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_dots','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_dots','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_dots','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_dots','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_x1_dots" use="substring(@x1,1,1)" match="musx:dots"/>
   <template mode="get_x1" match="musx:dots" priority="-2">
      <copy-of select="(g:x(..)) + (g:width((../musx:head, ..)[1]) + g:offset(.))"/>
   </template>
   <template mode="get_x1" match="musx:dots[@x1]" priority="-1">
      <copy-of select="number(@x1)"/>
   </template>
   <template mode="get_x1" match="key('get_x1_dots','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(..)) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_dots','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_dots','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(..)) + (g:size($staff) * number(substring(@x1,2)))"/>
   </template>
   <key name="get_x2_dots" use="substring(@x2,1,1)" match="musx:dots"/>
   <template mode="get_x2" match="musx:dots" priority="-2">
      <copy-of select="(g:x1(.)) + ((g:number(.) - 1) * g:distance(.))"/>
   </template>
   <template mode="get_x2" match="musx:dots[@x2]" priority="-1">
      <copy-of select="number(@x2)"/>
   </template>
   <template mode="get_x2" match="key('get_x2_dots','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x1(.)) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2" match="key('get_x2_dots','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2" match="key('get_x2_dots','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x1(.)) + (g:size($staff) * number(substring(@x2,2)))"/>
   </template>
   <key name="get_offset_dots" use="substring(@offset,1,1)" match="musx:dots"/>
   <template mode="get_offset" priority="-2" match="musx:dots">
      <copy-of select="(g:size(.)) * (1)"/>
   </template>
   <template mode="get_offset" match="musx:dots[@offset]" priority="-1">
      <copy-of select="number(@offset)"/>
   </template>
   <template mode="get_offset" match="key('get_offset_dots','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@offset,2))"/>
   </template>
   <template mode="get_offset" match="key('get_offset_dots','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@offset,2))"/>
   </template>
   <key name="get_distance_dots" use="substring(@distance,1,1)" match="musx:dots"/>
   <template mode="get_distance" priority="-2" match="musx:dots">
      <copy-of select="(g:size(.)) * (1.2)"/>
   </template>
   <template mode="get_distance" match="musx:dots[@distance]" priority="-1">
      <copy-of select="number(@distance)"/>
   </template>
   <template mode="get_distance" match="key('get_distance_dots','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </template>
   <template mode="get_distance" match="key('get_distance_dots','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </template>
   <key name="get_radius_dots" use="substring(@radius,1,1)" match="musx:dots"/>
   <template mode="get_radius" priority="-2" match="musx:dots">
      <copy-of select="(g:size(..)) * (.25)"/>
   </template>
   <template mode="get_radius" match="musx:dots[@radius]" priority="-1">
      <copy-of select="number(@radius)"/>
   </template>
   <template mode="get_radius" match="key('get_radius_dots','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@radius,2))"/>
   </template>
   <template mode="get_radius" match="key('get_radius_dots','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@radius,2))"/>
   </template>
   <key name="get_x1_beam_subbeam" use="substring(@x1,1,1)"
        match="musx:beam|musx:subbeam"/>
   <template mode="get_x1" match="musx:beam|musx:subbeam" priority="-2">
      <copy-of select="(g:x((g:start(.)//musx:stem, g:start(.))[1])) + (0)"/>
   </template>
   <template mode="get_x1" match="musx:beam[@x1]|musx:subbeam[@x1]" priority="-1">
      <copy-of select="number(@x1)"/>
   </template>
   <template mode="get_x1" match="key('get_x1_beam_subbeam','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x((g:start(.)//musx:stem, g:start(.))[1])) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_beam_subbeam','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_beam_subbeam','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x((g:start(.)//musx:stem, g:start(.))[1])) + (g:size($staff) * number(substring(@x1,2)))"/>
   </template>
   <key name="get_x2_beam_subbeam" use="substring(@x2,1,1)"
        match="musx:beam|musx:subbeam"/>
   <template mode="get_x2" match="musx:beam|musx:subbeam" priority="-2">
      <copy-of select="(g:x((g:end(.)//musx:stem, g:end(.))[1])) + (0)"/>
   </template>
   <template mode="get_x2" match="musx:beam[@x2]|musx:subbeam[@x2]" priority="-1">
      <copy-of select="number(@x2)"/>
   </template>
   <template mode="get_x2" match="key('get_x2_beam_subbeam','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x((g:end(.)//musx:stem, g:end(.))[1])) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2" match="key('get_x2_beam_subbeam','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2" match="key('get_x2_beam_subbeam','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x((g:end(.)//musx:stem, g:end(.))[1])) + (g:size($staff) * number(substring(@x2,2)))"/>
   </template>
   <key name="get_y_beam" use="substring(@y,1,1)" match="musx:beam"/>
   <template mode="get_y" match="musx:beam" priority="-2">
      <copy-of select="(g:y(..)) + (g:beamYLacuna(.))"/>
   </template>
   <template mode="get_y" match="musx:beam[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_beam','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_beam','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_beam','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_beam','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_beam','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_width_beam" use="substring(@width,1,1)" match="musx:beam"/>
   <template mode="get_width" priority="-2" match="musx:beam">
      <copy-of select="(g:size(.)) * (1)"/>
   </template>
   <template mode="get_width" match="musx:beam[@width]" priority="-1">
      <copy-of select="number(@width)"/>
   </template>
   <template mode="get_width" match="key('get_width_beam','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@width,2))"/>
   </template>
   <template mode="get_width" match="key('get_width_beam','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </template>
   <key name="get_distance_beam" use="substring(@distance,1,1)" match="musx:beam"/>
   <template mode="get_distance" priority="-2" match="musx:beam">
      <copy-of select="(g:size(.)) * (1.5)"/>
   </template>
   <template mode="get_distance" match="musx:beam[@distance]" priority="-1">
      <copy-of select="number(@distance)"/>
   </template>
   <template mode="get_distance" match="key('get_distance_beam','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </template>
   <template mode="get_distance" match="key('get_distance_beam','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </template>
   <template mode="get_direction" match="musx:beam" priority="-1">
      <copy-of select="g:calculateDirection(.)"/>
   </template>
   <template mode="get_direction" match="musx:beam[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <key name="get_y1_subbeam" use="substring(@y1,1,1)" match="musx:subbeam"/>
   <template mode="get_y1" match="musx:subbeam" priority="-2">
      <copy-of select="(g:y1(..)) + (- g:distance(..) * g:direction(..) * g:number(..))"/>
   </template>
   <template mode="get_y1" match="musx:subbeam[@y1]" priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1" match="key('get_y1_subbeam','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y1(..)) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_subbeam','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_subbeam','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1(..)) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_subbeam','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_subbeam','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_subbeam" use="substring(@y2,1,1)" match="musx:subbeam"/>
   <template mode="get_y2" match="musx:subbeam" priority="-2">
      <copy-of select="(g:y2(..)) + (- g:distance(..) * g:direction(..) * g:number(..))"/>
   </template>
   <template mode="get_y2" match="musx:subbeam[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_subbeam','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y2(..)) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_subbeam','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_subbeam','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2(..)) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_subbeam','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_subbeam','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <key name="get_width_subbeam" use="substring(@width,1,1)" match="musx:subbeam"/>
   <template mode="get_width" priority="-2" match="musx:subbeam">
      <copy-of select="(g:width(..)) * (1)"/>
   </template>
   <template mode="get_width" match="musx:subbeam[@width]" priority="-1">
      <copy-of select="number(@width)"/>
   </template>
   <template mode="get_width" match="key('get_width_subbeam','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@width,2))"/>
   </template>
   <template mode="get_width" match="key('get_width_subbeam','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </template>
   <key name="get_distance_subbeam" use="substring(@distance,1,1)" match="musx:subbeam"/>
   <template mode="get_distance" priority="-2" match="musx:subbeam">
      <copy-of select="(g:distance(..)) * (1)"/>
   </template>
   <template mode="get_distance" match="musx:subbeam[@distance]" priority="-1">
      <copy-of select="number(@distance)"/>
   </template>
   <template mode="get_distance" match="key('get_distance_subbeam','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </template>
   <template mode="get_distance" match="key('get_distance_subbeam','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </template>
   <key name="get_startSpread_hairpin" use="substring(@startSpread,1,1)"
        match="musx:hairpin"/>
   <template mode="get_startSpread" priority="-2" match="musx:hairpin">
      <copy-of select="(g:size(..)) * (0)"/>
   </template>
   <template mode="get_startSpread" match="musx:hairpin[@startSpread]" priority="-1">
      <copy-of select="number(@startSpread)"/>
   </template>
   <template mode="get_startSpread" match="key('get_startSpread_hairpin','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@startSpread,2))"/>
   </template>
   <template mode="get_startSpread" match="key('get_startSpread_hairpin','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@startSpread,2))"/>
   </template>
   <key name="get_endSpread_hairpin" use="substring(@endSpread,1,1)"
        match="musx:hairpin"/>
   <template mode="get_endSpread" priority="-2" match="musx:hairpin">
      <copy-of select="(g:size(..)) * (0)"/>
   </template>
   <template mode="get_endSpread" match="musx:hairpin[@endSpread]" priority="-1">
      <copy-of select="number(@endSpread)"/>
   </template>
   <template mode="get_endSpread" match="key('get_endSpread_hairpin','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@endSpread,2))"/>
   </template>
   <template mode="get_endSpread" match="key('get_endSpread_hairpin','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@endSpread,2))"/>
   </template>
   <key name="get_y1_slur" use="substring(@y1,1,1)" match="musx:slur"/>
   <template mode="get_y1" match="musx:slur" priority="-2">
      <copy-of select="(         if(g:start(.)/self::musx:note)         then (g:y(g:start(.)))         else g:y((g:slurNotes(.),..)[1])) + (0)"/>
   </template>
   <template mode="get_y1" match="musx:slur[@y1]" priority="-1">
      <copy-of select="number(@y1)"/>
   </template>
   <template mode="get_y1" match="key('get_y1_slur','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(         if(g:start(.)/self::musx:note)         then (g:y(g:start(.)))         else g:y((g:slurNotes(.),..)[1])) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_slur','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y1,2))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_slur','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(         if(g:start(.)/self::musx:note)         then (g:y(g:start(.)))         else g:y((g:slurNotes(.),..)[1])) + (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_slur','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y1,2)))"/>
   </template>
   <template mode="get_y1" match="key('get_y1_slur','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y1,2)) - 1)"/>
   </template>
   <key name="get_y2_slur" use="substring(@y2,1,1)" match="musx:slur"/>
   <template mode="get_y2" match="musx:slur" priority="-2">
      <copy-of select="(         if(g:end(.)/self::musx:note)         then g:y(g:end(.))         else g:y((..,g:slurNotes)[last()])) + (0)"/>
   </template>
   <template mode="get_y2" match="musx:slur[@y2]" priority="-1">
      <copy-of select="number(@y2)"/>
   </template>
   <template mode="get_y2" match="key('get_y2_slur','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(         if(g:end(.)/self::musx:note)         then g:y(g:end(.))         else g:y((..,g:slurNotes)[last()])) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_slur','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y2,2))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_slur','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(         if(g:end(.)/self::musx:note)         then g:y(g:end(.))         else g:y((..,g:slurNotes)[last()])) + (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_slur','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y2,2)))"/>
   </template>
   <template mode="get_y2" match="key('get_y2_slur','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y2,2)) - 1)"/>
   </template>
   <key name="get_height_slur" use="substring(@height,1,1)" match="musx:slur"/>
   <template mode="get_height" priority="-2" match="musx:slur">
      <copy-of select="(g:size(.)) * (1)"/>
   </template>
   <template mode="get_height" match="musx:slur[@height]" priority="-1">
      <copy-of select="number(@height)"/>
   </template>
   <template mode="get_height" match="key('get_height_slur','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@height,2))"/>
   </template>
   <template mode="get_height" match="key('get_height_slur','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@height,2))"/>
   </template>
   <key name="get_centerThickness_slur" use="substring(@centerThickness,1,1)"
        match="musx:slur"/>
   <template mode="get_centerThickness" priority="-2" match="musx:slur">
      <copy-of select="(g:size(.)) * (.5)"/>
   </template>
   <template mode="get_centerThickness" match="musx:slur[@centerThickness]" priority="-1">
      <copy-of select="number(@centerThickness)"/>
   </template>
   <template mode="get_centerThickness" match="key('get_centerThickness_slur','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@centerThickness,2))"/>
   </template>
   <template mode="get_centerThickness" match="key('get_centerThickness_slur','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@centerThickness,2))"/>
   </template>
   <key name="get_tipThickness_slur" use="substring(@tipThickness,1,1)"
        match="musx:slur"/>
   <template mode="get_tipThickness" priority="-2" match="musx:slur">
      <copy-of select="(g:centerThickness(.)) * (.618)"/>
   </template>
   <template mode="get_tipThickness" match="musx:slur[@tipThickness]" priority="-1">
      <copy-of select="number(@tipThickness)"/>
   </template>
   <template mode="get_tipThickness" match="key('get_tipThickness_slur','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@tipThickness,2))"/>
   </template>
   <template mode="get_tipThickness" match="key('get_tipThickness_slur','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@tipThickness,2))"/>
   </template>
   <template mode="get_swellingRate" match="musx:slur" priority="-1">
      <copy-of select=".618"/>
   </template>
   <template mode="get_swellingRate" match="musx:slur[@swellingRate]">
      <copy-of select="@swellingRate cast as xs:double"/>
   </template>
   <template mode="get_swellingRate1" match="musx:slur" priority="-1">
      <copy-of select="g:swellingRate(.)"/>
   </template>
   <template mode="get_swellingRate1" match="musx:slur[@swellingRate1]">
      <copy-of select="@swellingRate1 cast as xs:double"/>
   </template>
   <template mode="get_swellingRate2" match="musx:slur" priority="-1">
      <copy-of select="g:swellingRate(.)"/>
   </template>
   <template mode="get_swellingRate2" match="musx:slur[@swellingRate2]">
      <copy-of select="@swellingRate2 cast as xs:double"/>
   </template>
   <template mode="get_tilt" match="musx:slur" priority="-1">
      <copy-of select="1"/>
   </template>
   <template mode="get_tilt" match="musx:slur[@tilt]">
      <copy-of select="@tilt cast as xs:double"/>
   </template>
   <template mode="get_shift" match="musx:slur" priority="-1">
      <copy-of select="0"/>
   </template>
   <template mode="get_shift" match="musx:slur[@shift]">
      <copy-of select="@shift cast as xs:double"/>
   </template>
   <template mode="get_shoulder" match="musx:slur" priority="-1">
      <copy-of select=".618"/>
   </template>
   <template mode="get_shoulder" match="musx:slur[@shoulder]">
      <copy-of select="@shoulder cast as xs:double"/>
   </template>
   <template mode="get_curvature" match="musx:slur" priority="-1">
      <copy-of select=".5"/>
   </template>
   <template mode="get_curvature" match="musx:slur[@curvature]">
      <copy-of select="@curvature cast as xs:double"/>
   </template>
   <template mode="get_curvature1" match="musx:slur" priority="-1">
      <copy-of select="g:curvature(.)"/>
   </template>
   <template mode="get_curvature1" match="musx:slur[@curvature1]">
      <copy-of select="@curvature1 cast as xs:double"/>
   </template>
   <template mode="get_curvature2" match="musx:slur" priority="-1">
      <copy-of select="g:curvature(.)"/>
   </template>
   <template mode="get_curvature2" match="musx:slur[@curvature2]">
      <copy-of select="@curvature2 cast as xs:double"/>
   </template>
   <template mode="get_tipAngle" match="musx:slur" priority="-1">
      <copy-of select=".618"/>
   </template>
   <template mode="get_tipAngle" match="musx:slur[@tipAngle]">
      <copy-of select="@tipAngle cast as xs:double"/>
   </template>
   <template mode="get_tipAngle1" match="musx:slur" priority="-1">
      <copy-of select="g:tipAngle(.)"/>
   </template>
   <template mode="get_tipAngle1" match="musx:slur[@tipAngle1]">
      <copy-of select="@tipAngle1 cast as xs:double"/>
   </template>
   <template mode="get_tipAngle2" match="musx:slur" priority="-1">
      <copy-of select="g:tipAngle(.)"/>
   </template>
   <template mode="get_tipAngle2" match="musx:slur[@tipAngle2]">
      <copy-of select="@tipAngle2 cast as xs:double"/>
   </template>
   <template mode="get_direction" match="musx:slur" priority="-1">
      <copy-of select="g:slurDirection(.)"/>
   </template>
   <template mode="get_direction" match="musx:slur[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <key name="get_x_symbolText" use="substring(@x,1,1)" match="musx:symbolText"/>
   <template mode="get_x" match="musx:symbolText" priority="-2">
      <copy-of select="(g:x(g:start(.))) + (if (parent::musx:fraction)                                                          then .5*(g:width(..) - g:width(.))                                                          else 0)"/>
   </template>
   <template mode="get_x" match="musx:symbolText[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_symbolText','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_symbolText','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_symbolText','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <key name="get_y_symbolText" use="substring(@y,1,1)" match="musx:symbolText"/>
   <template mode="get_y" match="musx:symbolText" priority="-2">
      <copy-of select="(g:y(..)) + (if (parent::musx:fraction)                                                  then (4*count(preceding-sibling::musx:symbolText)-2)*g:staffSize(.)                                                  else 0)"/>
   </template>
   <template mode="get_y" match="musx:symbolText[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_symbolText','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_symbolText','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_symbolText','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_symbolText','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_symbolText','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_x1_symbolText" use="substring(@x1,1,1)" match="musx:symbolText"/>
   <template mode="get_x1" match="musx:symbolText" priority="-2">
      <copy-of select="(g:x(.)) + (0 - g:width(.) * g:textAnchor(.))"/>
   </template>
   <template mode="get_x1" match="musx:symbolText[@x1]" priority="-1">
      <copy-of select="number(@x1)"/>
   </template>
   <template mode="get_x1" match="key('get_x1_symbolText','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(.)) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_symbolText','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x1,2))"/>
   </template>
   <template mode="get_x1" match="key('get_x1_symbolText','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x1,2)))"/>
   </template>
   <key name="get_x2_symbolText" use="substring(@x2,1,1)" match="musx:symbolText"/>
   <template mode="get_x2" match="musx:symbolText" priority="-2">
      <copy-of select="(g:x(.)) + ((1 - g:textAnchor(.)) * g:width(.))"/>
   </template>
   <template mode="get_x2" match="musx:symbolText[@x2]" priority="-1">
      <copy-of select="number(@x2)"/>
   </template>
   <template mode="get_x2" match="key('get_x2_symbolText','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(.)) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2" match="key('get_x2_symbolText','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x2,2))"/>
   </template>
   <template mode="get_x2" match="key('get_x2_symbolText','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(.)) + (g:size($staff) * number(substring(@x2,2)))"/>
   </template>
   <template mode="get_textAnchor" match="musx:symbolText" priority="-1">
      <copy-of select="0"/>
   </template>
   <template mode="get_textAnchor" match="musx:symbolText[@textAnchor]">
      <copy-of select="@textAnchor cast as xs:double"/>
   </template>
   <key name="get_width_symbolText" use="substring(@width,1,1)" match="musx:symbolText"/>
   <template mode="get_width" priority="-2" match="musx:symbolText">
      <copy-of select="(g:size(.)) * (sum(def:getGlyphWidth(text())))"/>
   </template>
   <template mode="get_width" match="musx:symbolText[@width]" priority="-1">
      <copy-of select="number(@width)"/>
   </template>
   <template mode="get_width" match="key('get_width_symbolText','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@width,2))"/>
   </template>
   <template mode="get_width" match="key('get_width_symbolText','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </template>
   <template mode="get_pattern" match="musx:keySignature" priority="-1">
      <copy-of select="''''"/>
   </template>
   <template mode="get_pattern" match="musx:keySignature[@pattern]">
      <copy-of select="@pattern cast as xs:string"/>
   </template>
   <key name="get_distance_keySignature" use="substring(@distance,1,1)"
        match="musx:keySignature"/>
   <template mode="get_distance" priority="-2" match="musx:keySignature">
      <copy-of select="(g:size(.)) * (2)"/>
   </template>
   <template mode="get_distance" match="musx:keySignature[@distance]" priority="-1">
      <copy-of select="number(@distance)"/>
   </template>
   <template mode="get_distance" match="key('get_distance_keySignature','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@distance,2))"/>
   </template>
   <template mode="get_distance" match="key('get_distance_keySignature','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@distance,2))"/>
   </template>
   <key name="get_y_timeSignature" use="substring(@y,1,1)" match="musx:timeSignature"/>
   <template mode="get_y" match="musx:timeSignature" priority="-2">
      <copy-of select="(g:y(..)) + (6*g:staffSize(.))"/>
   </template>
   <template mode="get_y" match="musx:timeSignature[@y]" priority="-1">
      <copy-of select="number(@y)"/>
   </template>
   <template mode="get_y" match="key('get_y_timeSignature','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:y(..)) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_timeSignature','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:y($page) + g:size($page) * number(substring(@y,2))"/>
   </template>
   <template mode="get_y" match="key('get_y_timeSignature','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y(..)) + (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_timeSignature','S')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y1($staff)) +            (g:size($staff) * number(substring(@y,2)))"/>
   </template>
   <template mode="get_y" match="key('get_y_timeSignature','L')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:y2($staff)) -            + 2 * g:size($staff) * (number(substring(@y,2)) - 1)"/>
   </template>
   <key name="get_width_fraction" use="substring(@width,1,1)" match="musx:fraction"/>
   <template mode="get_width" priority="-2" match="musx:fraction">
      <copy-of select="(max((g:width(*),0))) * (1)"/>
   </template>
   <template mode="get_width" match="musx:fraction[@width]" priority="-1">
      <copy-of select="number(@width)"/>
   </template>
   <template mode="get_width" match="key('get_width_fraction','p')">
      <variable name="page" select="ancestor::musx:page" as="node()"/>
      <copy-of select="g:size($page) * number(substring(@width,2))"/>
   </template>
   <template mode="get_width" match="key('get_width_fraction','s')">
      <variable name="staff" select="ancestor::musx:staff" as="node()"/>
      <copy-of select="g:size($staff) * number(substring(@width,2))"/>
   </template>
   <key name="get_x_articulation" use="substring(@x,1,1)" match="musx:articulation"/>
   <template mode="get_x" match="musx:articulation" priority="-2">
      <copy-of select="(g:x(g:start(.))) + (.5*g:width(ancestor::musx:note[1]/musx:head[1]))"/>
   </template>
   <template mode="get_x" match="musx:articulation[@x]" priority="-1">
      <copy-of select="number(@x)"/>
   </template>
   <template mode="get_x" match="key('get_x_articulation','p')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_articulation','P')">
      <variable name="page" select="ancestor-or-self::musx:page" as="node()"/>
      <copy-of select="g:x($page) + g:size($page) * number(substring(@x,2))"/>
   </template>
   <template mode="get_x" match="key('get_x_articulation','s')">
      <variable name="staff" select="ancestor::musx:staff[last()]" as="node()"/>
      <copy-of select="(g:x(g:start(.))) + (g:size($staff) * number(substring(@x,2)))"/>
   </template>
   <template mode="get_direction" match="musx:articulation" priority="-1">
      <copy-of select="-1*g:direction(ancestor::musx:note[1])"/>
   </template>
   <template mode="get_direction" match="musx:articulation[@direction]">
      <copy-of select="@direction cast as xs:integer"/>
   </template>
   <template match="musx:page" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('page ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:rect xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" stroke="black"
                   fill="#fffffc"
                   x="{g:x1(.)}"
                   width="{g:x2(.) - g:x1(.)}"
                   y="{g:y1(.)}"
                   height="{g:y2(.) - g:y1(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:system" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('system ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="addStaffLines">
      <xsl:param name="yPosition" select="g:y1(.)"/>
    
                                   <!--   + g:size(.) to avoid missing staff lines due to roundoff errors -->
    <xsl:if test="$yPosition &lt; g:y2(.) + g:size(.)">
         <svg:line x1="{g:x1(.)}" x2="{g:x2(.)}" y1="{$yPosition}" y2="{$yPosition}"/>
         <xsl:call-template name="addStaffLines">
            <xsl:with-param name="yPosition" select="$yPosition + 2 * g:size(.)"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>
   <template match="musx:staff" mode="get_OwnBoundingBox" priority="1">
      <BoundingBox xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" left="{g:x1(.)}"
                   right="{g:x2(.)}"
                   top="{g:y1(.)}"
                   bottom="{g:y2(.)}"/>
   </template>
   <template match="musx:staff" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('staff ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:g xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" class="stafflines"
                stroke="currentColor">
            <xsl:call-template name="addStaffLines"/>
         </svg:g>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:staffGroup" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('staffGroup ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="svg:*"
                 mode="draw">
      <xsl:copy-of select="."/>
  </xsl:template>
   <template match="musx:svg" mode="draw">
      <svg:g transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})">
         <attribute name="class">
            <value-of select="normalize-space(concat('svg ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:clef" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('clef ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:transposeNumber" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('transposeNumber ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:text xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                   transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                   font-size="1">
            <xsl:copy-of select="node()"/>
         </svg:text>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:rest" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('rest ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:group" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('group ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:staffBracket" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('staffBracket ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:line xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                   x1="{g:x(.) - 1.5 * g:size(.)}"
                   x2="{g:x(.) - 1.5 * g:size(.)}"
                   y1="{g:y1(.) - 1.4 * g:size(.)}"
                   y2="{g:y2(.) + 1.4 * g:size(.)}"
                   stroke-width="{1.2 * g:size(.)}"
                   fill="none"
                   stroke="currentColor"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  xlink:href="{g:brackettip(.)}"
                  transform="translate({g:x(.) - g:size(.)},{g:y2(.) + g:size(.)}) scale({g:size(.)},{- g:size(.)})"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  xlink:href="{g:brackettip(.)}"
                  transform="translate({g:x(.) - g:size(.)},{g:y1(.) - g:size(.)}) scale({g:size(.)})"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="drawThinBarline">
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
   <template match="musx:barline" mode="get_OwnBoundingBox" priority="1">
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="staffs"
                    select="(ancestor::musx:staff|ancestor::musx:staffGroup|ancestor::musx:system)[last()]/descendant-or-self::musx:staff"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    name="maxDotRadius"
                    select="max(g:size($staffs))*g:dotRadius(.)"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    name="distanceFromBoldLineToFarSideOfDots"
                    select="g:lineOffset(.) - g:lineWidth(.) + g:dotOffset(.) + $maxDotRadius"/>
      <xsl:choose xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
   </template>
   <template match="musx:barline" mode="draw">
      <svg:g stroke="currentColor">
         <attribute name="class">
            <value-of select="normalize-space(concat('barline ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:choose xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="addLedgerLines">
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
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="g:calculateDirection"
                 as="xs:integer">
      <xsl:param name="element" as="node()*"/>
      <xsl:variable name="notes"
                    select="$element/(self::musx:note, self::musx:chord/musx:note, key('beamNotes',@xml:id))"/>
      <xsl:variable name="sortedSteps" as="xs:double*">
         <xsl:for-each select="g:step($notes)">
            <xsl:sort select="."/>
            <xsl:sequence select="."/>
         </xsl:for-each>
      </xsl:variable>
      <xsl:variable name="staffCenter" select="g:lines($notes[1]/ancestor::musx:staff[last()]) - 1"
                    as="xs:integer"/>
      <!-- If there are no $notes, expression in if(..) will be false and 1 will be returned -->
    <xsl:sequence select="         if (.5*($sortedSteps[last()] + $sortedSteps[1]) &gt; $staffCenter)         then -1         else 1"/>
  </xsl:function>
   <template match="musx:note" mode="get_OwnBoundingBox" priority="1">
      <xsl:if xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              test="g:ledgerLines.draw(.)">
         <xsl:variable name="headBoundingBox" select="g:OwnBoundingBox(musx:head)"/>
         <xsl:variable name="protrusion" select="g:ledgerLines.protrusion(.)"/>
         <xsl:variable name="y1" select="g:ledgerLines.y1(.)"/>
         <xsl:variable name="headY" select="g:y(musx:head)"/>
         <BoundingBox left="{number($headBoundingBox//@left) - $protrusion}"
                      right="{number($headBoundingBox//@right) + $protrusion}"
                      top="{min(($headY,$y1))}"
                      bottom="{max(($headY,$y1))}"/>
      </xsl:if>
   </template>
   <template match="musx:note" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('note ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:g xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                class="ledgerlines"
                stroke="currentColor">
            <xsl:call-template name="addLedgerLines"/>
         </svg:g>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:head" mode="draw">
      <svg:g fill="currentColor">
         <attribute name="class">
            <value-of select="normalize-space(concat('head ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:accidental" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('accidental ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:chord" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('chord ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:stem" mode="get_OwnBoundingBox" priority="1">
      <BoundingBox xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" left="{g:x(.)}"
                   right="{g:x(.)}"
                   top="{min((g:y1(.),g:y2(.)))}"
                   bottom="{max((g:y1(.),g:y2(.)))}"/>
   </template>
   <template match="musx:stem" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('stem ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:line xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" x1="{g:x1(.)}"
                   x2="{g:x2(.)}"
                   y1="{g:y1(.)}"
                   y2="{g:y2(.)}"
                   stroke="currentColor"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:flags" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('flags ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="addDots">
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
   <template match="musx:dots" mode="get_OwnBoundingBox" priority="1">
      <BoundingBox xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                   left="{g:x1(.) - g:radius(.)}"
                   right="{g:x2(.) + g:radius(.)}"
                   top=" {g:y(.)  - g:radius(.)}"
                   bottom="{g:y(.) + g:radius(.)}"/>
   </template>
   <template match="musx:dots" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('dots ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:call-template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="addDots"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:BoundingBox" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('BoundingBox ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:polygon xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" class="bbox"
                      points="{@left},{@top} {@left},{@bottom} {@right},{@bottom} {@right},{@top}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:key xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="beamNotes"
            match="musx:note"
            use="ancestor-or-self::*/musx:stem/@beam"/>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="g:beamYLacuna">
      <xsl:param name="beam" as="node()"/>
      <xsl:variable name="direction" select="g:direction($beam)" as="xs:double"/>
      <xsl:variable name="steps"
                    select="g:step(key('beamNotes',$beam/@xml:id,$beam/ancestor::musx:musx))"
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
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="g:summedBeamNumber">
      <xsl:param name="beam" as="node()*"/>
      <xsl:for-each select="$beam">
         <xsl:sequence select="max((g:summedBeamNumber(musx:subbeam), 0)) + g:number(.)"/>
      </xsl:for-each>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="g:beamY">
      <xsl:param name="stem" as="node()"/>
      <xsl:variable name="beam" select="g:beam($stem)"/>
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
      <xsl:choose>
         <xsl:when test="$dx = 0">
            <xsl:sequence select="g:y1($beam)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="m" select="(g:y2($beam) - g:y1($beam)) div $dx"/>
            <xsl:sequence select="$m * (g:x($stem) - g:x1($beam)) + g:y1($beam) - .5*g:direction($beam)*g:width($beam)"/>
                                                                       <!-- - .5*g:direction($beam)*g:width($beam) makes sure
                                                                            that stem doesn't protrude over beam -->
      </xsl:otherwise>
      </xsl:choose>
  </xsl:function>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="drawBeam">
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
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="beamBoundingBox">
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
   <template match="musx:beam" mode="get_OwnBoundingBox" priority="1">
      <xsl:call-template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                         name="beamBoundingBox"/>
   </template>
   <template match="musx:subbeam" mode="get_OwnBoundingBox" priority="1">
      <xsl:call-template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                         name="beamBoundingBox"/>
   </template>
   <template match="musx:beam" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('beam ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:call-template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="drawBeam"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:subbeam" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('subbeam ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:call-template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="drawBeam"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:hairpin" mode="get_OwnBoundingBox" priority="1">
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="y1"
                    select="g:y1(.)"
                    as="xs:double"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="y2"
                    select="g:y2(.)"
                    as="xs:double"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    name="halfStartSpread"
                    select="g:startSpread(.) div 2"
                    as="xs:double"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    name="halfEndSpread"
                    select="g:endSpread(.) div 2"
                    as="xs:double"/>
      <BoundingBox xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" left="{g:x1(.)}"
                   right="{g:x2(.)}"
                   top="{   min(($y1 - $halfStartSpread,$y2 - $halfEndSpread))}"
                   bottom="{max(($y1 + $halfStartSpread,$y2 + $halfEndSpread))}"/>
   </template>
   <template match="musx:hairpin" mode="draw">
      <svg:g fill="none" stroke="currentColor">
         <attribute name="class">
            <value-of select="normalize-space(concat('hairpin ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="x1"
                       select="g:x1(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="x2"
                       select="g:x2(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="y1"
                       select="g:y1(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="y2"
                       select="g:y2(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                       name="halfStartSpread"
                       select="g:startSpread(.) div 2"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                       name="halfEndSpread"
                       select="g:endSpread(.) div 2"
                       as="xs:double"/>
         <svg:line xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" x1="{$x1}"
                   y1="{$y1 + $halfStartSpread}"
                   x2="{$x2}"
                   y2="{$y2 + $halfEndSpread}"/>
         <svg:line xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" x1="{$x1}"
                   y1="{$y1 - $halfStartSpread}"
                   x2="{$x2}"
                   y2="{$y2 - $halfEndSpread}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                 name="g:slurDirection"
                 as="xs:integer">
      <xsl:param name="slur" as="node()"/>
      <xsl:variable name="slurNotes" select="g:slurNotes($slur)" as="node()*"/>
      <!-- TODO: Document this! -->
    <xsl:variable name="slurDirections" select="g:direction($slurNotes)" as="xs:integer*"/>
    
      <xsl:sequence select="if ($slurNotes)                           then if (count(distinct-values($slurDirections))=1)                                then $slurDirections[1]                                else -g:calculateDirection($slurNotes)                           else -1"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                 name="g:slurNotes"
                 as="node()*">
      <xsl:param name="slurElement" as="node()"/>
    
      <!-- TODO: Implement this -->
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                 name="v:sub">
      <xsl:param name="v1" as="xs:double+"/>
      <xsl:param name="v2" as="xs:double+"/>
    
      <xsl:sequence select="($v1[1]-$v2[1],$v1[2]-$v2[2])"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                 name="v:add">
      <xsl:param name="v1" as="xs:double+"/>
      <xsl:param name="v2" as="xs:double+"/>
    
      <xsl:sequence select="($v1[1]+$v2[1],$v1[2]+$v2[2])"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                 name="v:pointAtDivisionRatio">
      <xsl:param name="v1" as="xs:double+"/>
      <xsl:param name="v2" as="xs:double+"/>
      <xsl:param name="divisionRatio" as="xs:double"/>
    
      <xsl:sequence select="(         $v1[1]+$divisionRatio*($v2[1]-$v1[1]),         $v1[2]+$divisionRatio*($v2[2]-$v1[2]))"/>
  </xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                 name="v:mul">
      <xsl:param name="v" as="xs:double+"/>
      <xsl:param name="c" as="xs:double"/>
    
      <xsl:sequence select="($v[1]*$c,$v[2]*$c)"/>
  </xsl:function>
   <template match="musx:slur" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('slur ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="El"
                       select="(g:x1(.),g:y1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Er"
                       select="(g:x2(.),g:y2(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="d"
                       select="v:sub($Er,$El)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="t"
                       select="g:tilt(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="h"
                       select="g:height(.)*g:direction(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="s"
                       select="g:shoulder(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="v"
                       select="($t*$d[2],$d[1])"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="vLength"
                       select="xsb:sqrt($v[1]*$v[1]+$v[2]*$v[2])"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="vNorm"
                       select="($v[1] div $vLength,$v[2] div $vLength)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="c"
                       select="(1-$t)*$d[1]*$d[2] div (2*$vLength)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Pl"
                       select="(       $El[1]+($h + $c)*$vNorm[1],       $El[2]+($h + $c)*$vNorm[2])"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Pr"
                       select="(       $Er[1]+($h - $c)*$vNorm[1],       $Er[2]+($h - $c)*$vNorm[2])"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="M"
                       select="v:pointAtDivisionRatio($Pl,$Pr,.5*(g:shift(.)+1))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Sl"
                       select="v:pointAtDivisionRatio($M ,$Pl,$s)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Sr"
                       select="v:pointAtDivisionRatio($M ,$Pr,$s)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Ql"
                       select="v:pointAtDivisionRatio($Sl,$Pl,g:tipAngle1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Qr"
                       select="v:pointAtDivisionRatio($Sr,$Pr,g:tipAngle2(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Cl"
                       select="v:pointAtDivisionRatio($El,$Ql,g:curvature1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="Cr"
                       select="v:pointAtDivisionRatio($Er,$Qr,g:curvature2(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="thicknessDelta"
                       select="g:centerThickness(.)-g:tipThickness(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="o"
                       select="v:mul($vNorm,$thicknessDelta)"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="ol"
                       select="v:mul($o,g:swellingRate1(.))"
                       as="xs:double+"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                       name="or"
                       select="v:mul($o,g:swellingRate2(.))"
                       as="xs:double+"/>
         <svg:path xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v="NS:VECTOR"
                   fill="currentColor"
                   stroke="currentColor"
                   stroke-width="{g:tipThickness(.)}"
                   d="M{$El}         C{(v:add($Cl,$ol),v:add($Sl,$o ),v:add($M,$o))}         C{(v:add($Sr,$o ),v:add($Cr,$or),$Er)}         C{(v:sub($Cr,$or),v:sub($Sr,$o ),v:sub($M,$o))}         C{(v:sub($Sl,$o ),v:sub($Cl,$ol),$El)}         z"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:key xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            name="unicode-glyph"
            match="svg:glyph"
            use="string-to-codepoints(@unicode)"/>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="def:getGlyphWidth"
                 as="xs:double*">
			   <xsl:param name="string" as="xs:string"/>
			   <xsl:for-each select="string-to-codepoints($string)">
				<!-- TODO: Modify this so that document() can also take the URI of a file with other font metadata -->
				<xsl:sequence select="number(key('unicode-glyph',.,document(concat($libDirectory,'/',$symbolFile)))/@horiz-adv-x)"/>
			   </xsl:for-each>
		</xsl:function>
   <xsl:function xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 name="def:drawSymbols"
                 as="node()*">
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
   <template match="musx:symbolText" mode="draw">
      <svg:g transform="translate({g:x1(.)},{g:y(.)}) scale({g:size(.)})">
         <attribute name="class">
            <value-of select="normalize-space(concat('symbolText ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:sequence xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                       select="def:drawSymbols(text(), 0)"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:keySignature" mode="get_OwnBoundingBox" priority="1">
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="x"
                    select="g:x(.)"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="y"
                    select="g:y(.)"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="size"
                    select="g:size(.)"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="staffSize"
                    select="g:staffSize(.)"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="symbolBBox"
                    select="g:svgSymbolBoundingBox(g:symbol(.))"
                    as="element()"/>
      <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="steps"
                    as="xs:integer*">
         <xsl:for-each select="tokenize(normalize-space(g:pattern(.)),'\s+')">
            <xsl:sequence select=". cast as xs:integer"/>
         </xsl:for-each>
      </xsl:variable>
      <BoundingBox xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" left="{$x}"
                   right="{$x + count($steps)*g:distance(.) + $symbolBBox/@right*$size}"
                   top="{   $y + min($steps)*$staffSize + $symbolBBox/@top*$size}"
                   bottom="{$y + max($steps)*$staffSize + $symbolBBox/@bottom*$size}"/>
   </template>
   <template match="musx:keySignature" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('keySignature ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="steps"
                       select="tokenize(normalize-space(g:pattern(.)),'\s+')"
                       as="xs:string*"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="staffSize"
                       select="g:staffSize(.)"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="distance"
                       select="g:distance(.) div $staffSize"
                       as="xs:double"/>
         <xsl:variable xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="symbol"
                       select="g:symbol(.)"/>
         <svg:g xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                transform="translate({g:x(.)},{g:y(.)}) scale({$staffSize})">
            <xsl:for-each select="$steps">
               <svg:use x="{(position()-1) * $distance}" y="{number(.)}" xlink:href="{$symbol}"/>
            </xsl:for-each>
         </svg:g>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <xsl:template xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="@symbol"
                 mode="render-time-signature">
      <svg:use transform="translate({g:x(..)},{g:y(..)}) scale({g:size(..)})"
               xlink:href="{g:symbol(..)}"/>
  </xsl:template>
   <template match="musx:timeSignature" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('timeSignature ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <xsl:apply-templates xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="@symbol"
                              mode="render-time-signature"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:fraction" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('fraction ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="musx:articulation" mode="draw">
      <svg:g>
         <attribute name="class">
            <value-of select="normalize-space(concat('articulation ',@class))"/>
         </attribute>
         <apply-templates select="@*" mode="copy-svg-and-id-attributes"/>
         <svg:use xmlns="NS:DEF" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  transform="translate({g:x(.)},{g:y(.)}) scale({g:size(.)})"
                  xlink:href="{g:symbol(.)}"/>
         <apply-templates mode="draw"/>
      </svg:g>
   </template>
   <template match="@xml:id" mode="copy-svg-and-id-attributes">
      <attribute name="id">
         <value-of select="."/>
      </attribute>
   </template>
   <template match="@svg:*" mode="copy-svg-and-id-attributes">
      <attribute name="{local-name()}">
         <value-of select="."/>
      </attribute>
   </template>
   <template match="@*" mode="copy-svg-and-id-attributes"/>
   <template match="*" mode="draw" priority="-5"/>
   <template match="musx:musxHead" mode="generate-defs">
      <svg:defs>
         <apply-templates mode="generate-defs"/>
      </svg:defs>
   </template>
   <template match="*" mode="generate-defs" priority="-1"/>
   <template match="svg:*" mode="generate-defs">
      <copy-of select="."/>
   </template>
   <template match="/" priority="-10">
      <apply-templates select="." mode="musx2svg"/>
   </template>
   <template match="/musx:musx" mode="musx2svg">
      <svg:svg width="{g:x2(//musx:page[1])}" height="{g:y2(//musx:page[1])}">
         <apply-templates select="musx:musxHead[*]" mode="generate-defs"/>
         <apply-templates mode="draw"/>
      </svg:svg>
   </template>
   <template match="@*|node()" mode="add-bounding-boxes">
      <copy>
         <apply-templates mode="add-bounding-boxes" select="@*|node()"/>
      </copy>
   </template>
   <template match="musx:*" mode="add-bounding-boxes" priority="1">
      <variable name="children" as="node()*">
         <apply-templates mode="add-bounding-boxes" select="node()"/>
      </variable>
      <variable name="allBoundingBoxes" as="element()*">
         <sequence select="$children/musx:BoundingBox"/>
         <apply-templates mode="get_OwnBoundingBox" select="."/>
      </variable>
      <copy>
         <copy-of select="@*"/>
         <copy-of select="$children"/>
         <if test="$allBoundingBoxes">
            <musx:BoundingBox left="{min($allBoundingBoxes//@left)}" right="{max($allBoundingBoxes//@right)}"
                              top="{min($allBoundingBoxes//@top)}"
                              bottom="{max($allBoundingBoxes//@bottom)}"/>
         </if>
      </copy>
   </template>
   <template match="node()|@*" mode="get_OwnBoundingBox" priority="-2"/>
   <function name="g:OwnBoundingBox" as="element()*">
      <param name="element" as="element()*"/>
      <apply-templates select="$element" mode="get_OwnBoundingBox"/>
   </function>
   <function name="g:staffSize" as="xs:double*">
      <param name="element" as="element()*"/>
      <sequence select="g:size($element/ancestor::musx:staff[last()])"/>
   </function>
   <key name="svgID" match="svg:*[@id]" use="@id"/>
   <function name="g:svgSymbolBoundingBox" as="element()*">
      <param name="symbolURI" as="xs:string*"/>
      <for-each select="$symbolURI">
         <variable name="symbolID" select="substring-after(.,'#')" as="xs:string"/>
         <variable name="documentURI" select="substring-before(.,'#')" as="xs:string"/>
         <sequence select="key('svgID',$symbolID,document($documentURI))/svg:metadata/*:bbox"/>
      </for-each>
   </function>
   <template match="/" mode="svg-with-bounding-boxes">
      <variable name="musxWithBoundingBoxes">
         <apply-templates select="." mode="add-bounding-boxes"/>
      </variable>
      <apply-templates select="$musxWithBoundingBoxes/musx:musx" mode="musx2svg"/>
   </template>
</stylesheet>

