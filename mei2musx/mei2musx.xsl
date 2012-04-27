<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:mei="http://www.music-encoding.org/ns/mei" 
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns:synch="NS:SYNCH" xmlns="NS:MUSX" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lf="NS:LOCAL_FUNCTIONS"
    xmlns:musx="NS:MUSX">
  <xsl:include href="beams.xsl"/>
  <xsl:include href="notes.xsl"/>

  <!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    This stylesheet relies on a preprocessed MEI file that has
    (among other things) IDs on all elements.
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->

  <!--<xsl:key name="when" match="mei:when" use="@*[local-name()='id' or local-name()='xml:id']"/>-->
  <xsl:key name="id" match="*" use="@*[contains(local-name(),'id')]"/>
<!--  <xsl:key name="staff" match="mei:staff" use="@n"/>
  <xsl:key name="staff" match="mei:*[@staff]" use="@staff"/>-->
  <xsl:key name="staffBySection" match="mei:staff" use="concat(@n,'_',ancestor::mei:section/@xml:id)"/>
  <xsl:key name="staffBySection" match="mei:*[@staff]" use="concat(@staff,'_',ancestor::mei:section/@xml:id)"/>
  <xsl:key name="defsBySynchId" match="mei:scoreDef|mei:staffDef" use="(ancestor-or-self::mei:*/@synch:id)[last()]"/>
  <xsl:key name="staffsBySynchId" match="mei:staff" use="(ancestor-or-self::mei:*/@synch:id)[last()]"/>
  <!-- TODO: Handle elements correctly that are inside another staff and have @staff 
             (they have to be omitted when processing the staff they're inside) -->
  <xsl:key name="measure" match="mei:measure" use="@n"/>
  <xsl:key name="synchValue" match="mei:*[@synch:rounded]" use="@synch:rounded"/>
  <xsl:key name="synchedElement" match="mei:*[@synch:rounded]" use="'true'"/>
  <xsl:param name="stylesheet" select="'type=&quot;text/xsl&quot; href=&quot;xsl/musx2svg.xsl&quot;'"/>
  <xsl:param name="staffDistance" select="70" as="xs:double"/>
  <xsl:param name="barlineSpace" select="10" as="xs:double"/>
  <xsl:param name="size" select="3" as="xs:double"/>
  <xsl:param name="margin" select="30" as="xs:double"/>
  <xsl:variable name="svgNS" select="'http://www.w3.org/2000/svg' cast as xs:anyURI" as="xs:anyURI"/>
  <xsl:variable name="nullNS" select="'' cast as xs:anyURI" as="xs:anyURI"/>
  
  
  <xsl:template match="/" priority="-10">
    <xsl:apply-templates select="." mode="mei2musx"/>
  </xsl:template>
 
  <xsl:template mode="mei2musx" match="/mei:mei">
    <musx>
      <musxHead>
        <libDirectory xlink:href="lib"/>
      </musxHead>
      <eventList>
        <!-- Add a special event that we use for attaching the clef, key and time signatures to -->
        <event xml:id="_t0" x="0" synchTime="0"/>
        <!--<xsl:apply-templates select="//mei:scoreDef[1]/mei:timeline[last()]/mei:when" mode="add-events"/>-->
        <!-- Only match one element with this synch value (first one returned by key('synchValue'..)) -->
        <xsl:for-each-group select="//@synch:rounded|//@synch:end.rounded" group-by=".">
          <xsl:sort select="number(.)"/>
          <!-- We need to find the corresponding synch:id or synch:end.id the  -->
          <xsl:variable name="synchIdAttributeLocalName" select="if(local-name()='end.rounded')
                                                                 then 'end.id'
                                                                 else 'id'" as="xs:string"/>
          <!-- This ("200 * .") is *VERY BAD* proportional spacing, just to have some spacing info. 
              TODO: Implement separate, elaborate spacing algorithm. -->
          <event x="{200 * .}" synchTime="{.}">
            <xsl:attribute name="xml:id">
              <xsl:value-of select="../@synch:*[local-name()=$synchIdAttributeLocalName]"/>
            </xsl:attribute>
          </event>
        </xsl:for-each-group>
      </eventList>      
      <page y2="{(count(distinct-values(//mei:staff/@n)) + 2) * $staffDistance}" 
        x2="p{2*$margin}" end="{//@synch:end.id[number(../@synch:end.rounded)=max(//@synch:end.rounded)]}">
        <xsl:apply-templates mode="mei2musx" select="mei:music/mei:*"/>
      </page>
    </musx>
  </xsl:template>
  
  <xsl:template match="mei:group|mei:music|mei:body|mei:mdiv" mode="mei2musx">
    <xsl:apply-templates mode="mei2musx"/>
  </xsl:template>
  
  <xsl:template match="mei:section" mode="mei2musx">
    <xsl:variable name="section" select="." as="element()"/>
    <system start="{@synch:id}" end="{(//mei:measure)[last()]/@synch:end.id}" size="{$size}">
      <barline/><!-- System barline -->
      <xsl:variable name="sortedStaffNs" as="xs:string*">
        <xsl:for-each select="distinct-values(.//mei:staff/@n)">
          <xsl:sort select="number(current())"/>
          <xsl:sequence select="."/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:for-each select="$sortedStaffNs">
        <!-- TODO: What about staffGrp? Those get lost -->
        <xsl:variable name="firstStaffN" select="($section//mei:staff[@n=current()])[1]"/>
        <!-- QUESTION: is ($firstStaffN/preceding::mei:staffDef[@n=current()])[last()]
              the same as  $firstStaffN/preceding::mei:staffDef[@n=current()][1]  ? -->
        <xsl:variable name="initialStaffDef" select="($firstStaffN/preceding::mei:staffDef[@n=current()])[last()]"/>
        <staff y="p{$staffDistance * position()}" start="{$section/@synch:id}">
          <!-- Display staff label -->
          <svg y="S6" x="s-2">
            <svg:text font-size="4" text-anchor="end">
              <xsl:value-of select="current()"/>
            </svg:text>
          </svg>
          <!-- In theory, the clef information can be found inside a scoreDef, but as we're only handling 
               canonicalized <clef> elements and scoreDef only has @clef.* attributes, we're hoping a clef
               element has been provided and will fail if it isn't. -->
          <xsl:variable name="clefElement" as="element()">
            <xsl:apply-templates select="$firstStaffN" mode="get-current-clef-element"/>
          </xsl:variable>
          <clef symbol="clef.{$clefElement/@shape}" y="L{$clefElement/@line}" x="s{1}"/>
          <xsl:apply-templates mode="add-key-signature" select="$section">
            <xsl:with-param name="meiClef" select="$clefElement" as="element()"/>
          </xsl:apply-templates>
          <xsl:apply-templates mode="add-time-signature" select="(key('staffsBySynchId',$section/@synch:id,$section),$section)[1]"/>
          <!-- Add all content from all <staff> elements with corresponding @n -->
          <!-- QUESTION: Does this key actually work?? -->
<!--          <xsl:apply-templates mode="mei2musx" select="key('staffBySection',concat(current(),'_',$section/@xml:id))"/>-->
          <xsl:apply-templates mode="mei2musx" select="key('staffBySection',concat(current(),'_',$section/@xml:id),$section)"/>
        </staff>
      </xsl:for-each>
    </system>
  </xsl:template>
  
  <xsl:template match="*" mode="copy-id">
    <xsl:attribute name="xml:id">
      <!-- Hopefully this satisfies all XSLT processors -->
      <xsl:value-of select="attribute::*[local-name()='xml:id']|@xml:id"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="@synch:id">
    <xsl:attribute name="start">
      <xsl:value-of select="string()"/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- TODO: Find an appropriate replacement for this template -->
<!--  <xsl:template match="mei:staffGrp" mode="add-staffs">
    <staffGroup>
      <xsl:apply-templates mode="add-staffs" select="mei:staffGrp|mei:staffDef"/>
    </staffGroup>
  </xsl:template>-->
  
  <xsl:template match="*" mode="add-time-signature">
    <xsl:variable name="staffN" select="((ancestor-or-self::mei:staff|ancestor-or-self::mei:staffDef)/@n)[last()]"/>
    <xsl:variable name="synchID" select="(ancestor-or-self::*/@synch:id)[last()]"/> 
    <xsl:variable name="meterDefiningElement" as="element()" select="
      (: Select keySig's at the immediate start of this element or previous ones :)
      (
        preceding::mei:staffDef[@n=$staffN]|preceding::mei:scoreDef
        ,key('defsBySynchId',$synchID)
      )
      [@meter.symbol or @meter.count]
      [last()]"/>
    <timeSignature start="{$synchID}">
      <xsl:apply-templates mode="add-timesignature-symbols" select="$meterDefiningElement"/>
    </timeSignature>
  </xsl:template>
  
  <xsl:template match="mei:*[@meter.sym]" mode="add-timesignature-symbols" priority="1">
    <xsl:attribute name="symbol">
      <xsl:value-of select="concat('metersymbol.',@meter.sym)"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="mei:*[@meter.count and @meter.unit]" mode="add-timesignature-symbols">
    <fraction>
      <symbolText><xsl:value-of select="@meter.count"/></symbolText>
      <symbolText><xsl:value-of select="@meter.unit"/></symbolText>
    </fraction>
  </xsl:template>

  <xsl:template match="mei:*" mode="get-current-key-signature-element">
    <xsl:variable name="synchID" select="@synch:id"/>
    <xsl:variable name="staffN" select="(ancestor-or-self::mei:staff/@n)[last()]" as="xs:string?"/>
    <xsl:sequence select="
      (: Select keySig's at the immediate start of this element or previous ones :)
      (
        descendant::mei:keySig[ancestor::*/@synch:id[1]=$synchID]|
        preceding::mei:keySig
      )
      (: reduce sequence to only those keySig's that are inside staffDef's with proper @n or inside scoreDef's
         i.e. exclude those from staffDef's with improper @n :)
      [not(ancestor::mei:staffDef/@n!=$staffN)][last()]"/>
    <!-- TODO: Check whether the above "filter" actually works for elements that aren't inside <staff>s -->
  </xsl:template>
  
  <xsl:template match="mei:*" mode="get-current-clef-element">
    <xsl:variable name="staffN" select="(ancestor-or-self::mei:staff/@n)[last()]" as="xs:string"/>
    <xsl:sequence select="
      (
        mei:staffDef/mei:clef
        |preceding::mei:clef[
          (ancestor::mei:staffDef|ancestor::mei:staff)/@n=$staffN
        ]
      )[last()]"/>
  </xsl:template>

  <xsl:template mode="add-key-signature" match="*">
    <xsl:param name="meiKeySig" as="element()">
      <xsl:apply-templates select="." mode="get-current-key-signature-element"/>
    </xsl:param>
    <xsl:param name="meiClef" as="element()">
      <xsl:apply-templates select="." mode="get-current-clef-element"/>
    </xsl:param>
    <keySignature symbol="accidental.{$meiKeySig/@accid}" y="L{$meiClef/@line}">
      <!-- $clefSpace tells us how much space the preceding clef takes up -->
      <xsl:attribute name="pattern">
        <!-- Extract pattern from table
          - first with substring-after get the section that follows "s" for sharps and "f" for flats 
          - then, again with substring-after get section that belongs to the current clef (G, C or F; GG has same pattern as G
          - then with substring get the first $n 4-char "table cells" which represent the pattern -->
        <xsl:value-of select="           
          substring(
            substring-after(
              substring-after(
                's G-6  -3  -7  -4  -1  -5  -2
                   C-3   0  -4  -1   2  -2   1
                   F 0   3  -1   2   5   1   4
                 f G-2  -5  -1  -4   0  -3   1
                   C 1  -2   2  -1   3   0   4
                   F 4   1   5   2   6   3   7',
                 mei:keySig/@accid
              ),
              (: We only take the first letter of @shape because it could be 'GG' :)
              substring($meiClef/@shape,1,1)            
            ), 1, ($meiKeySig/@n cast as xs:integer)*4
          )"/>
         </xsl:attribute>
    </keySignature>
    <!-- TODO: Handle more complex ("mixed") patterns -->
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:staff">
    <xsl:variable name="measure" select="ancestor::mei:measure[last()]" as="element()"/>
    <group class="measure">
      <xsl:if test="string($measure/@left)!=('','invis')">
        <barline start="{$measure/@synch:id}">
          <xsl:apply-templates select="@right" mode="add-barline-type-attributes"/>
          <xsl:apply-templates select="@right" mode="add-barline-stroke-features"/>
          <!-- Display measure number -->
          <svg y="S-2">
            <svg:text font-size="3" text-anchor="middle" stroke="none" fill="currentColor">
              <xsl:value-of select="$measure/@n"/>
            </svg:text>
          </svg>
        </barline>
      </xsl:if>
      <xsl:apply-templates mode="mei2musx"/>
      <xsl:if test="$measure/@right!='invis'">
        <barline start="{$measure/@synch:end.id}">
          <xsl:apply-templates select="$measure/@right" mode="add-barline-type-attributes"/>
          <xsl:apply-templates select="$measure/@right" mode="add-barline-stroke-features"/>
        </barline>
      </xsl:if>
    </group>
  </xsl:template>
  
  <xsl:function name="lf:generateAttribute">
    <xsl:param name="namespace" as="xs:anyURI"/>
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="value" as="xs:string"/>
    <xsl:attribute name="{$name}" namespace="{$namespace}">
      <xsl:value-of select="$value"/>
    </xsl:attribute>
  </xsl:function>
  
  <xsl:template match="mei:measure/@right[string()=('dbl','dbldashed','dbldotted')]" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','double')"/>
  </xsl:template>
  <xsl:template match="mei:measure/@right[string()='end']" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','end')"/>
  </xsl:template>
  <xsl:template match="mei:measure/@right[string()='rptstart']" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','repeatStart')"/>
  </xsl:template>
  <xsl:template match="mei:measure/@right[string()='rptend']" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','repeatEnd')"/>
  </xsl:template>
  <xsl:template match="mei:measure/@right" mode="add-barline-type-attributes" priority="-1"/>
  
  <xsl:template match="mei:measure/@right[string()=('dashed','dbldashed')]" mode="add-barline-stroke-features">
    <xsl:sequence select="lf:generateAttribute($svgNS,'stroke-dasharray','12,8')"/>
  </xsl:template>
  <xsl:template match="mei:measure/@right[string()=('dotted','dbldotted')]" mode="add-barline-stroke-features">
    <xsl:sequence select="lf:generateAttribute($svgNS,'stroke-dasharray','6,6')"/>
    <xsl:sequence select="lf:generateAttribute($svgNS,'stroke-linecap','round')"/>
  </xsl:template>
  <xsl:template match="mei:measure/@right" mode="add-barline-stroke-features"/>
  
  <!-- This groups elements so that they can be styled (e.g. hidden) or manipulated with Javascript as a whole. -->
  <xsl:template mode="mei2musx" match="mei:rdg|mei:del|mei:lem|mei:orig|mei:reg|mei:app">
    <!-- TODO: In order to avoid class naming clashes, find a sensible method of prefixing or somehow else
         modifying the names of sources, hands and the name of the editorial/analysis element --> 
    <group class="{local-name()} {@source} {@hand}">
      <xsl:apply-templates mode="mei2musx"/>
    </group>
  </xsl:template>
  
  <xsl:function name="musx:getDynamPosition" as="xs:double">
    <xsl:param name="dynamElement" as="element()"/>
    <xsl:variable name="positionAbove" select="-5" as="xs:double"/>
    <xsl:variable name="positionBelow" select="14" as="xs:double"/>
    <xsl:variable name="staffN" select="($dynamElement/@staff,$dynamElement/ancestor::mei:staff/@n)[1]" as="xs:string"/>
    <xsl:sequence select="if ($dynamElement/@place)
                          then if($dynamElement/@place='below') 
                               then $positionBelow 
                               else $positionAbove
                            (: If this staff is carrying lyrics, then place dynamics above the staff. :)
                          else if($dynamElement/ancestor::mei:section//mei:staff[@n=$staffN]//mei:syl)
                               then $positionAbove
                               else $positionBelow"></xsl:sequence>
  </xsl:function>
  
  <xsl:template mode="mei2musx" match="mei:hairpin">
    <!-- TODO: Proper y positioning (as well for mei:dynam, see below) -->
    <hairpin start="{(@synch:id|@startid)[1]}" end="{(@synch:end.id|@endid)[1]}" y="S{musx:getDynamPosition(.)}">
      <xsl:variable name="opening" select="if(@opening) then @opening * 2 else 4"/>
      <xsl:attribute name="{if(@form = 'cres') then 'endSpread' else 'startSpread'}">
        <xsl:value-of select="concat('s',$opening)"/>
      </xsl:attribute>
    </hairpin>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:slur">
    <xsl:variable name="y" select="if(@curvedir='below') then '14' else '-5'"/>
    <!-- TODO: Proper height and y positioning (as well for mei:dynam, see below) -->
    <slur start="{(@synch:id,@startid)[1]}" end="{(@synch:end.id,@endid)[1]}" y1="S{$y}" y2="S{$y}" 
      height="s{if(@curvedir='below') then '' else '-'}8"/>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:tie">
    <!-- TODO: 
      - Proper height
      - accept @tstamp instead of @startid
      - proper y positioning (as well for mei:dynam, see below) -->
    <slur class="tie" start="{(@startid,@synch:id)[1]}" end="{(@endid,@synch:end.id)[1]}" height="s{if(@curvedir='below') then '' else '-'}3.5"/>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:dynam">
    <!-- TODO: Proper y positioning (as well for mei:hairpin, see above) -->
    <symbolText start="{@synch:id}" class="dynam" y="S{musx:getDynamPosition(.)}">
      <xsl:apply-templates mode="mei2musx"/>
    </symbolText>
  </xsl:template>
  
  <!-- TODO: Implement lyrics properly -->
  <!-- TODO: Canonicalize lyrics so that they always appear in a <verse> element with proper @n -->
  <xsl:template mode="mei2musx" match="mei:syl">
    <svg y="S{10 + 5*number(parent::mei:verse/@n)}">
      <svg:text font-size="5">
        <xsl:value-of select="."/>
        <xsl:if test="@wordpos=('i','m') or @con='d'">
          <xsl:value-of select="'-'"/>
        </xsl:if>
      </svg:text>
    </svg>
  </xsl:template>
  
</xsl:stylesheet>
