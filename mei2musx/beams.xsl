<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mei="http://www.music-encoding.org/ns/mei" 
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns="NS:MUSX"
    xmlns:synch="NS:SYNCH"
    xmlns:musx="NS:MUSX">
  
  <!-- This function calculates the number of beams necessary for notes of duration $dur. 
       As we can't take roots with XSLT, this recursive functino is used that in any iteration
       increments the parameter $number and divides $dur by 2 -->
  <xsl:function name="musx:getNumberOfBeams" as="xs:integer">
    <xsl:param name="dur" as="xs:integer"/>
    <xsl:param name="number" as="xs:integer"/>
    
    <xsl:sequence select="if($dur gt 5)
                          then musx:getNumberOfBeams($dur div 2,$number+1)
                          else $number"/>
  </xsl:function>
  
  <xsl:template mode="mei2musx" match="mei:beam|mei:beamSpan">
    <!-- Beamed events contains all beamed events in the correct chronological order -->
    <xsl:param name="beamedEvents" as="element()*">
      <!-- For <beam>: -->
      <xsl:sequence select=".//mei:note[not(ancestor::mei:chord)]|.//mei:chord"/>
      <!-- For <beamSpan> -->
      <xsl:for-each select="id(distinct-values((@startid, tokenize(@plist,'\s*#'), @endid)))">
        <xsl:sort select="@synch:rounded" data-type="number"/>
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </xsl:param>
    
    <xsl:variable name="minimumDur" select="min($beamedEvents/@dur) cast as xs:integer" as="xs:integer"/>
    <beam start="{$beamedEvents[1]/@xml:id}" end="{$beamedEvents[last()]/@xml:id}" number="{musx:getNumberOfBeams($minimumDur,0)}">
      <!-- $minimumDur is the numerically smallest @dur attribut, i.e. the *biggest* time value;
           if there are durations 8, 16, 32, 32, then 8 is the minimum dur -->
      <xsl:apply-templates select="@xml:id" mode="mei2musx"/>
      <!-- add-direction template is in notes.xsl -->
      <xsl:apply-templates select="$beamedEvents/@stem.dir[1]" mode="add-direction"/>
      <xsl:sequence select="musx:addSubbeams($beamedEvents,$minimumDur)"/>
    </beam>
    <xsl:apply-templates mode="mei2musx"/>
  </xsl:template>
   
  <xsl:function name="musx:addSubbeams" as="element()*">
    <xsl:param name="events" as="element()*"/>
    <xsl:param name="alreadyDrawnDur" as="xs:integer"/>

    <!-- QUESTION: Is there a simpler way??? -->
    <xsl:variable name="eventIndexesWithoutSubbeam" select="$events[./@dur  = $alreadyDrawnDur]/index-of($events/@xml:id,./@xml:id)" as="xs:integer*"/>
    <xsl:variable name="eventIndexesWithSubbeam"    select="$events[./@dur != $alreadyDrawnDur]/index-of($events/@xml:id,./@xml:id)" as="xs:integer*"/>
    
    <!-- Indexes that point to events in $events that are the potential start of a subbeam.
         The first event in $events is a potential start, 
         and all events immediately following other events for which the already drawn beam is sufficient -->
    <xsl:for-each select="$eventIndexesWithSubbeam[.-1 = (0,$eventIndexesWithoutSubbeam)]">
      <xsl:variable name="startIndex" select="." as="xs:integer"/>
      <xsl:variable name="endIndex" select="$eventIndexesWithSubbeam[. ge $startIndex 
                                                                     and .+1 = ($eventIndexesWithoutSubbeam,count($events)+1)][1]" as="xs:integer"/>
      <xsl:variable name="beamedEvents" select="for $i in $eventIndexesWithSubbeam[. ge $startIndex and . le $endIndex]
                                                return $events[$i]" as="node()+"/>
      
      <xsl:variable name="minimumDur" select="min($beamedEvents/@dur) cast as xs:integer" as="xs:integer"/>
      <subbeam start="{$beamedEvents[1]/@xml:id}" end="{$beamedEvents[last()]/@xml:id}" number="{musx:getNumberOfBeams($minimumDur div $alreadyDrawnDur * 4,0)}">
        <!-- If there is only one note under this subbeam, add a stemlet -->
        <xsl:if test="count($beamedEvents)=1">
          <xsl:attribute name="x1">
            <!-- TODO: Distinguish whether stemlet goes to the left or to the right -->
            <xsl:value-of select="'s-2'"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:sequence select="musx:addSubbeams($beamedEvents,$minimumDur)"/>
      </subbeam>
    </xsl:for-each>
  </xsl:function>

  <!-- TODO: improve positioning of ftrems for whole notes (does this have to be done in the musx2svg step?) -->
  <xsl:template mode="mei2musx" match="mei:fTrem">
    <xsl:variable name="tremoloNotesAndChords" select="mei:note|mei:chord" as="node()*"/>
    <xsl:variable name="numberOfBeams" select="if ($tremoloNotesAndChords[1]/@dur = '2')
                                               then 1
                                               else musx:getNumberOfBeams($tremoloNotesAndChords[1]/@dur,0)" as="xs:integer"/>
    <beam start="{$tremoloNotesAndChords[1     ]/@xml:id}" 
            end="{$tremoloNotesAndChords[last()]/@xml:id}" number="{$numberOfBeams}" class="fTrem">
      <xsl:apply-templates select="@xml:id" mode="mei2musx"/>
      <subbeam x1="s2" x2="s-2" number="{@slash - $numberOfBeams}"/>
    </beam>
    <xsl:apply-templates mode="mei2musx"/>
  </xsl:template>
</xsl:stylesheet>
