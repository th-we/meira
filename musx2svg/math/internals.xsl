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
	<!--<xsl:import href="internals.logging.xsl"/>-->
	<!--  -->
	<!--  -->
	<!--  -->
	<doc:doc filename="internals.xsl" internal-ns="docv" global-ns="doc xsb intern" vocabulary="DocBook" info="$Revision: 41 $, $Date: 2012-03-24 21:59:50 +0100 (Sa, 24 Mrz 2012) $">
		<doc:title>Interne Funktionen</doc:title>
		<para>Dieses Stylesheet enthält interne Templates und Funktionen, z.B. für Logging und Debug-Meldungen.</para>
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
				<para>Stylesheet: <link xlink:href="&XSL-Base-Directory;/internals.xsl">&XSL-Base-Directory;/internals.xsl</link></para>
			</listitem>
			<listitem>
				<para>Dokumentation: <link xlink:href="&doc-Base-Directory;/internals.html">&doc-Base-Directory;/internals.html</link></para>
			</listitem>
			<listitem>
				<para>Test-Stylesheet: <link xlink:href="&XSL-Base-Directory;/internals_tests.xsl">&XSL-Base-Directory;/internals_tests.xsl</link></para>
			</listitem>
			<listitem>
				<para>Test-Dokumentation: <link xlink:href="&doc-Base-Directory;/internals_tests.html">&doc-Base-Directory;/internals_tests.html</link></para>
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
				<revnumber>0.2.25</revnumber>
				<date>2011-05-29</date>
				<authorinitials>Stf</authorinitials>
				<revremark><function>xsb:type-annotation</function> und <function>xsb:cast</function> hinzugefügt.</revremark>
			</revision>
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
				<revnumber>0.82</revnumber>
				<date>2010-04-02</date>
				<authorinitials>Stf</authorinitials>
				<revremark>Auslagerung von Test-Logik nach <code><link xlink:href="internals.testing.html">internals.testing.xsl</link></code>
					und der Tests für <code><link xlink:href="internals.html">internals.xsl</link></code>
					und <code><link xlink:href="strings.html">strings.xsl</link></code></revremark>
			</revision>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revremark>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></revremark>
			</revision>
			<revision>
				<revnumber>0.50</revnumber>
				<date>2009-10-11</date>
				<authorinitials>Stf</authorinitials>
				<revremark>Ausgliederung von Logging aus <code><link xlink:href="internals.html">internals.xsl</link></code>
					nach <code><link xlink:href="internals.logging.html">internals.logging.xml</link>; Eingliederung von <code>strings-2.xsl</code></code></revremark>
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
	<!-- ====================     Stylesheet-Parameter     ==================== -->
	<!--  -->
	<!--  -->
	<!-- __________     xsl:param internals.logging-level     __________ -->
	<doc:param ignore-ns="yes">
		<para>gültige Werte: »<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>«</para>
		<para>Meldungen können einen Level entsprechend den Log4j-Stufen 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>« 
			haben (siehe Template <link linkend="internals.Error"><function>xsb:internals.Error</function></link>).
			Dieser Parameter bestimmt, ab welchem Wert Meldungen geloggt (d.h. angezeigt bzw. ausgegeben) werden.</para>
	</doc:param>
	<!-- ALL > TRACE > DEBUG > INFO > WARN > ERROR > FATAL -->
	<xsl:param name="internals.logging-level" as="xs:string">INFO</xsl:param>
	<doc:variable ignore-ns="yes">
		<para>Hilfsvariable, da dieser Wert häufig benötigt wird.</para>
	</doc:variable>
	<xsl:variable	name="_internals.logging-level"
		as="xs:integer" 
		select="xsb:logging-level($internals.logging-level)"/>
	<!--  -->
	<!--  -->
	<!-- __________     xsl:param internals.errors.die-on-critical-errors     __________ -->
	<doc:param ignore-ns="yes">
		<para>gültige Werte: »<code>ja</code>«, »<code>nein</code>«, »<code>yes</code>«, »<code>no</code>«, »<code>0</code>«, »<code>1</code>« 
			und andere verbale Wahrheitswerte, die 
			<function><link linkend="parse-string-to-boolean">xsb:parse-string-to-boolean()</link></function> versteht</para>
		<para>Fehlermeldungen können einen Level entsprechend den Log4j-Stufen 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>«
			haben (siehe Template <link linkend="internals.Error"><function>xsb:internals.Error</function></link>). Bei »<code>ERROR</code>« wird die Verarbeitung 
			normalerweise sofort beendet. Ist aber dieser Parameter auf »<code>No</code>« gesetzt, wird die Verarbeitung fortgesetzt, z.B. für Debugging. 
			Bei »<code>FATAL</code>« wird die Verarbeitung in jedem Fall abgebrochen.</para>
	</doc:param>
	<!-- Yes/No -->
	<xsl:param name="internals.errors.die-on-critical-errors" as="xs:string">Yes</xsl:param>
	<doc:variable ignore-ns="yes">
		<para>Hilfsvariable, da dieser Wert häufig benötigt wird.</para>
	</doc:variable>
	<xsl:variable	name="_internals.errors.die-on-critical-errors"
			as="xs:boolean" 
			select="xsb:parse-string-to-boolean($internals.errors.die-on-critical-errors)"/>
	<!--  -->
	<!--  -->
	<!-- __________     xsl:param internals.logging.output-target     __________ -->
	<doc:param ignore-ns="yes">
		<para>gültige Werte: »<code>console</code>«, »<code>file</code>« oder »<code>both</code>«</para>
		<para>Loggingmeldungen können via <function>xsl:message</function> auf die Konsole ausgegeben 
			oder in die Ergebnis-Datei geschrieben werden. Auch beides ist möglich. Entsprechend ist als 
			Ziel »<code>console</code>«, »<code>file</code>« oder »<code>both</code>« zu wählen. Bei einer 
			davon abweichenden Eingabe wird nur auf die Konsole geschrieben</para>
	</doc:param>
	<!-- console / file / both -->
	<xsl:param name="internals.logging.output-target" as="xs:string?">console</xsl:param>
	<!--  -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.logging.write-to-console">Hilfsvariable, da dieser Wert häufig benötigt wird. Bei der Ermittlung dieser Variablen wird 
			außerdem der Parameter <code>internals.logging.output-target</code> auf Gültigkeit geprüft.</para>
	</doc:variable>
	<xsl:variable name="_internals.logging.write-to-console" as="xs:boolean">
		<xsl:choose>
			<xsl:when test="xsb:lax-string-compare($internals.logging.output-target, 'both' )"><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="xsb:lax-string-compare($internals.logging.output-target, 'console' )"><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="xsb:lax-string-compare($internals.logging.output-target, 'file' )"><xsl:sequence select="false()"/></xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="true()"/>
				<xsl:call-template name="intern:internals.ProvisionalError">
					<xsl:with-param name="caller">_internals.logging.write-to-console</xsl:with-param>
					<xsl:with-param name="message">Ungültige Eingabe für $internals.logging.output-target: "<xsl:sequence select="$internals.logging.output-target"/>", es wird auf der Konsole ausgegeben.</xsl:with-param>
					<xsl:with-param name="level">WARN</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--  -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.logging.write-to-file">Hilfsvariable, da dieser Wert häufig benötigt wird.</para>
	</doc:variable>
	<xsl:variable name="_internals.logging.write-to-file" as="xs:boolean">
		<xsl:choose>
			<xsl:when test="xsb:lax-string-compare($internals.logging.output-target, 'both' )"><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="xsb:lax-string-compare($internals.logging.output-target, 'file' )"><xsl:sequence select="true()"/></xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--  -->
	<!--  -->
	<!-- __________     internals.logging.write-to-file-style     __________ -->
	<doc:param ignore-ns="yes">
		<para xml:id="internals.logging.write-to-file-style">gültige Werte: »<code>comment</code>«, »<code>element</code>«, »<code>html</code>«, »<code>text</code>«</para>
		<para>Nur bei Ausgabe in Datei: Loggingmeldungen können als HTML, 
			XML-Elemente, Kommentare oder Text in das Ausgabedokument geschrieben werden. HTML eignet sich für 
			die sofortige Anzeige, XML-Elemente für eine spätere maschinelle Auswertung, Kommentare für ad-hoc-Meldungen 
			zur späteren Durchsicht. Text bietet  sich an, wenn eine reine Report-Datei generiert werden soll. 
			Ist die Eingabe ungültig, wird als Kommentar ausgegeben.</para>
	</doc:param>
	<!-- comment / element / html / text-->
	<xsl:param name="internals.logging.write-to-file-style" as="xs:string?">comment</xsl:param>
	<!--  -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.logging.write-to-file-as-comment">Hilfsvariable, da dieser Wert häufig benötigt wird. Bei der Ermittlung dieser Variablen wird außerdem 
			der Parameter <code>internals.logging.write-to-file-style</code> auf Gültigkeit geprüft.</para>
	</doc:variable>
	<xsl:variable name="_internals.logging.write-to-file-as-comment" as="xs:boolean">
		<xsl:choose>
			<xsl:when test="xsb:lax-string-compare($internals.logging.write-to-file-style, 'comment' )"><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="xsb:lax-string-compare($internals.logging.write-to-file-style, 'element' )"><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="xsb:lax-string-compare($internals.logging.write-to-file-style, 'html' )"><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="xsb:lax-string-compare($internals.logging.write-to-file-style, 'text' )"><xsl:sequence select="false()"/></xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="true()"/>
				<xsl:call-template name="intern:internals.ProvisionalError">
					<xsl:with-param name="caller">_internals.logging.write-to-file-as-comment</xsl:with-param>
					<xsl:with-param name="message">Ungültige Eingabe für $internals.logging.write-to-file-style: "<xsl:sequence select="$internals.logging.write-to-file-style"/>", es wird als Kommentar geschrieben.</xsl:with-param>
					<xsl:with-param name="level">WARN</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--  -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.logging.write-to-file-as-element">Hilfsvariable, da dieser Wert häufig benötigt wird.</para>
	</doc:variable>
	<xsl:variable	name="_internals.logging.write-to-file-as-element" 
			as="xs:boolean"
			select="xsb:lax-string-compare($internals.logging.write-to-file-style, 'element')"/>
	<!--  -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.logging.write-to-file-as-html">Hilfsvariable, da dieser Wert häufig benötigt wird.</para>
	</doc:variable>
	<xsl:variable	 name="_internals.logging.write-to-file-as-html" 
			as="xs:boolean"
			select="xsb:lax-string-compare($internals.logging.write-to-file-style, 'html')"/>
	<!--  -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.logging.write-to-file-as-text">Hilfsvariable, da dieser Wert häufig benötigt wird.</para>
	</doc:variable>
	<xsl:variable	name="_internals.logging.write-to-file-as-text"
			as="xs:boolean"
			select="xsb:lax-string-compare($internals.logging.write-to-file-style, 'text')"/>
	<!--  -->
	<!--  -->
	<!-- __________     xsl:param internals.logging.linebreak-string     __________ -->
	<doc:param ignore-ns="yes">
		<para xml:id="internals.logging.linebreak-string">Dieses Zeichen wird bei Textausgabe als Zeilenwechsel ausgegeben, 
			per Default <code>&amp;#x0A;</code></para>
	</doc:param>
	<!-- Dieses Zeichen wird bei Textausgabe als Zeilenwechsel ausgegeben, per Default &#x0A; -->
	<xsl:param name="internals.logging.linebreak-string" as="xs:string?" xml:space="preserve">&#x0A;</xsl:param>
	<!--  -->
	<!--  -->
	<!-- __________     xsl:variable_internals.root-node     __________ -->
	<doc:variable ignore-ns="yes">
		<para xml:id="_internals.root-node">Dokumentenknoten. Hilfsvariable, um einen Kontext in kontextlose Funktionen und Templates zu transportieren.</para>
	</doc:variable>
	<xsl:variable	name="_internals.root-node"
		as="document-node()"
		select="/"/>
	<!--  -->
	<!--  -->
	<!--  -->
	<!-- ====================     Templates     ==================== -->
	<!--  -->
	<!--  -->
	<!-- __________     xsb:internals.Logging     __________ -->
	<doc:template>
		<!-- Content -->
		<para xml:id="internals.Logging">Dieses Template ist ein Wrapper für <function>intern:internals.logging.Output</function> für ein einfaches Logging.</para>
		<para>Viele Template-Parameter sind mit den Werten der Stylesheet-Parameter oder mit Werten von XPath-Funktionen vorbelegt,
			um die Benutzung zu vereinfachen.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
		<doc:param name="log-entry.preText">
			<para>siehe <link linkend="log-entry.preText">intern:internals.logging.Output#log-entry.preText</link></para>
			<para>Default: leer</para>
		</doc:param>
		<doc:param name="log-entry.ID">
			<para>siehe <link linkend="log-entry.ID">intern:internals.logging.Output#log-entry.ID</link></para>	
			<para>Default: leer</para>
		</doc:param>
		<doc:param name="log-entry.timeStamp">
			<para>siehe <link linkend="log-entry.timeStamp">intern:internals.logging.Output#log-entry.timeStamp</link></para>	
			<para>Default: <function>current-dateTime()</function></para>
		</doc:param>
		<doc:param name="log-entry.processedFile">
			<para>siehe <link linkend="log-entry.processedFile">intern:internals.logging.Output#log-entry.processedFile</link></para>	
			<para>Default: <function>document-uri(/)</function></para>
		</doc:param>
		<doc:param name="log-entry.level">
			<para>siehe <link linkend="log-entry.level">intern:internals.logging.Output#log-entry.level</link></para>	
			<para>Default: <code>ALL</code></para>
		</doc:param>
		<doc:param name="log-entry.text">
			<para>siehe <link linkend="log-entry.text">intern:internals.logging.Output#log-entry.text</link></para>	
			<para>Default: leer</para>
		</doc:param>
		<doc:param name="log-entry.category">
			<para>siehe <link linkend="log-entry.category">intern:internals.logging.Output#log-entry.category</link></para>	
			<para>Default: leer</para>
		</doc:param>
		<doc:param name="log-entry.postText">
			<para>siehe <link linkend="log-entry.postText">intern:internals.logging.Output#log-entry.postText</link></para>	
			<para>Default: leer</para>
		</doc:param>
		<!-- Formatierung -->
		<doc:param name="log-entry.linebreak-string">
			<para>siehe <link linkend="log-entry.linebreak-string">intern:internals.logging.Output#log-entry.linebreak-string</link></para>	
			<para>Default: <code><link linkend="internals.logging.linebreak-string">$internals.logging.linebreak-string</link></code></para>
		</doc:param>
		<!-- Ausgabemedium -->
		<doc:param name="log-entry.write-to-console">
			<para>siehe <link linkend="log-entry.write-to-console">intern:internals.logging.Output#log-entry.write-to-console</link></para>	
			<para>Default: <code><link linkend="_internals.logging.write-to-console">$_internals.logging.write-to-console</link></code></para>
		</doc:param>
		<doc:param name="log-entry.write-to-file">
			<para>siehe <link linkend="log-entry.write-to-file">intern:internals.logging.Output#log-entry.write-to-file</link></para>	
			<para>Default: <code><link linkend="_internals.logging.write-to-file">$_internals.logging.write-to-file</link></code></para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-comment">
			<para>siehe <link linkend="log-entry.write-to-file-as-comment">intern:internals.logging.Output#log-entry.write-to-file-as-comment</link></para>	
			<para>Default: <code><link linkend="_internals.logging.write-to-file-as-comment">$_internals.logging.write-to-file-as-comment</link></code></para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-element">
			<para>siehe <link linkend="log-entry.write-to-file-as-element">intern:internals.logging.Output#log-entry.write-to-file-as-element</link></para>	
			<para>Default: <code><link linkend="_internals.logging.write-to-file-as-element">$_internals.logging.write-to-file-as-element</link></code></para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-html">
			<para>siehe <link linkend="log-entry.write-to-file-as-html">intern:internals.logging.Output#log-entry.write-to-file-as-html</link></para>	
			<para>Default: <code><link linkend="_internals.logging.write-to-file-as-html">$_internals.logging.write-to-file-as-html</link></code></para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-text">
			<para>siehe <link linkend="log-entry.write-to-file-as-text">intern:internals.logging.Output#log-entry.write-to-file-as-text</link></para>	
			<para>Default: <code><link linkend="_internals.logging.write-to-file-as-text">$_internals.logging.write-to-file-as-text</link></code></para>
		</doc:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<doc:param name="log-entry.write-preText">
			<para>siehe <link linkend="log-entry.write-preText">intern:internals.logging.Output#log-entry.write-preText</link></para>	
			<para>Default: <code>false()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-ID">
			<para>siehe <link linkend="log-entry.write-ID">intern:internals.logging.Output#log-entry.write-ID</link></para>	
			<para>Default: <code>false()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-timeStamp">
			<para>siehe <link linkend="log-entry.write-timeStamp">intern:internals.logging.Output#log-entry.write-timeStamp</link></para>	
			<para>Default: <code>false()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-processedFile">
			<para>siehe <link linkend="log-entry.write-processedFile">intern:internals.logging.Output#log-entry.write-processedFile</link></para>	
			<para>Default: <code>false()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-level">
			<para>siehe <link linkend="log-entry.write-level">intern:internals.logging.Output#log-entry.write-level</link></para>	
			<para>Default: <code>true()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-text">
			<para>siehe <link linkend="log-entry.write-text">intern:internals.logging.Output#log-entry.write-text</link></para>	
			<para>Default: <code>true()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-category">
			<para>siehe <link linkend="log-entry.write-category">intern:internals.logging.Output#log-entry.write-category</link></para>	
			<para>Default: <code>false()</code></para>
		</doc:param>
		<doc:param name="log-entry.write-postText">
			<para>siehe <link linkend="log-entry.write-postText">intern:internals.logging.Output#log-entry.write-postText</link></para>	
			<para>Default: <code>false()</code></para>
		</doc:param>
	</doc:template>
	<xsl:template name="xsb:internals.Logging">
		<!-- Content -->
		<xsl:param name="log-entry.preText" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.ID" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.timeStamp" as="xs:dateTime?" select="current-dateTime()" required="no"/>
		<xsl:param name="log-entry.processedFile" as="xs:string?" select="document-uri($_internals.root-node)" required="no"/>
		<xsl:param name="log-entry.level" as="xs:string?" required="no">ALL</xsl:param>
		<xsl:param name="log-entry.text" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.category" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.postText" as="xs:string?" required="no"/>
		<!-- Formatierung -->
		<xsl:param name="log-entry.linebreak-string" as="xs:string?" select="$internals.logging.linebreak-string" required="no"/>
		<!-- Ausgabemedium -->
		<xsl:param name="log-entry.write-to-console" as="xs:boolean" select="$_internals.logging.write-to-console" required="no"/>
		<xsl:param name="log-entry.write-to-file" as="xs:boolean" select="$_internals.logging.write-to-file" required="no"/>
		<xsl:param name="log-entry.write-to-file-as-comment" as="xs:boolean" select="$_internals.logging.write-to-file-as-comment" required="no"/>
		<xsl:param name="log-entry.write-to-file-as-element" as="xs:boolean" select="$_internals.logging.write-to-file-as-element" required="no"/>
		<xsl:param name="log-entry.write-to-file-as-html" as="xs:boolean" select="$_internals.logging.write-to-file-as-html" required="no"/>
		<xsl:param name="log-entry.write-to-file-as-text" as="xs:boolean" select="$_internals.logging.write-to-file-as-text" required="no"/>
		<!-- Steuerung der auzugebenden Elemente -->
		<xsl:param name="log-entry.write-preText" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="log-entry.write-ID" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="log-entry.write-timeStamp" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="log-entry.write-processedFile" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="log-entry.write-level" as="xs:boolean" select="true()" required="no"/>
		<xsl:param name="log-entry.write-text" as="xs:boolean" select="true()" required="no"/>
		<xsl:param name="log-entry.write-category" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="log-entry.write-postText" as="xs:boolean" select="false()" required="no"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<xsl:if test="xsb:logging-level($log-entry.level) ge $_internals.logging-level">
			<xsl:call-template name="intern:internals.logging.Output">
				<!-- Content -->
				<xsl:with-param name="log-entry.preText" select="$log-entry.preText"/>
				<xsl:with-param name="log-entry.ID" select="$log-entry.ID"/>
				<xsl:with-param name="log-entry.timeStamp" select="$log-entry.timeStamp"/>
				<xsl:with-param name="log-entry.processedFile" select="$log-entry.processedFile"/>
				<xsl:with-param name="log-entry.level" select="$log-entry.level"/>
				<xsl:with-param name="log-entry.text" select="$log-entry.text"/>
				<xsl:with-param name="log-entry.category" select="$log-entry.category"/>
				<xsl:with-param name="log-entry.postText" select="$log-entry.postText"/>
				<!-- Formatierung -->
				<xsl:with-param name="log-entry.linebreak-string" select="$log-entry.linebreak-string"/>
				<!-- Ausgabemedium -->
				<xsl:with-param name="log-entry.write-to-console" select="$log-entry.write-to-console"/>
				<xsl:with-param name="log-entry.write-to-file" select="$log-entry.write-to-file"/>
				<xsl:with-param name="log-entry.write-to-file-as-comment" select="$log-entry.write-to-file-as-comment"/>
				<xsl:with-param name="log-entry.write-to-file-as-element" select="$log-entry.write-to-file-as-element"/>
				<xsl:with-param name="log-entry.write-to-file-as-html" select="$log-entry.write-to-file-as-html"/>
				<xsl:with-param name="log-entry.write-to-file-as-text" select="$log-entry.write-to-file-as-text"/>
				<!-- Steuerung der auzugebenden Elemente -->
				<xsl:with-param name="log-entry.write-preText" select="$log-entry.write-preText"/>
				<xsl:with-param name="log-entry.write-ID" select="$log-entry.write-ID"/>
				<xsl:with-param name="log-entry.write-timeStamp" select="$log-entry.write-timeStamp"/>
				<xsl:with-param name="log-entry.write-processedFile" select="$log-entry.write-processedFile"/>
				<xsl:with-param name="log-entry.write-level" select="$log-entry.write-level"/>
				<xsl:with-param name="log-entry.write-text" select="$log-entry.write-text"/>
				<xsl:with-param name="log-entry.write-category" select="$log-entry.write-category"/>
				<xsl:with-param name="log-entry.write-postText" select="$log-entry.write-postText"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:internals.Error     __________ -->
	<doc:template>
		<para xml:id="internals.Error">Dieses Template gibt eine einfache Fehlermeldung aus. Ausgabeart und -ziel 
			werden über die Stylesheet-Parameter bestimmt, wenn keine expliziten Einstellungen übergeben 
			werden.</para>
		<para>Es ist ein Wrapper mit sinvollen Vorgabewerten für das Template 
			<link linkend="internals.Logging"><function>xsb:internals.Logging</function></link>.</para>
		<para>Außerdem sorgt es dafür, dass bei Fehlern der Stufen <code>ERROR</code> (wenn mit <code>$internals.errors.die-on-critical-errors</code> erlaubt) und <code>FATAL</code>
			die Verarbeitung des Stylesheets abgebrochen wird.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
		<doc:param name="message"><para>Fehlermeldung</para></doc:param>
		<doc:param name="level"><para>Level der Fehlermeldung. In Anlehnung an <code>Log4j</code> werden per Vorgabe die Stufen 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>« 
			(in aufsteigender Reihenfolge der Dringlichkeit) verwendet.</para>
			<para>Default: »<code>ALL</code>«.</para></doc:param>
		<doc:param name="caller"><para>Aufrufende(s) Funktion/Template, z.B. <function>xsb:get-context-as-string()</function></para></doc:param>
		<doc:param name="show-context"><para>Falls <code>true()</code>, wird zum Kontextkonten der Kontext angezeigt. 
			<emphasis role="bold">Achtung!</emphasis> Das schlägt fehl, wenn es keinen Kontextknoten gibt, z.B. innerhalb von Funktionen oder innerhalb 
			von <function>xsl:for-each</function>-Schleifen über dokumentenexterne Sequenzen. Deshalb gibt es auch ein Template 
			<link linkend="internals.FunctionError"><function>xsb:internals.FunctionError</function></link>, das dieses Problem umgeht.</para></doc:param>
		<doc:param name="write-to-file"><para>Falls <function>true()</function>, wird die Ausgabe in die Datei geschrieben. 
			Standardwert: <code>$_internals.logging.write-to-file</code>. In bestimmten Umgebungen, z.B. innerhalb einer Funktion, 
			darf das Template keinen Rückgabewert liefern (siehe deshalb auch <function><link linkend="internals.FunctionError">xsb:internals.FunctionError</link></function>). 
			Über diesen Parameter kan der stylesheet-weite Standardwert überschrieben werden.</para></doc:param>
	</doc:template>
	<xsl:template name="xsb:internals.Error">
		<xsl:param name="message" as="xs:string?" required="no"/>
		<xsl:param name="level" as="xs:string?" required="no">ALL</xsl:param>
		<xsl:param name="caller" as="xs:string?" required="no"/>
		<xsl:param name="show-context" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="write-to-file" as="xs:boolean" select="$_internals.logging.write-to-file" required="no"/>
		<!--  -->
		<xsl:variable name="_level" as="xs:string" 
			select="xsb:return-default-if-empty(
					upper-case(normalize-space($level)),
					'ALL'
				)"/>
		<xsl:call-template name="xsb:internals.Logging">
			<!-- Content -->
			<xsl:with-param name="log-entry.preText" as="xs:string?">
				<xsl:sequence select="concat(
						intern:render-level-to-pretext($_level),
						if ($show-context) then concat(intern:render-context-and-parent-as-string(.), ': ') else ('')
					)"/>
			</xsl:with-param>
			<xsl:with-param name="log-entry.level" as="xs:string" select="$level"/>
			<xsl:with-param name="log-entry.text" as="xs:string">
				<xsl:sequence select="concat( (if (normalize-space($caller)) then concat ('[', $caller, '] ' ) else '') , $message)"/>
			</xsl:with-param>
			<!-- Ausgabemedium -->
			<xsl:with-param name="log-entry.write-to-file" as="xs:boolean" select="$write-to-file"/>
			<!-- Steuerung der auzugebenden Elemente -->
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
		</xsl:call-template>
		<xsl:if test="(xsb:lax-string-compare($_level, 'ERROR' ) and $_internals.errors.die-on-critical-errors) or xsb:lax-string-compare($_level, 'FATAL' )">
			<xsl:message terminate="yes" intern:solved="CheckXSLMessage">Verarbeitung abgebrochen</xsl:message>
		</xsl:if>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:internals.FunctionError     __________ -->
	<doc:template>
		<para xml:id="internals.FunctionError">Dieses Template gibt eine einfache Fehlermeldung aus. Es ist ein Wrapper für 
			<function>xsb:internals.Error</function>, der die Rückgabe von Werten durch das Template unterbindet (was innerhalb von Funktionen
			in der Regel unerwünscht ist und ggfs. zu Fehlern führen kann).</para>
		<para><emphasis role="bold">Achtung!</emphasis> Dadurch werden keine Meldungen (als Kommentar, Text, HTML, XML) in Ausgabedateien geschrieben!</para>
		<revhistory>
			<revision>
				<revnumber>0.59</revnumber>
				<date>2009-10-26</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
		<doc:param name="message"><para>Fehlermeldung</para></doc:param>
		<doc:param name="level"><para>Level der Fehlermeldung. In Anlehnung an <code>Log4j</code> werden per Vorgabe die Stufen 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>«
			(in aufsteigender Reihenfolge der Dringlichkeit) verwendet.</para>
			<para>Default: »<code>ALL</code>«.</para></doc:param>
		<doc:param name="caller"><para>Aufrufende(s) Funktion/Template, z.B. <function>xsb:get-context-as-string()</function></para></doc:param>
	</doc:template>
	<xsl:template name="xsb:internals.FunctionError">
		<xsl:param name="message" as="xs:string?" required="no"/>
		<xsl:param name="level" as="xs:string?" required="no">ALL</xsl:param>
		<xsl:param name="caller" as="xs:string?" required="no"/>
		<!--  -->
		<xsl:variable name="_level" as="xs:string" 
			select="xsb:return-default-if-empty(
			upper-case(normalize-space($level)),
			'ALL'
			)"/>
		<xsl:call-template name="xsb:internals.Error">
			<xsl:with-param name="caller" select="$caller"/>
			<xsl:with-param name="level" select="$level"/>
			<xsl:with-param name="message" select="$message"/>
			<xsl:with-param name="show-context" select="false()"/>
			<xsl:with-param name="write-to-file" select="false()"/>
		</xsl:call-template>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.FatalError     __________ -->
	<doc:template>
		<para xml:id="internals.FatalError">Dieses Template gibt eine Fehlermeldung bei Fehlern in der Logik der XSL-SB aus. Da das Ausführungsverhalten
			in solchen Situationen nicht vorhersehbar ist, wird die Verarbeitung abgebrochen.</para>
		<para>Dieses Template ist ein Wrapper für <function>xsb:internals.Error</function>, der die Rückgabe von Werten durch das Template unterbindet
			(was innerhalb von Funktionen in der Regel unerwünscht ist und ggfs. zu Fehlern führen kann).</para>
		<para><emphasis role="bold">Achtung!</emphasis> Dadurch werden keine Meldungen (als Kommentar, Text, HTML, XML) in Ausgabedateien geschrieben!</para>
		<revhistory>
			<revision>
				<revnumber>0.2.35</revnumber>
				<date>2011-06-26</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
		<doc:param name="errorID"><para>Fehler-Codenummer</para></doc:param>
		<doc:param name="caller"><para>Aufrufende(s) Funktion/Template, z.B. <function>xsb:get-context-as-string()</function></para></doc:param>
	</doc:template>
	<xsl:template name="intern:internals.FatalError">
		<xsl:param name="errorID" as="xs:string?" required="yes"/>
		<xsl:param name="caller" as="xs:string?" required="yes"/>
		<!--  -->
		<xsl:call-template name="xsb:internals.Error">
			<xsl:with-param name="caller" select="$caller"/>
			<xsl:with-param name="level" select=" 'ERROR' "/>
			<xsl:with-param name="message">Uups, das hätte nicht passieren dürfen :-(. Fataler Fehler innerhalb der XSLT-SB, Verarbeitung wurde abgebrochen (<xsl:value-of select="$errorID"/>)</xsl:with-param>
			<xsl:with-param name="show-context" select="false()"/>
			<xsl:with-param name="write-to-file" select="false()"/>
		</xsl:call-template>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:internals.MakeHeader     __________ -->
	<doc:template>
		<para xml:id="internals.MakeHeader">Dieses Template erzeugt bei der Ausgabe in eine Datei den Dateikopf, 
			z.B. das Wurzelelement in XML oder Wurzel und Head in HTML.</para>
		<para>Genaugenommen verteilt das Template nur entsprechend des Ausgabeformates auf Untertemplates 
			wie <link linkend="internals.logging.MakeHeader.element"><function>intern:internals.logging.MakeHeader.element</function></link> 
			und <link linkend="internals.logging.MakeHeader.html"><function>intern:internals.logging.MakeHeader.html</function></link>.</para>
		<revhistory>
			<revision>
				<revnumber>0.139</revnumber>
				<date>2011-04-24</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:template>
	<xsl:template name="xsb:internals.MakeHeader">
		<xsl:if test="$_internals.logging.write-to-file">
			<xsl:choose>
				<xsl:when test="$_internals.logging.write-to-file-as-element">
					<xsl:call-template name="intern:internals.logging.MakeHeader.element"/>
				</xsl:when>
				<xsl:when test="$_internals.logging.write-to-file-as-html">
					<xsl:call-template name="intern:internals.logging.MakeHeader.html"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:call-template name="xsb:internals.Log-system-properties"/>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:internals.MakeFooter     __________ -->
	<doc:template>
		<para xml:id="internals.MakeFooter">Dieses Template erzeugt bei der Ausgabe in eine Datei den Fuß, z.B. das schließende HTML-Tag oder XML-Element.</para>
		<para>Genaugenommen verteilt das Template nur entsprechend des Ausgabeformates auf Untertemplates 
			wie <link linkend="internals.logging.MakeFooter.element"><function>intern:internals.logging.MakeFooter.element</function></link> 
			und <link linkend="internals.logging.MakeFooter.html"><function>intern:internals.logging.MakeFooter.html</function></link>.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umformatieren überschrieben werden.</para>
		<revhistory>
			<revision>
				<revnumber>0.139</revnumber>
				<date>2011-04-24</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:template>
	<xsl:template name="xsb:internals.MakeFooter">
		<xsl:if test="$_internals.logging.write-to-file">
			<xsl:choose>
				<xsl:when test="$_internals.logging.write-to-file-as-element">
					<xsl:call-template name="intern:internals.logging.MakeFooter.element"/>
				</xsl:when>
				<xsl:when test="$_internals.logging.write-to-file-as-html">
					<xsl:call-template name="intern:internals.logging.MakeFooter.html"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:internals.Log-system-properties     __________ -->
	<doc:template>
		<doc:param name="logging-level">Logging-Level, mit dem die Ausgabe erfolgt. Default: "DEBUG"</doc:param>
		<para xml:id="internals.Log-system-properties">Dieses Template gibt die Werte der Funktion 
			<function>system-property()</function> für die im XSLT-Standard vorgegebenen Parameter 
			vgl. <ulink href="http://www.w3.org/TR/xslt20/#function-system-property">http://www.w3.org/TR/xslt20/#function-system-property</ulink> 
			aus.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:template>
	<xsl:template name="xsb:internals.Log-system-properties">
		<xsl:param name="logging-level" as="xs:string" required="no">DEBUG</xsl:param>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">Laufzeitumgebung:</xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">Datei: <xsl:sequence select="tokenize(base-uri(), '[/\\]')[last()]"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">current-date(): <xsl:sequence select="current-date()"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">current-time(): <xsl:sequence select="current-time()"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">os.name: <xsl:sequence select="system-property( 'os.name' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">os.version: <xsl:sequence select="system-property( 'os.version' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:version: <xsl:sequence select="system-property( 'xsl:version' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
			<xsl:with-param name="log-entry.text">xsl:vendor: <xsl:sequence select="system-property( 'xsl:vendor' )"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:vendor-url: <xsl:sequence select="system-property( 'xsl:vendor-url' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:product-name: <xsl:sequence select="system-property( 'xsl:product-name' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:product-version: <xsl:sequence select="system-property( 'xsl:product-version' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:is-schema-aware: <xsl:sequence select="system-property( 'xsl:is-schema-aware' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:supports-serialization: <xsl:sequence select="system-property( 'xsl:supports-serialization' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsl:supports-backwards-compatibility: <xsl:sequence select="system-property( 'xsl:supports-backwards-compatibility' )"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsb:java-available: <xsl:sequence select="xsb:java-available()"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
		<xsl:call-template name="xsb:internals.Logging">
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
			<xsl:with-param name="log-entry.text">xsb:vendor-hash: <xsl:sequence select="xsb:current-vendor-hash()"/></xsl:with-param>
			<xsl:with-param name="log-entry.level" select="$logging-level"/>
		</xsl:call-template>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.ProvisionalError     __________ -->
	<doc:template>
		<para xml:id="internals.ProvisionalError">Zu Beginn der Verarbeitung von <code>internals.xsl</code>
			(und damit von allen Stylesheets, die <code>internals.xsl</code> einbinden), sind ein paar 
			Parameter für das Logging noch nicht gesetzt. Um trotzdem eine Fehlermeldung zu ermöglichen
			(beispielsweise bei der Prüfung von Stylesheet-Parametern), wird im diesen Template eine Fehlermeldung
			unter Verzicht aus betroffene Parameter auf der Konsole ausgegeben.</para>
		<para>Das Template ist ein Wrapper für das Template <link linkend="internals.Logging"><function>xsb:internals.Logging</function></link> 
			und hat die selbe Signatur wie <function><link linkend="internals.Error">xsb:internals.Error</link></function>.</para>
		<para><emphasis role="bold">Achtung!</emphasis> Im Unterschied zu <function>xsb:internals.Error</function> wird bei ERROR in jedem Fall abgebrochen, 
			d.h. der Parameter <code>$internals.errors.die-on-critical-errors</code> beinflusst dieses Template nicht.</para>
		<revhistory>
			<revision>
				<revnumber>0.60</revnumber>
				<date>2009-11-01</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
		<doc:param name="message"><para>siehe <link linkend="internals.Error"><function>xsb:internals.Error</function></link></para></doc:param>
		<doc:param name="level"><para>siehe <link linkend="internals.Error"><function>xsb:internals.Error</function></link></para></doc:param>
		<doc:param name="caller"><para>siehe <link linkend="internals.Error"><function>xsb:internals.Error</function></link></para></doc:param>
		<doc:param name="show-context"><para>siehe <link linkend="internals.Error"><function>xsb:internals.Error</function></link></para></doc:param>
		<doc:param name="write-to-file">
			<para>siehe <link linkend="internals.Error"><function>xsb:internals.Error</function></link></para>
			<para><emphasis role="bold">Achtung!</emphasis> Dieser Parameter wird nur empfangen, um die Signatur von <function>xsb:internals.Error</function>
			zu erhalten, er wird aber nicht ausgewertet, d.h. es wird nie in die Ausgabedatei geschrieben.</para>
		</doc:param>
	</doc:template>
	<xsl:template name="intern:internals.ProvisionalError">
		<xsl:param name="message" as="xs:string?" required="no"/>
		<xsl:param name="level" as="xs:string?" required="no">ALL</xsl:param>
		<xsl:param name="caller" as="xs:string?" required="no"/>
		<xsl:param name="show-context" as="xs:boolean" select="false()" required="no"/>
		<xsl:param name="write-to-file" as="xs:boolean" select="false()" required="no"/>
		<!--  -->
		<xsl:variable name="_level" as="xs:string" 
			select="xsb:return-default-if-empty(
			upper-case(normalize-space($level)),
			'ALL'
			)"/>
		<xsl:call-template name="xsb:internals.Logging">
			<!-- Content -->
			<xsl:with-param name="log-entry.preText" as="xs:string?">
				<xsl:sequence select="intern:render-level-to-pretext($_level)"/>
				<xsl:if test="$show-context">
					<xsl:sequence select="intern:render-context-and-parent-as-string(.)"/>
					<xsl:text>: </xsl:text>
				</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="log-entry.level" as="xs:string" select="$level"/>
			<xsl:with-param name="log-entry.text" as="xs:string">
				<xsl:sequence select="concat( (if (normalize-space($caller)) then concat ('[', $caller, '] ' ) else '') , $message)"/>
			</xsl:with-param>
			<!-- Ausgabemedium -->
			<xsl:with-param name="log-entry.write-to-console" as="xs:boolean" select="true()"/>
			<xsl:with-param name="log-entry.write-to-file" as="xs:boolean" select="false()"/>
			<xsl:with-param name="log-entry.write-to-file-as-comment" as="xs:boolean" select="false()"/>
			<xsl:with-param name="log-entry.write-to-file-as-element" as="xs:boolean" select="false()"/>
			<xsl:with-param name="log-entry.write-to-file-as-html" as="xs:boolean" select="false()"/>
			<xsl:with-param name="log-entry.write-to-file-as-text" as="xs:boolean" select="false()"/>
			<!-- Steuerung der auzugebenden Elemente -->
			<xsl:with-param name="log-entry.write-preText" select="true()"/>
		</xsl:call-template>
		<xsl:if test="xsb:lax-string-compare($_level, 'ERROR' ) or xsb:lax-string-compare($_level, 'FATAL' )">
			<xsl:message terminate="yes" intern:solved="CheckXSLMessage">Verarbeitung abgebrochen</xsl:message>
		</xsl:if>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!--  -->
	<!-- ====================     Funktionen     ==================== -->
	<!--  -->
	<!--  -->
	<!-- __________     intern:render-context-and-parent-as-string()     __________ -->
	<doc:function>
		<doc:param name="context"><para>Kontextknoten vom Typ <code>node()</code>, kann also vom Typ <code>element()</code>, <code>attribute()</code>, <code>text()</code>, <code>comment()</code> usw. sein</para></doc:param>
		<para xml:id="render-context-and-parent-as-string">Diese Funktion erzeugt aus dem Kontext eines Knotens und dessen Elternknoten einen String in Form eines XPath-Ausdruckes, der diesen Knoten beschreibt. 
			Kann z.B. zur Erläuterung bei Fehlermeldungen eingesetzt werden.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="intern:render-context-and-parent-as-string" as="xs:string">
		<xsl:param name="context" as="node()?"/>
		<xsl:variable name="temp" as="xs:string*">
			<xsl:choose>
				<!-- leer -->
				<xsl:when test="not($context/self::node())"/>
				<!-- mit Eltern -->
				<xsl:when test="$context/self::node()/..">
					<xsl:text>//</xsl:text>
					<xsl:sequence select="xsb:render-context-as-string($context/..)"/>
					<xsl:text>/</xsl:text>
					<xsl:sequence select="xsb:render-context-as-string($context/.)"/>
				</xsl:when>
				<!-- ohne Eltern -->
				<xsl:otherwise>
					<xsl:text>//</xsl:text>
					<xsl:sequence select="xsb:render-context-as-string($context)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:sequence select="string-join($temp, '' )"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:render-context-as-string()     __________ -->
	<doc:function>
		<doc:param name="context"><para>Kontextknoten vom Typ <code>node()</code>, kann also vom Typ <code>element()</code>, <code>attribute()</code>, <code>text()</code>, <code>comment()</code> usw. sein</para></doc:param>
		<para xml:id="render-context-as-string">Diese Funktion erzeugt aus dem Kontext eines Knotens einen String in Form eines XPath-Ausdruckes, der diesen Knoten beschreibt. 
			Kann z.B. zur Erläuterung bei Fehlermeldungen eingesetzt werden.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:render-context-as-string" as="xs:string">
		<xsl:param name="context" as="node()?"/>
		<xsl:variable name="kind" as="xs:string" select="xsb:node-kind($context)"/>
		<xsl:variable name="temp" as="xs:string*">
			<xsl:choose>
				<xsl:when test="$kind = '' "/>
				<xsl:when test="$kind = 'document-node' ">document-node()</xsl:when>
				<!-- Element -->
				<xsl:when test="$kind = 'element' ">
					<xsl:sequence select="name($context)"/>
					<xsl:if test="$context/@*">
						<xsl:variable name="mit-klammern" as="xs:boolean" select="if ($context/@*[2]) then true() else false()"/>
						<xsl:text>[</xsl:text>
						<xsl:for-each select="$context/@*">
							<xsl:if test="$mit-klammern">(</xsl:if>
							<xsl:text>@</xsl:text>
							<xsl:sequence select="name(.)"/>
							<xsl:text>="</xsl:text>
							<xsl:sequence select="."/>
							<xsl:text>"</xsl:text>
							<xsl:if test="$mit-klammern">)</xsl:if>
							<xsl:if test="position() lt last()">
								<xsl:text> and </xsl:text>
							</xsl:if>
						</xsl:for-each>
						<xsl:text>]</xsl:text>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$kind = 'text' ">text()</xsl:when>
				<xsl:when test="$kind = 'attribute' ">@<xsl:sequence select="name($context/.)"/>[. =&quot;<xsl:sequence select="$context"/>&quot;]</xsl:when>
				<xsl:when test="$kind = 'comment' ">comment()</xsl:when>
				<xsl:when test="$kind = 'processing-instruction' ">processing-instruction()</xsl:when>
				<xsl:when test="$kind = 'namespace' ">namespace::<xsl:sequence select="local-name($context)"/></xsl:when>
				<!-- das dürfte eigentlich _nie_ passieren -->
				<xsl:otherwise>
					<xsl:call-template name="xsb:internals.FunctionError">
						<xsl:with-param name="caller">xsb:render-context-as-string()</xsl:with-param>
						<xsl:with-param name="level">ERROR</xsl:with-param>
						<xsl:with-param name="message">keine Anzeigemöglichkeit für Kontext-Art <xsl:value-of select="$kind"/></xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:sequence select="string-join($temp, '')"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:parse-string-to-boolean     __________ -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<doc:param name="warn-if-wrong-input"><para>(Boolean) Erzeugt eine Fehlermeldung, wenn der eingegebene String 
			nicht in der Liste der gültigen Werte enthalten ist.</para></doc:param>
		<para xml:id="parse-string-to-boolean">Diese Funktion wandelt eine String-Eingabe in einen Boolean-Wert um. 
			Sie kennt dabei mehr Begriffe als <function>boolean()</function>, z.B. »<code>ja</code>«/»<code>nein</code>«.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:parse-string-to-boolean" as="xs:boolean">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:param name="warn-if-wrong-input" as="xs:boolean"/>
		<xsl:variable name="temp" as="xs:string?" select="normalize-space(lower-case($input))"/>
		<xsl:choose>
			<xsl:when test="string($temp)='0' "><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="string($temp)='1' "><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="string($temp)='false' "><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="string($temp)='true' "><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="string($temp)='no' "><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="string($temp)='yes' "><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="string($temp)='nein' "><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="string($temp)='ja' "><xsl:sequence select="true()"/></xsl:when>
			<xsl:when test="string($temp)='falsch' "><xsl:sequence select="false()"/></xsl:when>
			<xsl:when test="string($temp)='wahr' "><xsl:sequence select="true()"/></xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="false()"/>
				<xsl:if test="$warn-if-wrong-input">
					<xsl:call-template name="xsb:internals.FunctionError">
						<xsl:with-param name="caller">xsb:parse-string-to-boolean</xsl:with-param>
						<xsl:with-param name="message">Ungültiger Wert für "$input" (»<xsl:sequence select="$input"/>«) übergeben, false() als Ergebnis zurückgegeben.</xsl:with-param>
						<xsl:with-param name="level">WARN</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!--  -->
	<doc:function>
		<doc:param name="input"><para>Eingabe (String)</para></doc:param>
		<para xml:id="parse-string-to-boolean_shortcut">Shortcut für <function><link linkend="parse-string-to-boolean">xsb:parse-string-to-boolean($input, true())</link></function>.</para>
		<revhistory>
			<revision>
				<revnumber>0.36</revnumber>
				<date>2009-08-02</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:parse-string-to-boolean" as="xs:boolean">
		<xsl:param name="input" as="xs:string?"/>
		<xsl:sequence select="xsb:parse-string-to-boolean($input, true())"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     intern:render-level-to-pretext     __________ -->
	<doc:function>
		<doc:param name="level"><para>Eingabe (String)</para></doc:param>
		<para xml:id="render-level-to-pretext">Erzeugt zu den verbalen Fehlerwerten 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>«
			einen String, der bei <code><link linkend="internals.Error">xsb:internals.Error</link></code> und verwandten Templates als <code>preText</code> verwendet werden kann.</para>
		<para>Wird ein ungültiger Wert übergeben, wird der Wert für ALL gewählt.</para>
		<revhistory>
			<revision>
				<revnumber>0.60</revnumber>
				<date>2009-11-01</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="intern:render-level-to-pretext" as="xs:string">
		<xsl:param name="level" as="xs:string?"/>
		<xsl:choose>
			<xsl:when test="$level = 'ALL' "><xsl:sequence select=" '    ' "/></xsl:when>
			<xsl:when test="$level = 'TRACE' "><xsl:sequence select=" '    ' "/></xsl:when>
			<xsl:when test="$level = 'DEBUG' "><xsl:sequence select=" '    ' "/></xsl:when>
			<xsl:when test="$level = 'INFO' "><xsl:sequence select=" '' "/></xsl:when>
			<xsl:when test="$level = 'WARN' "><xsl:sequence select=" '---- ' "/></xsl:when>
			<xsl:when test="$level = 'ERROR' "><xsl:sequence select=" '#### ' "/></xsl:when>
			<xsl:when test="$level = 'FATAL' "><xsl:sequence select=" '###### ' "/></xsl:when>
			<xsl:otherwise><xsl:sequence select=" '    ' "/></xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:is     __________ -->
	<doc:function>
		<doc:param name="input1"><para>Eingabe (ohne Typ)</para></doc:param>
		<doc:param name="input2"><para>Eingabe (ohne Typ)</para></doc:param>
		<para xml:id="is">Diese Funktion vergleicht zwei beliebig getypte Werte und gibt bei Idendität <code>true()</code> zurück, d.h. der Vergleich
			ist eine Kombination aus <function>eq</function> und <function>deep-equal()</function> mit höherer Empfindlichkeit und einigen Sonderfällen.</para>
		<para>Im Unterschied zum XPath-Operator <function>is</function> können auch <code>atomic values</code> verglichen werden.</para>
		<para>Sind die Eingabewerte nicht vom gleichen Typ, ist das Ergebnis <code>false()</code>.</para>
		<para>Werden <code>-0.0e0</code> und <code>+0.0e0</code> verglichen, und unterstützt der jeweilie Typ diesen Unterschied, ist das Ergebnis <code>false()</code>.</para>
		<para>Werden <code>NaN</code> und <code>NaN</code> verglichen, ist das Ergebnis <code>true()</code>.</para>
		<para>Werden zwei Leersequenzen verglichen, ist das Ergebnis <code>true()</code>.</para>
		<revhistory>
			<revision>
				<revnumber>0.2.37</revnumber>
				<date>2011-06-26</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>Bugfix für "NaN" unter AltovaXML (bis einschließlich 2011 sp 3) eingefügt</para>
				</revdescription>
			</revision>
			<revision>
				<revnumber>0.2.34</revnumber>
				<date>2011-06-26</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>Unterscheidung von -0.0e0 und +0.0e0 eingefügt</para>
				</revdescription>
			</revision>
			<revision>
				<revnumber>0.139</revnumber>
				<date>2011-04-24</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>explizite Behandlung für Leersequenzen eingefügt</para>
				</revdescription>
			</revision>
			<revision>
				<revnumber>0.61</revnumber>
				<date>2009-11-16</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:is" as="xs:boolean">
		<!-- ungetypt, weil die Eingabe von beliebigem Typ sein darf -->
		<xsl:param name="input1" intern:solved="MissingTypes"/>
		<xsl:param name="input2" intern:solved="MissingTypes"/>
		<xsl:choose>
			<!-- Operationen mit Leersequenzen sind immer falsch, deshalb muss auf Leersequenz extra geprüft werden -->
			<xsl:when test="empty($input1) and empty($input2)">
				<xsl:sequence select="true()"/>
			</xsl:when>
			<!-- node() -->
			<xsl:when test="($input1 instance of node()) and ($input2 instance of node())">
				<xsl:sequence select="$input1 is $input2"/>
			</xsl:when>
			<xsl:when test="($input1 instance of xs:anyAtomicType) and ($input2 instance of xs:anyAtomicType)">
				<xsl:choose>
					<xsl:when test="(xsb:type-annotation($input1) ne xsb:type-annotation($input2))">
						<xsl:sequence select="false()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- Sonderfall -0.0e0 vs. +0.0e0 -->
							<xsl:when test="($input1 castable as xs:double) and ($input2 castable as xs:double) and
											(xs:double($input1) eq 0) and (xs:double($input2) eq 0)">
								<xsl:sequence select="string($input1) eq string($input2)"/>
							</xsl:when>
							<!-- catch für buggy AltovaXML (bis einschließlich 2011 sp 3) -->
							<xsl:when test="(string($input1) eq 'NaN') and (string($input2) eq 'NaN')">
								<xsl:sequence select="true()"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- deep-equal() statt eq, damit NaN, NaN zu true() wird -->
								<xsl:sequence select="deep-equal($input1, $input2)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="deep-equal($input1, $input2)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:node-kind     __________ -->
	<doc:function>
		<doc:param name="context"><para>Eingabeknoten</para></doc:param>
		<doc:param name="warn-if-wrong-input"><para>Erzeugt eine Fehlermeldung, wenn für den eingegebenen 
			Knoten keine gültige Art ermittelt werden kann. Da die Tests vollständig sind, dürfet dieser Fehler nie auftreten.</para></doc:param>
		<para xml:id="node-kind">Diese Funktion ermittelt die Art eines <code>node()</code>, d.h. sie gibt je nach übergebenen Knoten einen der Werte 
			»<code>document-node</code>«, »<code>element</code>«, »<code>attribute</code>«, »<code>text</code>«, 
			»<code>comment</code>«, »<code>processing-instruction</code>« oder »<code>namespace</code>« zurück. 
			Schlagen all Versuche zur Ermittlung fehl, wird der Wert <code>#undefined</code> zurückgegeben (Mir ist kein entsprechender Input-node() bekannt).</para>
		<para>Diese Funktion ist eine Implementierung des <function>dm:node-kind</function>-Accessors aus dem <link xlink:href="http://www.w3.org/TR/xpath-datamodel/#dm-node-kind">XQuery 1.0 and XPath 2.0 Data Model (XDM)</link>.</para>
		<revhistory>
			<revision>
				<revnumber>0.61</revnumber>
				<date>2009-11-16</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:node-kind" as="xs:string">
		<xsl:param name="context" as="node()?"/>
		<xsl:param name="warn-if-wrong-input" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="not($context)"><xsl:sequence select=" '' "/></xsl:when>
			<xsl:when test="$context/self::document-node()">document-node</xsl:when>
			<xsl:when test="$context/self::element()">element</xsl:when>
			<xsl:when test="$context/self::attribute()">attribute</xsl:when>
			<xsl:when test="$context/self::text()">text</xsl:when>
			<xsl:when test="$context/self::comment()">comment</xsl:when>
			<xsl:when test="$context/self::processing-instruction()">processing-instruction</xsl:when>
			<xsl:when test="local-name($context)">namespace</xsl:when>
			<!-- das dürfte eigentlich _nie_ passieren -->
			<xsl:otherwise>
				<xsl:text>#undefined</xsl:text>
				<xsl:if test="$warn-if-wrong-input">
					<xsl:call-template name="xsb:internals.FunctionError">
						<xsl:with-param name="caller">xsb:node-kind</xsl:with-param>
						<xsl:with-param name="message">Ungültiger Wert für "$context" übergeben, "#undefined" als Ergebnis zurückgegeben.</xsl:with-param>
						<xsl:with-param name="level">ERROR</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!--  -->
	<doc:function>
		<doc:param name="context"><para>Eingabeknoten (ohne Typ)</para></doc:param>
		<para xml:id="node-kind_shortcut">Shortcut für <function><link linkend="node-kind">xsb:node-kind($context, true())</link></function></para>
		<revhistory>
			<revision>
				<revnumber>0.61</revnumber>
				<date>2009-11-16</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	s</doc:function>
	<xsl:function name="xsb:node-kind" as="xs:string">
		<xsl:param name="context" as="node()?"/>
		<xsl:sequence select="xsb:node-kind($context, true())"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:logging-level     __________ -->
	<doc:function>
		<doc:param name="verbal-logging-level"><para>Eingabeknoten (ohne Typ)</para></doc:param>
		<doc:param name="warn-if-wrong-input"><para>Erzeugt eine Fehlermeldung, wenn der eingegebenen String nicht 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>«
			ist.</para></doc:param>
		<para xml:id="logging-level">Diese Funktion wandelt die verbalen Logging-Level 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>«
			in korrspondierende Integer-Werte von 0 bis 6 um.</para>
		<para>Bei einer ungültigen Eingabe wird »4« (entspricht »<code>WARN</code>«) zurückgegeben.</para>
		<revhistory>
			<revision>
				<revnumber>0.114</revnumber>
				<date>2010-07-16</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:logging-level" as="xs:integer">
		<xsl:param name="verbal-logging-level" as="xs:string?"/>
		<xsl:param name="warn-if-wrong-input" as="xs:boolean"/>
		<xsl:variable name="temp" as="xs:integer?" select="index-of( ('ALL', 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'), concat('', $verbal-logging-level) )"/>
		<xsl:choose>
			<xsl:when test="$temp">
				<xsl:sequence select="$temp - 1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="4"/>
				<xsl:if test="$warn-if-wrong-input">
					<xsl:call-template name="xsb:internals.FunctionError">
						<xsl:with-param name="caller">xsb:logging-level</xsl:with-param>
						<xsl:with-param name="level">WARN</xsl:with-param>
						<xsl:with-param name="message">Ungültige Eingabe: »<xsl:sequence select="$verbal-logging-level"/>«, statt dessen »4« (entspricht »WARN«) zurückgegeben.</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:logging-level     __________ -->
	<doc:function>
		<doc:param name="verbal-logging-level"><para>Eingabeknoten (ohne Typ)</para></doc:param>
		<para xml:id="logging-level_shortcut">Shortcut für <function><link linkend="logging-level">xsb:logging-level($verbal-logging-level, true() )</link></function>.</para>
		<revhistory>
			<revision>
				<revnumber>0.114</revnumber>
				<date>2010-07-16</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:logging-level" as="xs:integer">
		<xsl:param name="verbal-logging-level" as="xs:string?"/>
		<xsl:sequence select="xsb:logging-level($verbal-logging-level, true())"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:vendor-hash     __________ -->
	<doc:function>
		<doc:param name="product-name"><para>Wert der entsprechenden System-Eigenschaft (String)</para></doc:param>
		<doc:param name="product-version"><para>Wert der entsprechenden System-Eigenschaft (String)</para></doc:param>
		<doc:param name="java-available"><para>Wert der entsprechenden System-Eigenschaft (Boolean)</para></doc:param>
		<doc:param name="is-schema-aware"><para>(Boolean)Wert der entsprechenden System-Eigenschaft
					(muss ggfs. von String umgewandelt werden, etwa mit xsb:parse-string-to-boolean())</para></doc:param>
		<doc:param name="warn-if-wrong-input"><para>Erzeugt eine Fehlermeldung, wenn der eingegebene String 
			nicht in der Liste der gültigen Werte enthalten ist. (Boolean)</para></doc:param>
		<para xml:id="vendor-hash">Diese Funktion ermittelt aus den übergebenen System-Parameter einen Hashwert, der z.B. für Vergleiche verwendet werden kann</para>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:vendor-hash" as="xs:string">
		<xsl:param name="product-name" as="xs:string?"/>
		<xsl:param name="product-version" as="xs:string?"/>
		<xsl:param name="java-available" as="xs:boolean"/>
		<xsl:param name="is-schema-aware" as="xs:boolean"/>
		<xsl:param name="warn-if-wrong-input" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="($product-name eq 'SAXON') and matches($product-version, '^PE 9.3')">Saxon-PE_9.3</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and matches($product-version, '^EE 9.3')">Saxon-EE_9.3</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and matches($product-version, '^HE 9.3')">Saxon-HE_9.3</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and matches($product-version, '^HE 9.4')">Saxon-HE_9.4</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and (matches($product-version, '^9.2') ) and $java-available">Saxon-PE_9.2</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and (matches($product-version, '^9.2') ) and not($java-available)">Saxon-HE_9.2</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and matches($product-version, '^EE9.2')">Saxon-EE_9.2</xsl:when>
			<xsl:when test="($product-name eq 'SAXON') and (matches($product-version, '^9.1') ) and not($is-schema-aware)">Saxon-B_9.1</xsl:when>
			<xsl:when test="($product-name eq 'Altova XSLT Engine') and ($product-version eq '2012 rel. 2') and ($java-available eq false() )">AltovaXML_CE_2012.2</xsl:when>
			<xsl:when test="($product-name eq 'Altova XSLT Engine') and ($product-version eq '2012 sp1') and ($java-available eq false() )">AltovaXML_CE_2012.sp1</xsl:when>
			<xsl:when test="($product-name eq 'Altova XSLT Engine') and ($product-version eq '2011 rel. 2 sp1') and ($java-available eq false() )">AltovaXML_CE_2011.2sp1</xsl:when>
			<xsl:when test="($product-name eq 'Altova XSLT Engine') and ($product-version eq '2010 rel. 3 sp1') and ($java-available eq true() )">AltovaXML_CE_2010.3sp1</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select=" 'FEHLER' "/>
				<xsl:if test="$warn-if-wrong-input">
					<xsl:call-template name="xsb:internals.FunctionError">
						<xsl:with-param name="caller">xsb:vendor-hash()</xsl:with-param>
						<xsl:with-param name="level">WARN</xsl:with-param>
						<xsl:with-param name="message">xsb:vendor-hash(<xsl:value-of select="concat('&quot;', $product-name, '&quot;, &quot;', $product-version, '&quot;, ', $java-available, '(), ', $is-schema-aware, '() )' ) "/>) konnte nicht ermittelt werden, "FEHLER" zurückgegeben</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<doc:function>
		<doc:param name="product-name"><para>Wert der entsprechenden System-Eigenschaft (String)</para></doc:param>
		<doc:param name="product-version"><para>Wert der entsprechenden System-Eigenschaft (String)</para></doc:param>
		<doc:param name="java-available"><para>Wert der entsprechenden System-Eigenschaft (Boolean)</para></doc:param>
		<doc:param name="is-schema-aware"><para>(Boolean)Wert der entsprechenden System-Eigenschaft
			(muss ggfs. von String umgewandelt werden, etwa mit xsb:parse-string-to-boolean())</para></doc:param>
		<doc:param name="warn-if-wrong-input"><para>Erzeugt eine Fehlermeldung, wenn der eingegebene String 
			nicht in der Liste der gültigen Werte enthalten ist. (Boolean)</para></doc:param>
		<para xml:id="vendor-hash_shortcut">Shortcut für <function><link linkend="vendor-hash">xsb:vendor-hash($product-name, $product-version, $java-available, true())</link></function>.</para>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:vendor-hash" as="xs:string">
		<xsl:param name="product-name" as="xs:string?"/>
		<xsl:param name="product-version" as="xs:string?"/>
		<xsl:param name="java-available" as="xs:boolean"/>
		<xsl:param name="is-schema-aware" as="xs:boolean"/>
		<xsl:sequence select="xsb:vendor-hash($product-name, $product-version, $java-available, $is-schema-aware, true() )"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:java-available     __________ -->
	<doc:function>
		<para xml:id="java-available">Diese Funktion ermittelt – zusammen mit der folgenden – ob Java auf dem ausführenden System zur Verfügung steht.</para>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:java-available" use-when="function-available('java-uri:new')" xmlns:java-uri="java:java.net.URI" intern:solved="MissingTests" as="xs:boolean">
		<xsl:sequence select="true()"/>
	</xsl:function>
	<doc:function>
		<para xml:id="java-available_2">Diese Funktion ermittelt – zusammen mit der vorhergehenden – ob Java auf dem ausführenden System zur Verfügung steht.</para>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:java-available" use-when="not(function-available('java-uri:new') )" xmlns:java-uri="java:java.net.URI" intern:solved="MissingTests" as="xs:boolean">
		<xsl:sequence select="false()"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:current-vendor-hash     __________ -->
	<doc:function>
		<para xml:id="current-vendor-hash">Diese Funktion ermittelt den Vendor-Hash für das aktuelle System.</para>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:current-vendor-hash" as="xs:string" intern:solved="MissingTests">
		<xsl:value-of select="xsb:vendor-hash(system-property( 'xsl:product-name' ), system-property( 'xsl:product-version' ), xsb:java-available(), xsb:parse-string-to-boolean(system-property( 'xsl:is-schema-aware' )) )"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:type-annotation     __________ -->
	<doc:function>
		<doc:param name="arg"><para>Eingabeknoten (ohne Typ)</para></doc:param>
		<doc:param name="warn-if-wrong-input"><para>Erzeugt eine Fehlermeldung, wenn der Typ nicht ermittelt werden kann.
			Da die Tests vollständig sind und zumindest <code>xs:untypedAtomic</code> immer das Ergebnis sein sollte, dürfet dieser Fehler nie auftreten.</para></doc:param>
		<para xml:id="type-annotation">ermittelt den Typ eines Atomic Values</para>
		<para>Dazu wird das Argument mit einer Reihe von <function>instance of …</function> geprüft. Geprüft werden diejenigen Typen, die ein Basic-XSLT-Prozessor
			laut XSLT-Standard unterstützen muss (vgl. <link xlink:href="http://www.w3.org/TR/xslt20/#built-in-types">3.13 Built-in Types</link>). Das sind
			<code>xs:double</code>, <code>xs:decimal</code>, <code>xs:integer</code>, <code>xs:float</code>, <code>xs:dateTime</code>, <code>xs:date</code>, 
			<code>xs:time</code>, <code>xs:boolean</code>, <code>xs:yearMonthDuration</code>, <code>xs:dayTimeDuration</code>, <code>xs:duration</code>, 
			<code>xs:string</code>, <code>xs:QName</code>, <code>xs:anyURI</code>, <code>xs:gYearMonth</code>, <code>xs:gMonthDay</code>, <code>xs:gYear</code>, 
			<code>xs:gMonth</code>, <code>xs:gDay</code>, <code>xs:base64Binary</code>, <code>xs:hexBinary</code>, <code>xs:untypedAtomic</code> und <code>xs:anyAtomicType</code>.</para>
		<para>Achtung: Die XSLT-Prozessor-Hersteller sind nicht verpflichtet, intern den jeweils »richtigen« Typ zu verwenden, $arg kann auch von einem beliebigen Subtyp sein
			(vgl. <link xlink:href="http://markmail.org/message/4duzqlie5chiizrv">hier</link>).</para>
		<revhistory>
			<revision>
				<revnumber>0.2.25</revnumber>
				<date>2011-05-29</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:type-annotation" as="xs:string">
		<xsl:param name="arg" as="xs:anyAtomicType"/>
		<xsl:param name="warn-if-wrong-input" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="$arg instance of xs:double">xs:double</xsl:when>
			<!-- Decimal + Subtype Integer -->
			<xsl:when test="$arg instance of xs:integer">xs:integer</xsl:when>
			<xsl:when test="$arg instance of xs:decimal">xs:decimal</xsl:when>
			<!--  -->
			<xsl:when test="$arg instance of xs:float">xs:float</xsl:when>
			<xsl:when test="$arg instance of xs:dateTime">xs:dateTime</xsl:when>
			<xsl:when test="$arg instance of xs:date">xs:date</xsl:when>
			<xsl:when test="$arg instance of xs:time">xs:time</xsl:when>
			<xsl:when test="$arg instance of xs:boolean">xs:boolean</xsl:when>
			<!-- Duration + Subtypes -->
			<xsl:when test="$arg instance of xs:yearMonthDuration">xs:yearMonthDuration</xsl:when>
			<xsl:when test="$arg instance of xs:dayTimeDuration">xs:dayTimeDuration</xsl:when>
			<xsl:when test="$arg instance of xs:duration">xs:duration</xsl:when>
			<!-- String (keine Subtypes bei Basic-XSLT-Prozessor) -->
			<xsl:when test="$arg instance of xs:string">xs:string</xsl:when>
			<!--  -->
			<xsl:when test="$arg instance of xs:QName">xs:QName</xsl:when>
			<xsl:when test="$arg instance of xs:anyURI">xs:anyURI</xsl:when>
			<xsl:when test="$arg instance of xs:gYearMonth">xs:gYearMonth</xsl:when>
			<xsl:when test="$arg instance of xs:gMonthDay">xs:gMonthDay</xsl:when>
			<xsl:when test="$arg instance of xs:gYear">xs:gYear</xsl:when>
			<xsl:when test="$arg instance of xs:gMonth">xs:gMonth</xsl:when>
			<xsl:when test="$arg instance of xs:gDay">xs:gDay</xsl:when>
			<xsl:when test="$arg instance of xs:base64Binary">xs:base64Binary</xsl:when>
			<xsl:when test="$arg instance of xs:hexBinary">xs:hexBinary</xsl:when>
			<xsl:when test="$arg instance of xs:untypedAtomic">xs:untypedAtomic</xsl:when>
			<xsl:when test="$arg instance of xs:anyAtomicType">xs:anyAtomicType</xsl:when>
			<xsl:otherwise>
				<!-- das ist dann wohl ein Programmierfehler -->
				<xsl:sequence select=" '#undefined' "/>
				<xsl:if test="$warn-if-wrong-input">
					<xsl:call-template name="xsb:internals.FunctionError">
						<xsl:with-param name="caller">xsb:type-annotation</xsl:with-param>
						<xsl:with-param name="message">Typ des Argumentes konnte nicht ermittelt werden, "#undefined" als Ergebnis zurückgegeben.</xsl:with-param>
						<xsl:with-param name="level">ERROR</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:type-annotation     __________ -->
	<doc:function>
		<doc:param name="arg"><para>Eingabeknoten (ohne Typ)</para></doc:param>
		<para xml:id="type-annotation_2">Shortcut für <function>xsb:type-annotation($arg, true() )</function></para>
		<revhistory>
			<revision>
				<revnumber>0.2.25</revnumber>
				<date>2011-05-29</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:type-annotation" as="xs:string">
		<xsl:param name="arg" as="xs:anyAtomicType"/>
		<xsl:sequence select="xsb:type-annotation($arg, true() )"/>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!-- __________     xsb:cast     __________ -->
	<doc:function>
		<doc:param name="arg"><para>Eingabeknoten (ohne Typ)</para></doc:param>
		<doc:param name="as"><para>Typ, auf den gecastet werden soll</para></doc:param>
		<para xml:id="cast">wandelt einen Atomic Value beliebigen Types in einen Atomic Value mit Typ entsprechend dem Parameter "<code>as</code>" um</para>
		<para>Unterstützt werden diejenigen Typen, die ein Basic-XSLT-Prozessor laut XSLT-Standard unterstützen muss 
			(vgl. <link xlink:href="http://www.w3.org/TR/xslt20/#built-in-types">3.13 Built-in Types</link>):
			<code>xs:double</code>, <code>xs:decimal</code>, <code>xs:integer</code>, <code>xs:float</code>, <code>xs:dateTime</code>, <code>xs:date</code>, 
			<code>xs:time</code>, <code>xs:boolean</code>, <code>xs:yearMonthDuration</code>, <code>xs:dayTimeDuration</code>, <code>xs:duration</code>, 
			<code>xs:string</code>, <code>xs:QName</code>, <code>xs:anyURI</code>, <code>xs:gYearMonth</code>, <code>xs:gMonthDay</code>, <code>xs:gYear</code>, 
			<code>xs:gMonth</code>, <code>xs:gDay</code>, <code>xs:base64Binary</code>, <code>xs:hexBinary</code>, <code>xs:untypedAtomic</code> mit Ausnahme
			von <code>xs:anyAtomicType</code> (weil ein Cast dahin nicht möglich ist).</para>
		<para>Laut Standard kann nicht auf <code>xs:QName</code> gecastet werden, da dieser Cast ein statisches <emphasis role="bold">String Literal</emphasis>
			erfordert und deshalb nicht mit dynamisch zu evaluierenden Variablen bzw. Parametern funktioniert. Details siehe im XPath-Standard, 
			<link xlink:href="http://www.w3.org/TR/xpath20/#id-cast">Punkt 4.a.</link>, und 
			<link xlink:href="http://www.w3.org/TR/xpath20/#ERRXPTY0004">err:XPTY0004</link>.</para>
		<revhistory>
			<revision>
				<revnumber>0.2.25</revnumber>
				<date>2011-05-29</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="alpha">Status: alpha</para>
					<para>initiale Version</para>
				</revdescription>
			</revision>
		</revhistory>
	</doc:function>
	<xsl:function name="xsb:cast" intern:solved="MissingTests" as="xs:anyAtomicType"><!-- indirekte Tests erkennt Stylecheck (noch) nicht, Stf, 2011-05-29 -->
		<xsl:param name="arg" as="xs:anyAtomicType"/>
		<xsl:param name="as" as="xs:string"/>
		<xsl:choose>
			<xsl:when test="$as eq 'xs:double' "><xsl:sequence select="xs:double($arg)"/></xsl:when>
			<!-- Decimal + Subtype Integer -->
			<xsl:when test="$as eq 'xs:decimal' "><xsl:sequence select="xs:decimal($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:integer' "><xsl:sequence select="xs:integer($arg)"/></xsl:when>
			<!--  -->
			<xsl:when test="$as eq 'xs:float' "><xsl:sequence select="xs:float($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:dateTime' "><xsl:sequence select="xs:dateTime($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:date' "><xsl:sequence select="xs:date($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:time' "><xsl:sequence select="xs:time($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:boolean' "><xsl:sequence select="xs:boolean($arg)"/></xsl:when>
			<!-- Duration + Subtypes -->
			<xsl:when test="$as eq 'xs:yearMonthDuration' "><xsl:sequence select="xs:yearMonthDuration($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:dayTimeDuration' "><xsl:sequence select="xs:dayTimeDuration($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:duration' "><xsl:sequence select="xs:duration($arg)"/></xsl:when>
			<!-- String (keine Subtypes bei Basic-XSLT-Prozessor) -->
			<xsl:when test="$as eq 'xs:string' "><xsl:sequence select="xs:string($arg)"/></xsl:when>
			<!--<xsl:when test="$as eq 'xs:QName' "><xsl:sequence select="xs:QName($arg)"/></xsl:when>-->
			<xsl:when test="$as eq 'xs:QName' ">
				<xsl:call-template name="xsb:internals.FunctionError">
					<xsl:with-param name="caller">xsb:cast</xsl:with-param>
					<xsl:with-param name="message">[err:XPTY0004] ein Cast auf xs:QName ist nur mit einem String _Literal_ als Argument zulässig, nicht mit einer dynamisch zu evaluierenden Variablen, vgl. http://www.w3.org/TR/xpath20/#id-cast, Nr. 4.a.</xsl:with-param>
					<xsl:with-param name="level">ERROR</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$as eq 'xs:anyURI' "><xsl:sequence select="xs:anyURI($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:gYearMonth' "><xsl:sequence select="xs:gYearMonth($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:gMonthDay' "><xsl:sequence select="xs:gMonthDay($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:gYear' "><xsl:sequence select="xs:gYear($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:gMonth' "><xsl:sequence select="xs:gMonth($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:gDay' "><xsl:sequence select="xs:gDay($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:base64Binary' "><xsl:sequence select="xs:base64Binary($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:hexBinary' "><xsl:sequence select="xs:hexBinary($arg)"/></xsl:when>
			<xsl:when test="$as eq 'xs:untypedAtomic' "><xsl:sequence select="xs:untypedAtomic($arg)"/></xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="$arg"/>
				<xsl:call-template name="xsb:internals.FunctionError">
					<xsl:with-param name="caller">xsb:cast</xsl:with-param>
					<xsl:with-param name="message">Typ »<xsl:sequence select="$as"/>« wird nicht unterstützt.</xsl:with-param>
					<xsl:with-param name="level">ERROR</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--  -->
	<!--  -->
	<!--  -->
</xsl:stylesheet>
