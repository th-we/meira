<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0" 
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:mei="http://www.music-encoding.org/ns/mei">

  <template match="/">
    <apply-templates mode="add-plists"/>
  </template>
  
  <template match="@*|node()" mode="add-plists">
    <copy>
      <apply-templates select="@*|node()" mode="add-plists"/>
    </copy>
  </template>

  <key name="notes-by-staff-and-layer" match="mei:note" 
      use="concat(
        ancestor::mei:staff/@n[last()],
        '$',
        ancestor::mei:layer/@n[last()]
      )"/>
  <template match="*[self::mei:beamSpan|self::mei:slur]
                    [ for $start in id(@startid),
                          $end   in id(@endid)
                      return     $start/ancestor::mei:staff/@n[1] = $end/ancestor::mei:staff/@n[1]
                             and $start/ancestor::mei:layer/@n[1] = $end/ancestor::mei:layer/@n[1]
                    ]" mode="add-plists">
    <message>
      processing <value-of select="local-name()"/> element <value-of select="@xml:id"/>
    </message>
    <variable name="startNote" select="id(@startid)" as="element()"/>
    <variable name="endNote"   select="id(@endid)"    as="element()"/>
    <variable name="innerNotes" select="key('notes-by-staff-and-layer',concat(
        (ancestor::mei:staff/@n,@staff)[last()],
        '$',
        (ancestor::mei:layer/@n,@layer)[last()]
        )) intersect $startNote/following::* intersect $endNote/preceding::*"/>
    <!-- QUESTION: Why doesn't [preceding::*=$startNote][following::*=$endNote] work instead of the intersections?-->
    <message>
      key = <value-of select="concat(
      (ancestor::mei:staff/@n,@staff)[last()],
      '$',
      (ancestor::mei:layer/@n,@layer)[last()]
      )"/>
      notes by staff and layer:
      <value-of select="for $note in key('notes-by-staff-and-layer',concat(
        (ancestor::mei:staff/@n,@staff)[last()],
        '$',
        (ancestor::mei:layer/@n,@layer)[last()]
        )) return $note/@xml:id"/>
    </message>
    <copy>
      <attribute name="plist">
        <value-of select="($startNote,$innerNotes,$endNote)/@xml:id"/>
      </attribute>
      <apply-templates select="@*|node()" mode="add-plists"/>
    </copy>
  </template>

  <!-- PROBLEM: As <beamSpan>s have a "musical" @dur (the same type as notes/rests),
       @tstamp/@dur can't be used for general <beamSpan>s. So we don't support it for now. -->
  <template match="mei:beamSpan[not(@plist)]" mode="add-plists">
    <message>
      WARNING: &lt;beamSpan&gt;s are only supported if they either have 
               - a pair of @startid/@endid attributes pointing to notes on the same staff or
               - a @plist attribute listing all notes they connect
               &lt;beamSpan&gt;s with @tstamp*/@dur* are not supported.
               Cross-staff &lt;beamSpan&gt;s are note supported yet.
    </message>
  </template>
</stylesheet>