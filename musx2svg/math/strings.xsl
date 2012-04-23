<?xml version="1.0" encoding="UTF-8"?>
<!-- 
	Copyright (c) 2009-2011 Stefan Krause
	
	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:
	
	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY cr "&#x0A;">
<!ENTITY crt "<xsl:text xmlns:xsl='http://www.w3.org/1999/XSL/Transform' disable-output-escaping='yes'>&cr;</xsl:text>">
<!ENTITY TabString "&#160;&#160;&#160;&#160;&#160;&#160;">
<!ENTITY XSL-Base-Directory "http://www.expedimentum.org/example/xslt/xslt-sb">
<!ENTITY doc-Base-Directory "http://www.expedimentum.org/example/xslt/xslt-sb/doc">
]>
<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsb="http://www.expedimentum.org/XSLT/SB"
	xmlns:intern="http://www.expedimentum.org/XSLT/SB/intern"
	xmlns:saxon="http://saxon.sf.net/"
	xmlns:doc="http://www.CraneSoftwrights.com/ns/xslstyle"
	xmlns:docv="http://www.CraneSoftwrights.com/ns/xslstyle/vocabulary"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="doc docv xsb intern"
	extension-element-prefixes="saxon"
	>
	<!--  -->
	<!--  -->
	<!--  -->
	<doc:doc filename="strings.xsl" internal-ns="docv" global-ns="doc xsb intern" vocabulary="DocBook" info="$Revision: 11 $, $Date: 2011-05-15 15:02:57 +0200 (Sun, 15 May 2011) $">
		<doc:title>Strings und Texte</doc:title>
		<para>Dieses Stylesheet enthält Funktionen für Strings und Texte.</para>
		<para>Da für Testroutinen Funktionen und Templates aus <code>internals.xsl</code> benötigt werden, wird dieses Stylesheet in <code><link xlink:href="strings_tests.html">strings_tests.xsl</link></code> getestet.</para>
		<para>Autor: <author>
			<firstname>Stefan</firstname>
			<surname>Krause</surname>
			</author>
		</para>
		<para>Homepage: <link xlink:href="http://www.expedimentum.org/">http://www.expedimentum.org/</link></para>
		<para role="license"><emphasis role="bold">Lizenz (duale Lizenzierung):</emphasis></para>
		<para role="license">Dieses Stylesheet und die dazugehörige Dokumentation sind unter einer Creative Commons-Lizenz (<link xlink:href="http://creativecommons.org/licenses/by/3.0/">CC-BY&#160;3.0</link>)
			lizenziert. Die Weiternutzung ist bei Namensnennung erlaubt.</para>
		<para role="license">Dieses Stylesheet und die dazugehörige Dokumentation sind unter der sogenannten Expat License (einer GPL-kompatiblen MIT License) lizensiert. Es darf – als Ganzes oder auszugweise – 
			unter Beibehaltung der Copyright-Notiz kopiert, verändert, veröffentlicht und verbreitet werden. Die Copyright-Notiz steht im Quelltext
			des Stylesheets und auf der <link xlink:href="standard.html#standard.license">Startseite der Dokumentation</link>.</para>
		<itemizedlist>
			<title>Original-URLs</title>
			<listitem>
				<para>Stylesheet: <link xlink:href="&XSL-Base-Directory;/strings.xsl">&XSL-Base-Directory;/strings.xsl</link></para>
			</listitem>
			<listitem>
				<para>Dokumentation: <link xlink:href="&doc-Base-Directory;/strings.html">&doc-Base-Directory;/strings.html</link></para>
			</listitem>
			<listitem>
				<para>Test-Stylesheet: <link xlink:href="&XSL-Base-Directory;/strings_tests.xsl">&XSL-Base-Directory;/strings_tests.xsl</link></para>
			</listitem>
			<listitem>
				<para>Test-Dokumentation: <link xlink:href="&doc-Base-Directory;/strings_tests.html">&doc-Base-Directory;/strings_tests.html</link></para>
			</listitem>
			<listitem>
				<para>XSLT-SB: <link xlink:href="&XSL-Base-Directory;/">&XSL-Base-Directory;/</link></para>
			</listitem>
			<listitem>
				<para>Google Code: <link xlink:href="http://code.google.com/p/xslt-sb/">http://code.google.com/p/xslt-sb/</link></para>
			</listitem>
		</itemizedlist>
		<revhistory>
			<revision>
				<revnumber>0.2.0</revnumber>
				<date>2011-05-14</date>
				<authorinitials>Stf</authorinitials>
				<revremark>erste veröffentlichte Version</revremark>
			</revision>
			<revision>
				<revnumber>0.129</revnumber>
				<date>2011-02-27</date>
				<authorinitials>Stf</authorinitials>
				<revremark>Erweiterung der Lizenz auf Expath/MIT license</revremark>
			</revision>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revremark>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></revremark>
			</revision>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revremark>initiale Version</revremark>
			</revision>
		</revhistory>
	</doc:doc>
	<!--  -->
	<!--  -->
	<!--  -->
	<!-- ====================     Funktionen     ==================== -->
	<!--  -->
	<!--  -->
	<!-- __________     xsb:lax-string-compare()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<doc:param name="compare-to"><para>Vergleichswert (String)</para></doc:param>
		<para xml:id="lax-string-compare">Verarbeitet Eingabe und Vergleichswert mit <function>normalize-space()</function> und <function>lower-case()</function> und vergleicht dann Eingabe und Vergleichswert. Dadurch werden kleine Differenzen ignoriert.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:lax-string-compare" as="xs:boolean">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:param name="compare-to" as="xs:string?"/>
		<xsl:sequence select="normalize-space(lower-case($input)) eq normalize-space(lower-case($compare-to))"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:return-default-if-empty()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<doc:param name="default"><para>Standardwert (String)</para></doc:param>
		<para xml:id="return-default-if-empty">gibt einen übergebenen Standardwert aus, wenn der übergeben String leer ist oder nur Whitespace enthält, sonst den String selbst</para>
		<para>Wenn der übergebene Standardwert eine Leersequenz ist, wird ein Leerstring zurückgegeben.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:return-default-if-empty" as="xs:string">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:param name="default" as="xs:string?"/>
		<xsl:choose>
			<xsl:when test="normalize-space($input)">
				<xsl:sequence select="$input"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="concat('', $default)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:trim-left()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<para xml:id="trim-left">entfernt führenden Whitespace</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:trim-left" as="xs:string">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:choose>
			<xsl:when test="matches($input, '^\s' )">
				<xsl:sequence select="xsb:trim-left(substring($input, 2, string-length($input)-1))"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- erzwinge Ausgabe eines Leerstrings -->
				<xsl:sequence select="concat('', $input)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:trim-right()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<para xml:id="trim-right">entfernt Whitespace am Ende</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:trim-right" as="xs:string">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:choose>
			<xsl:when test="matches($input, '^.*\s$' )">
				<xsl:sequence select="xsb:trim-right(substring($input, 1, string-length($input)-1))"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- erzwinge Ausgabe eines Leerstrings -->
				<xsl:sequence select="concat('', $input)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:trim()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<para xml:id="trim">entfernt Whitespace am Anfang und am Ende. Im Unterschied zu <function>normalize-space()</function> wird Whitespace in der Mitte nicht berücksichtigt.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:trim" as="xs:string">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:sequence select="xsb:trim-left(xsb:trim-right($input))"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:normalize-paragraphs()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<para xml:id="normalize-paragraphs">ersetzt mehrfache Zeilenwechsel durch einen einzelnen Zeilenwechsel. Im Unterschied zu <function>normalize-space()</function> wird ein Zeilenwechsel aber erhalten.</para>
		<para>rekursiver Algorithmus: die Funktion ruft sich solange selbst auf, bis keine mehrfachen Zeilenwechsel in der Eingabe vorhanden sind.</para>
		<para>Da die Eingabe sinnvoll eine Leersequenz sein kann, ist die Rückgabe einer Leersequenze erlaubt.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:normalize-paragraphs" as="xs:string?" intern:solved="EmptySequenceAllowed">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:choose>
			<!-- Windows: &#x0A;&#x0D; -->
			<xsl:when test="matches($input, '&#x0A;&#x0D;&#x0A;&#x0D;', 'm' )">
				<xsl:sequence select="xsb:normalize-paragraphs(replace($input, '&#x0A;&#x0D;&#x0A;&#x0D;', '&#x0A;&#x0D;', 'm'))"/>
			</xsl:when>
			<!-- Unix: &#x0A; -->
			<xsl:when test="matches($input, '&#x0A;&#x0A;', 'm' )">
				<xsl:sequence select="xsb:normalize-paragraphs(replace($input, '&#x0A;&#x0A;', '&#x0A;', 'm'))"/>
			</xsl:when>
			<!-- Mac: &#x0D; -->
			<xsl:when test="matches($input, '&#x0D;&#x0D;', 'm' )">
				<xsl:sequence select="xsb:normalize-paragraphs(replace($input, '&#x0D;&#x0D;', '&#x0D;', 'm'))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="$input"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:listed     __________ -->
	<doc:function>
		<doc:param name="list"><para>Leerzeichen-getrennte Liste von String-Token</para></doc:param>
		<doc:param name="item"><para>String-Token, auf dessen Existenz getestet werden soll</para></doc:param>
		<para xml:id="listed">Diese Funktion überprüft, ob in einer Leerzeichen-getrennten Liste ein bestimmter Eintrag vorhanden ist.</para>
		<para>Die Eingabe eines Leerstrings oder einer Leersequenz als Parameter <code>list</code> ergibt <code>false()</code>.</para>
		<para>Die Eingabe eines Leerstrings oder einer Leersequenz als Parameter <code>item</code> ergibt <code>false()</code>.</para>
		<revhistory>
			<revision>
				<revnumber>0.69</revnumber>
				<date>2009-12-05</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:listed" as="xs:boolean">
		<xsl:param name="list" as="xs:string?"/>
		<xsl:param name="item" as="xs:string?"/>
		<xsl:choose>
			<xsl:when test="some $i in tokenize($list, ' ') satisfies ($i eq $item)"><xsl:sequence select="true()"/></xsl:when>
			<xsl:otherwise><xsl:sequence select="false()"/></xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!--  -->
	<!-- __________     xsb:return-composed-string-if-not-empty   __________ -->
	<doc:function>
		<doc:param name="tested-string"><para>getesteter String</para></doc:param>
		<doc:param name="string-before"><para>String, der vor dem getesteten String eingefügt werden soll</para></doc:param>
		<doc:param name="string-after"><para>String, der nach dem getesteten String eingefügt werden soll</para></doc:param>
		<para xml:id="return-composed-string-if-not-empty">Diese Funktion fügt vor und nach dem zu testenden String die übergebenen Strings ein, wenn der zu testende String nicht leer ist.</para>
		<para>Mit dieser Funktion wird die Erzeugung von bedingten Texten vereinfacht, bspw. das Einfügen von Kommata oder Doppelpunkten nach einem Text.</para>
		<revhistory>
			<revision>
				<revnumber>0.96</revnumber>
				<date>2010-06-27</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:return-composed-string-if-not-empty" as="xs:string">
		<xsl:param name="string-before" as="xs:string?"/>
		<xsl:param name="tested-string" as="xs:string?"/>
		<xsl:param name="string-after" as="xs:string?"/>
		<xsl:choose>
			<xsl:when test="normalize-space($tested-string)">
				<xsl:sequence select="concat($string-before, $tested-string, $string-after)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select=" '' "/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:encode-for-id()     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<para xml:id="encode-for-id">wandelt einen eingegebenen String in eine xs:ID um, indem verbotene Zeichen ersetzt werden</para>
		<revhistory>
			<revision>
				<revnumber>0.124</revnumber>
				<date>2010-10-10</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:encode-for-id" as="xs:string">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:sequence select="concat(translate(encode-for-uri(translate(normalize-space($input), ' ', '_')), '%', 'x'), '')"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!--  -->
</xsl:stylesheet>
