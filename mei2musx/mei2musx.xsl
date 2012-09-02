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
  <!--<xsl:include href="beams.xsl"/>
  <xsl:include href="notes.xsl"/>
-->
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
  <xsl:param name="size" select="3" as="xs:double"/>
  <xsl:param name="margin" select="30" as="xs:double"/>
  <!-- TODO: textScaleFactor is an arbitrary value. Any more solid choices? -->
  <xsl:param name="textScaleFactor" select=".3" as="xs:double"/>
  <xsl:variable name="svgNS" select="'http://www.w3.org/2000/svg' cast as xs:anyURI" as="xs:anyURI"/>
  <xsl:variable name="nullNS" select="'' cast as xs:anyURI" as="xs:anyURI"/>
  
  
  <xsl:template match="/" priority="-10">
    <xsl:apply-templates select="." mode="mei2musx"/>
  </xsl:template>
 
  <xsl:template mode="mei2musx" match="/mei:mei">
    <musx>
      <musxHead>
        <libDirectory xlink:href="lib"/>
        <xsl:apply-templates select="//mei:symbolTable" mode="mei2musx"/>
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
  
  <xsl:template match="@xml:id" mode="mei2musx">
    <xsl:attribute name="xml:id">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@color" mode="mei2musx">
    <xsl:sequence select="lf:generateAttribute($svgNS,'color',replace(.,'^x','#'))"/>
  </xsl:template>
  
  <xsl:template match="mei:group|mei:music|mei:body|mei:mdiv|mei:layer" mode="mei2musx">
    <group class="{local-name()}">
      <xsl:apply-templates select="@xml:id|mei:*" mode="mei2musx"/>
    </group>
  </xsl:template>
  
  <xsl:template match="mei:section" mode="mei2musx">
    <xsl:variable name="section" select="." as="element()"/>
    <system start="{@synch:id}" end="{(.//mei:measure)[last()]/@synch:end.id}" size="{$size}">
      <barline function="systemic"/>
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
          <clef symbol="clef.{$clefElement/@shape}" y="L{$clefElement/@line}"/>
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
  
  <xsl:template mode="mei2musx" match="@synch:id">
    <xsl:sequence select="lf:generateAttribute($nullNS,'start',string())"/>
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
    <xsl:sequence select="lf:generateAttribute($nullNS,'symbol',concat('metersymbol.',@meter.sym))"/>
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
    <xsl:param name="meiKeySig" as="element()?">
      <xsl:apply-templates select="." mode="get-current-key-signature-element"/>
    </xsl:param>
    <xsl:param name="meiClef" as="element()">
      <xsl:apply-templates select="." mode="get-current-clef-element"/>
    </xsl:param>
    <xsl:if test="$meiKeySig">
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
                   $meiKeySig/@accid
                ),
                (: We only take the first letter of @shape because it could be 'GG' :)
                substring($meiClef/@shape,1,1)            
              ), 1, ($meiKeySig/@n cast as xs:integer)*4
            )"/>
           </xsl:attribute>
      </keySignature>
    </xsl:if>
    <!-- TODO: Handle more complex ("mixed") patterns -->
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:staff">
    <xsl:variable name="measure" select="ancestor::mei:measure[last()]" as="element()"/>
    <group class="measure" start="{$measure/@synch:id}">
      <!-- Display measure number -->
      <svg y="S-2" x="s-5">
        <svg:text font-size="3" text-anchor="middle" stroke="none" fill="currentColor">
          <xsl:value-of select="$measure/@n"/>
        </svg:text>
      </svg>
      <xsl:if test="$measure/@left">
        <barline start="{$measure/@synch:id}">
          <xsl:apply-templates select="@left" mode="add-barline-type-attributes"/>
          <xsl:apply-templates select="@left" mode="add-barline-stroke-features"/>
        </barline>
      </xsl:if>
      <xsl:apply-templates mode="mei2musx"/>
      <barline start="{$measure/@synch:end.id}">
        <xsl:apply-templates select="$measure/@right" mode="add-barline-type-attributes"/>
        <xsl:apply-templates select="$measure/@right" mode="add-barline-stroke-features"/>
      </barline>
    </group>
  </xsl:template>
  
  <xsl:template match="mei:clef[not(ancestor::mei:scoreDef or ancestor::mei:staffDef)]" mode="mei2musx">
    <clef symbol="clef.{@shape}" y="L{@line}" start="{@synch:id}"/>
  </xsl:template>
  
  <xsl:function name="lf:generateAttribute">
    <xsl:param name="namespace" as="xs:anyURI"/>
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="value" as="xs:string"/>
    <xsl:attribute name="{$name}" namespace="{$namespace}">
      <xsl:value-of select="$value"/>
    </xsl:attribute>
  </xsl:function>
  
  <xsl:template match="@right[string()=('dbl','dbldashed','dbldotted')]" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','double')"/>
  </xsl:template>
  <xsl:template match="@right[string()='end']" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','end')"/>
  </xsl:template>
  <xsl:template match="@right[string()='rptstart']" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','repeatStart')"/>
  </xsl:template>
  <xsl:template match="@right[string()='rptend']" mode="add-barline-type-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'type','repeatEnd')"/>
  </xsl:template>
  <xsl:template match="@right" mode="add-barline-type-attributes" priority="-1"/>
  
  <xsl:template match="@right[string()=('dashed','dbldashed')]" mode="add-barline-stroke-features">
    <xsl:sequence select="lf:generateAttribute($svgNS,'stroke-dasharray','12,8')"/>
  </xsl:template>
  <xsl:template match="@right[string()=('dotted','dbldotted')]" mode="add-barline-stroke-features">
    <xsl:sequence select="lf:generateAttribute($svgNS,'stroke-dasharray','6,6')"/>
    <xsl:sequence select="lf:generateAttribute($svgNS,'stroke-linecap','round')"/>
  </xsl:template>
  <xsl:template match="@right[string()=('invis')]" mode="add-barline-stroke-features">
    <xsl:sequence select="lf:generateAttribute($svgNS,'display','none')"/>
  </xsl:template>
  <xsl:template match="@right" mode="add-barline-stroke-features"/>
  
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
    <!-- QUESTION: Should @startid/@endid be used preferably? -->
    <hairpin start="{(@synch:id|@startid)[1]}" end="{(@synch:end.id|@endid)[1]}" y="S{musx:getDynamPosition(.)}">
      <xsl:apply-templates select="@xml:id" mode="mei2musx"/>
      <xsl:variable name="opening" select="if(@opening) then @opening * 2 else 4"/>
      <xsl:attribute name="{if(@form = 'cres') then 'endSpread' else 'startSpread'}">
        <xsl:value-of select="concat('s',$opening)"/>
      </xsl:attribute>
    </hairpin>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:slur|mei:tie">
    <!--<xsl:variable name="y" select="if(@curvedir='below') then '14' else '-5'"/>-->
    <!-- TODO: - Proper height and y positioning (as well for mei:dynam, see below) 
               - accept @tstamp instead of @startid
               - @direction="-1" if there are lyrics on this staff -->
    <slur start="{(@startid,@synch:id)[1]}" end="{(@endid,@synch:end.id)[1]}">
      <xsl:if test="self::mei:tie">
        <xsl:attribute name="class">
          <xsl:value-of select="'tie'"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="@xml:id|@curvedir" mode="mei2musx"/>
    </slur>
  </xsl:template>
  
  <xsl:template match="@curvedir[.='above']" mode="mei2musx">
    <xsl:sequence select="lf:generateAttribute($nullNS,'direction','-1')"/>
  </xsl:template>
  <xsl:template match="@curvedir[.='below']" mode="mei2musx">
    <xsl:sequence select="lf:generateAttribute($nullNS,'direction','1')"/>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:dynam">
    <!-- TODO: 
         - Proper y positioning (as well for mei:hairpin, see above) 
         - Check for <rend> and non-symbolText glyphs; use <svg:text> in that case -->
    <symbolText class="dynam" y="S{musx:getDynamPosition(.)}">
      <xsl:apply-templates select="." mode="add-start-attribute"/>
      <xsl:apply-templates select="@xml:id" mode="mei2musx"/>
      <xsl:value-of select="."/>
    </symbolText>
  </xsl:template>
  
  <xsl:template match="*[@startid or @synch:id]" mode="add-start-attribute">
    <xsl:attribute name="start">
      <xsl:value-of select="(@startid,@synch:id)[1]"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*" mode="add-start-attribute"/>

  <!-- TODO: Implement lyrics properly -->
  <!-- TODO: Canonicalize lyrics so that they always appear in a <verse> element with proper @n -->
  <xsl:template mode="mei2musx" match="mei:syl">
    <svg y="S{10 + 5*number(parent::mei:verse/@n)}">
      <xsl:apply-templates select="@xml:id" mode="mei2musx"/>
      <svg:text transform="scale({$textScaleFactor})">
        <xsl:apply-templates select="@*" mode="set-text-rendering-attributes"/>
        <xsl:apply-templates select="node()" mode="mei2musx"/>
        <xsl:if test="@wordpos=('i','m') or @con='d'">
          <xsl:value-of select="'-'"/>
        </xsl:if>
      </svg:text>
    </svg>
  </xsl:template>
  
  <xsl:template mode="mei2musx" match="mei:rend">
    <svg:tspan>
      <xsl:apply-templates select="@*" mode="set-text-rendering-attributes"/>
      <xsl:apply-templates select="node()" mode="mei2musx"/>
    </svg:tspan>
  </xsl:template>
  
  <xsl:template match="@*" mode="set-text-rendering-attributes"/>
  <xsl:template match="@fontfam" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'font-family',.)"/>
  </xsl:template>
  <!-- QUESTION: What is @fontname meant to be? -->
  
  <xsl:template match="@fontstyle[.=('normal','oblique')]" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'font-style',.)"/>
  </xsl:template>
  <xsl:template match="@fontstyle[.='ital']" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'font-style','italic')"/>
  </xsl:template>
  
  <xsl:template match="@fontweight[.='bold']" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'font-weight',.)"/>
  </xsl:template>
  
  <!-- TODO: What is the reference scale for @fontsize? -->
  <xsl:template match="@fontsize" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'font-size',.)"/>
  </xsl:template>
  
  <!-- TODO: dblunderline is not supported by SVG. Draw it with graphics primitives? -->
  <xsl:template match="@rend[.=('dblunderline','underline')]" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'text-decoration','underline')"/>
  </xsl:template>
  <xsl:template match="@rend[.='strike']" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'text-decoration','line-through')"/>
  </xsl:template>
  <xsl:template match="@rend[.='sub']" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'baseline-shift','sub')"/>
  </xsl:template>
  <xsl:template match="@rend[.='sup']" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'baseline-shift','super')"/>
  </xsl:template>
  <xsl:template match="@rend[.='smcaps']" mode="set-text-rendering-attributes">
    <xsl:sequence select="lf:generateAttribute($nullNS,'font-variant','small-caps')"/>
  </xsl:template>
  <!-- TODO: - draw box for @rend=("box","circle");
             - handle @rend=("quote","bslash","fslash") -->
  
  <xsl:template match="mei:dir|mei:tempo" mode="mei2musx">
    <svg>
      <xsl:apply-templates select="." mode="add-start-attribute"/>
      <xsl:attribute name="y">
        <xsl:apply-templates mode="add-vertical-dir-position" select="."/>
      </xsl:attribute>
      <svg:text transform="scale({$textScaleFactor})">
        <xsl:apply-templates select="@*" mode="set-text-rendering-attributes"/>
        <xsl:apply-templates select="node()" mode="mei2musx"/>
      </svg:text>
    </svg>
  </xsl:template>
  <xsl:template match="mei:dir|mei:tempo" mode="add-vertical-dir-position">
    <xsl:value-of select="'S-5'"/>
  </xsl:template>
  <xsl:template match="mei:*[@place='below']" mode="add-vertical-dir-position">
    <xsl:value-of select="'S14'"/>
  </xsl:template>
  <xsl:template match="mei:*[@place='within']" mode="add-vertical-dir-position">
    <xsl:value-of select="'S6'"/>
  </xsl:template>
  
  <xsl:template match="mei:symbolTable" mode="mei2musx">
    <svg:defs>
      <xsl:apply-templates mode="mei2musx"/>
    </svg:defs>
  </xsl:template>
  
  <xsl:template match="mei:symbolDef" mode="mei2musx">
    <svg:g transform="scale(1,-1)" stroke="currentColor" fill="none" stroke-width=".2" id="{@xml:id}">
      <xsl:apply-templates mode="mei2musx"/>
    </svg:g>
  </xsl:template>

  <!-- TODO: Handle "standalone" lines and ones with @startid/@endid -->
  <xsl:template match="mei:line[parent::mei:symbolDef]" mode="mei2musx" name="createLine">
    <svg:line>
      <xsl:apply-templates select="@x|@y|@x2|@y2" mode="add-line-attributes"/>
    </svg:line>
  </xsl:template>
  
  <xsl:template match="@*" mode="add-line-attributes">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="@x|@y" mode="add-line-attributes">
    <xsl:attribute name="{local-name()}1">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- TODO: Handle standalone curves and ones with @bulge/@startid/@endid -->
