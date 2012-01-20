<?xml version="1.0" ?>
<!-- QUESTIONS:
  - Should Lilypond baselines be used for clefs?  Yes, as MEI specifies clef position this way as well.
  - Should Score convention ("align right") be used for accidentals?
  - Should Lilypond convention for articulation marks be used (origin is at the center)? Yes!
-->
<!-- 
  TODO: Find a proper solution for adding bounding box information without using
  a browser and copy code manually.

  This stylesheet works best with Firefox. It doesn't execute the 
  JavaScript code immediately, this requires and additional click.
  Opera doesn't display the output unless one (re)opens Firefly 
  and one can't select and copy the code.
  Chrome only does the transformation if started with option 
  - -disable-web-security and does not display scroll bars.
-->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:svg="http://www.w3.org/2000/svg">
  <xsl:key name="glyph" match="svg:font/svg:glyph" use="@glyph-name"/>
  
  <xsl:template match="/symbolmap">
    <xsl:variable name="svgfont" select="document(@svgfont)"/>
  
    <xsl:if test="not($svgfont)">
      <xsl:message terminate="yes">
        ERROR: SVG font file <xsl:value-of select="@svgfont"/> was not found.
      </xsl:message>
    </xsl:if>
    
    <svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="100%" height="100%" onload="init()">
      <!-- Add bounding box information using SVG JavaScript API. This has to be done in a browser.
           Afterwards, the DOM has to be exported, e.g. using Firebug.
      -->
      <script type="application/ecmascript" class="temporary"><![CDATA[
        var svgNS = "http://www.w3.org/2000/svg" 
        var xlinkNS = "http://www.w3.org/1999/xlink" 
        
        function init() {
          var useElement = document.getElementById('use')
          // We want to select the equivalent of XPath //g[@class="symbol"]
          symbols = document.getElementsByTagName('g')
          // The predicate is tested in the if statement
          for (var i=0; i<symbols.length; i++) {
            var symbol = symbols[i]
            if (!symbol.getAttribute || symbol.getAttribute("class") != "symbol") continue;

            // If we temporarily set the transform attribute to a scale(1,-1), we get bounding box 
            // values that are more precise and more consistent between different implementations.
            // However, some symbols have extra translations, so we accept inconsistencies for now and 
            // don't scale to (1,-1) and set scaleFactor to 1.
            var scaleFactor = 1
            //var scaleFactor = parseFloat(symbol.getAttribute("transform").match(/scale\(([^,]*),/)[1])
            //symbol.setAttribute("transform","scale(1,-1)")
            
            useElement.setAttributeNS(xlinkNS, 'href', '#' + symbol.getAttribute('id'))
            var bbox = useElement.getBBox()
            
            //symbol.setAttribute("transform","scale(" + scaleFactor + "," + (-scaleFactor) + ")")
       
            bboxElement = document.createElementNS('','bbox')
            bboxElement.setAttribute('x',      scaleFactor * bbox.x)
            bboxElement.setAttribute('y',      scaleFactor * bbox.y)
            bboxElement.setAttribute('width',  scaleFactor * bbox.width)
            bboxElement.setAttribute('height', scaleFactor * bbox.height)
            
            var metadata = symbol.getElementsByTagName('metadata')[0]
            if (!metadata) {
              alert('No metadata element found inside symbol ' + symbol.getAttribute('id'))
              continue;
            }
            metadata.appendChild(bboxElement)
            document.documentElement.removeAttribute("onload")
          }
          
          document.documentElement.removeChild(document.getElementById('button'))
          document.documentElement.removeChild(document.getElementById('use'))
          
          serialize(document.documentElement)
        }
        
        function serialize(element,indent) {
          function write(string) {
            document.getElementById('code').appendChild(document.createTextNode(string))
          }
          
          // as we don't have text nodes, only serialize "normal" elements
          if (element.nodeType != 1) return "";
          if (element.getAttribute("class") == "temporary") return "";
          if (!indent) var indent = ""
          
          write(indent + "<" + element.nodeName)
          for (var i=0; i<element.attributes.length; i++) {
            var attribute = element.attributes[i]
            write(" " + attribute.nodeName + "='" + attribute.nodeValue + "'")
          }
          if (element.namespaceURI != svgNS && !element.getAttribute('xmlns')) write(" xmlns=''")
          if (element.hasChildNodes()) {
            write(">\n")
            for (var i=0; i<element.childNodes.length; i++) {
              serialize(element.childNodes[i],indent + "  ")
            }
            write(indent + "</" + element.nodeName + ">\n")
          } else {
            write("/>\n")
          }
        }
      ]]>
      </script>
      <defs class="symbols">
        <metadata>
          <font>
            <xsl:apply-templates select="$svgfont//svg:font/@*|$svgfont//svg:font/svg:font-face"/>
          </font>
        </metadata>
        <xsl:apply-templates select="symbol">
          <xsl:with-param name="svgfont" select="$svgfont"/>
        </xsl:apply-templates>
      </defs>
      <foreignObject width="100%" height="100%" class="temporary">
        <body xmlns="http://www.w3.org/1999/xhtml" style="height: 100%; width: 100%;">
          <pre style="overflow: auto; height: 95%; width: 95%;">
            <code id="code"/>
          </pre>
        </body>      
      </foreignObject>
      <g onclick="init()" id="button" class="temporary">
        <rect width="600" height="25" fill="#888" rx="5"/>
        <text x="300" y="20" font-size="20" text-anchor="middle">
          Click here to add bounding box metadata
        </text>
      </g>
      <use id="use" class="temporary"/>
    </svg>
  </xsl:template>
  
  <xsl:template match="symbol[string-length(@mei) != 0 and string-length(@glyph-name) != 0]" priority="1">
    <xsl:param name="svgfont"/>
    <xsl:variable name="glyph-name" select="@glyph-name"/>
    <xsl:variable name="id" select="@mei"/>
    <xsl:variable name="transform" select="concat(@transform, substring(' ',string-length(@transform)))"/>
    <xsl:variable name="directSVG" select="svg:*"/>
    
    <!-- TODO: Check whether occurence of @mei is unique, otherwise we'll end up with non-unique IDs -->
    <!-- TODO: Generalize the following transform. The scaling factor must be defined in the symbolmap. -->
    <xsl:for-each select="$svgfont">
      <xsl:choose>
        <xsl:when test="key('glyph',$glyph-name) or $directSVG">
          <g id="{$id}" transform="{$transform}scale(.0075,-.0075)" class="symbol" style="stroke:none">
            <xsl:apply-templates select="key('glyph',$glyph-name)"/>
            <xsl:copy-of select="$directSVG"/>
          </g>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            WARNING: Neither glyph <xsl:value-of select="$glyph-name"/> nor a direct SVG definition was found for symbol <xsl:value-of select="@mei"/>.
          </xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="symbol[svg:*]" priority="1">
    <g id="{@mei}" class="symbol" style="stroke:none">
      <metadata/>
      <xsl:copy-of select="svg:*"/>
    </g>
  </xsl:template>
  
  <xsl:template match="symbol[@mei]" priority="0">
    <xsl:message>
      MEI symbol <xsl:value-of select="@mei"/> skipped. No corresponding glyph defined.
    </xsl:message>
  </xsl:template>

  <xsl:template match="svg:glyph">
    <metadata>
      <!-- TODO: Is an SVG namespaced <glyph> O.K. here? Should the information be stored differently? -->
      <glyph>
        <xsl:apply-templates select="@*[local-name()!='d']"/>
      </glyph>
    </metadata>
    <xsl:apply-templates select="@d|*"/>
  </xsl:template>

  <xsl:template match="@d">
    <path d="{.}"/>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="@horiz-adv-x">
    <xsl:attribute name="horiz-adv-x">
      <xsl:value-of select=". * .0075"/>
    </xsl:attribute>
  </xsl:template>
</xsl:stylesheet>