<!--  <xsl:template match="mei:curve[parent::mei:symbolDef][@x][@y][@bezier][@x2][@y2]" mode="mei2musx">
    <svg:path d="M{@x} {@y} C{@bezier} {@x2} {@y2}"/>
  </xsl:template>-->
  <xsl:template match="mei:curve[parent::mei:symbolDef][@startho or @ho][@startvo or @vo][@bezier][@endho][@endvo]" mode="mei2musx">
    <xsl:variable name="c" select="for $coordinate in tokenize(normalize-space(@bezier),'\s+')
                                   return $coordinate cast as xs:double" as="xs:double*"/>
    <xsl:variable name="x1" select="(@startho,@ho)[1] cast as xs:double"/>
    <xsl:variable name="y1" select="(@startvo,@vo)[1] cast as xs:double"/>
    <xsl:variable name="x2" select="(@endho)[1] cast as xs:double"/>
    <xsl:variable name="y2" select="(@endvo)[1] cast as xs:double"/>
    <svg:path d="M{$x1} {$y1} C{$x1+$c[1]} {$y1+$c[2]} {$x2+$c[3]} {$y2+$c[4]} {$x2} {$y2}"/>
  </xsl:template>
  
  <xsl:template match="mei:symbol" mode="mei2musx">
    <svg>
      <xsl:apply-templates select="." mode="add-start-attribute"/>
      <svg:use xlink:href="{@ref}"/>
    </svg>
  </xsl:template>
</xsl:stylesheet>
