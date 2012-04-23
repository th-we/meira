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
	exclude-result-prefixes="doc docv xsb intern xlink xs"
	extension-element-prefixes="saxon"
	>
	<!--  -->
	<!--  -->
	<!--  -->
	<xsl:import href="strings.xsl"/>
	<!--  -->
	<!--  -->
	<!--  -->
	<doc:doc filename="internals.logging.xsl" internal-ns="docv" global-ns="doc xsb intern" vocabulary="DocBook" info="$Revision: 37 $, $Date: 2011-06-26 22:53:01 +0200 (Sun, 26 Jun 2011) $">
		<doc:title>Logging-System</doc:title>
		<para>Dieses Stylesheet stellt ein API für das Logging zur Verfügung. Die Templates sind nicht zur direkten Benutzung gedacht; vielmehr sollen
			externe Wrapper dieses API nutzen. Dadurch kann der Logging-Unterbau ggfs. ausgetauscht werden.</para>
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
				<para>Stylesheet: <link xlink:href="&XSL-Base-Directory;/internals.logging.xsl">&XSL-Base-Directory;/internals.logging.xsl</link></para>
			</listitem>
			<listitem>
				<para>Dokumentation: <link xlink:href="&doc-Base-Directory;/internals.logging.html">&doc-Base-Directory;/internals.logging.html</link></para>
			</listitem>
			<listitem>
				<para>Test-Stylesheet: <link xlink:href="&XSL-Base-Directory;/internals.logging_tests.xsl">&XSL-Base-Directory;/internals.logging_tests.xsl</link></para>
			</listitem>
			<listitem>
				<para>Test-Dokumentation: <link xlink:href="&doc-Base-Directory;/internals.logging_tests.html">&doc-Base-Directory;/internals.logging_tests.html</link></para>
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
				<revnumber>0.47</revnumber>
				<date>2009-10-11</date>
				<authorinitials>Stf</authorinitials>
				<revremark>Ausgliederung von Logging aus <code>internals.xsl</code></revremark>
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
	<!-- ====================     Templates     ==================== -->
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Output     __________ -->
	<doc:template>
		<!-- Content -->
		<para xml:id="internals.logging.Output">Dieses Template ist der zentrale Einstieg zur Realisierung des Logging. 
			Es nimmt die Logging-Parameter entgegen, wandelt sie in Tunnel-Parameter um und ruft den Dispatcher
			<function>intern:internals.logging.Dispatcher</function> auf.
			Es ist recht abstrakt und sollte zur Benutzung von Wrappern (wie z.B. 
			<function><link xlink:href="internals.html#internals.Logging">xsb:internals.Logging</link></function>) umgeben werden.</para>
		<para>Diese Template ist auch für die Umwandlung der übergebenen Parameter in getunnelte Parameter zuständig.</para>
		<doc:param name="log-entry.preText"><para xml:id="log-entry.preText">Text, der ganz am Anfang der Ausgabe 
			geschrieben wird. Bei Ausgabe als Text oder auf die Konsole kann darüber bspw. 
			eine Einrückung realisiert werden. Bei Ausgabe als XML wird dieser Text der Nachricht hinzugefügt, 
			bei Ausgabe als HTML wird eine zusätzliche Tabellenspalte erzeugt.</para></doc:param>
		<doc:param name="log-entry.ID"><para xml:id="log-entry.ID">Message-ID</para></doc:param>
		<doc:param name="log-entry.timeStamp"><para xml:id="log-entry.timeStamp">Zeitstempel der Nachricht.</para></doc:param>
		<doc:param name="log-entry.processedFile"><para xml:id="log-entry.processedFile">Name der Datei, die bei Erzeugung der 
			Nachricht transformiert wurde.</para></doc:param>
		<doc:param name="log-entry.level"><para xml:id="log-entry.level">Level der Nachricht. In Anlehnung an <code>Log4j</code> werden 
			per Vorgabe die Stufen 
			»<code>ALL</code>« > »<code>TRACE</code>« > »<code>DEBUG</code>« > »<code>INFO</code>« > »<code>WARN</code>« > »<code>ERROR</code>« > »<code>FATAL</code>« 
			(in aufsteigender Reihenfolge der Wichtigkeit) verwendet.</para></doc:param>
		<doc:param name="log-entry.text"><para xml:id="log-entry.text">Nachrichtentext</para></doc:param>
		<doc:param name="log-entry.category"><para xml:id="log-entry.category">Kategorie der Nachricht, dient als zusätzliches 
			Unterscheidungsmerkmal bei der externen Auswertung, z.B. "Fehler", "Abrechnung" oder "Hauptroutine"</para></doc:param>
		<doc:param name="log-entry.postText"><para xml:id="log-entry.postText">Text, der ganz am Ende der Ausgabe 
			geschrieben wird. Die konkrete Ausgabe wird in den entsprechenden <code>intern:internals.logging.Render-to-xxx</code>-Templates
			erzeugt; beispielsweise wird bei Ausgabe als XML dieser Text von  <function><link linkend="internals.logging.Render-to-xml">intern:internals.logging.Render-to-xml</link></function> 
			hinter <code>$log-entry.text</code> eingefügt.</para>
		</doc:param>
		<!-- Formatierung -->
		<doc:param name="log-entry.linebreak-string">
			<para xml:id="log-entry.linebreak-string">String, der bei einem 
			Zeilenumbruch ausgegeben wird, im Normalfall <code>&amp;#x0A;</code>.</para>
		</doc:param>
		<!-- Ausgabemedium -->
		<doc:param name="log-entry.write-to-console">
			<para xml:id="log-entry.write-to-console">Wenn <code>true()</code>, wird die Nachricht auf die Konsole ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-to-file">
			<para xml:id="log-entry.write-to-file">Wenn <code>true()</code>, wird die Nachricht in die Ausgabedatei geschrieben</para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-comment">
			<para xml:id="log-entry.write-to-file-as-comment">Wenn <code>true()</code>, wird die Nachricht als Kommentar in die 
			Ausgabedatei geschrieben</para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-element">
			<para xml:id="log-entry.write-to-file-as-element">Wenn <code>true()</code>, 
			wird die Nachricht als XML-Element in die Ausgabedatei geschrieben</para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-html">
			<para xml:id="log-entry.write-to-file-as-html">Wenn <code>true()</code>, 
			wird die Nachricht als HTML in die Ausgabedatei geschrieben</para>
		</doc:param>
		<doc:param name="log-entry.write-to-file-as-text">
			<para xml:id="log-entry.write-to-file-as-text">Wenn <code>true()</code>, 
			wird die Nachricht als Text in die Ausgabedatei geschrieben</para>
		</doc:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<doc:param name="log-entry.write-preText">
			<para xml:id="log-entry.write-preText">Wenn <code>true()</code>, wird der Pre-Text mit der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-ID">
			<para xml:id="log-entry.write-ID">Wenn <code>true()</code>, wird die ID der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-timeStamp">
			<para xml:id="log-entry.write-timeStamp">Wenn <code>true()</code>, wird der Zeitstempel der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-processedFile">
			<para xml:id="log-entry.write-processedFile">Wenn <code>true()</code>, wird der Name der transformierten Datei
			mit der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-level">
			<para xml:id="log-entry.write-level">Wenn <code>true()</code>, wird der Level der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-text">
			<para xml:id="log-entry.write-text">Wenn <code>true()</code>, wird der Text der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-category">
			<para xml:id="log-entry.write-category">Wenn <code>true()</code>, wird die Kategorie der Nachricht ausgegeben</para>
		</doc:param>
		<doc:param name="log-entry.write-postText">
			<para xml:id="log-entry.write-postText">Wenn <code>true()</code>, wird der Post-Text mit der Nachricht ausgegeben</para>
		</doc:param>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Output">
		<!-- Content -->
		<xsl:param name="log-entry.preText" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.ID" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.timeStamp" as="xs:dateTime?" required="no"/>
		<xsl:param name="log-entry.processedFile" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.level" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.text" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.category" as="xs:string?" required="no"/>
		<xsl:param name="log-entry.postText" as="xs:string?" required="no"/>
		<!-- Formatierung -->
		<xsl:param name="log-entry.linebreak-string" as="xs:string?" required="no"/>
		<!-- Ausgabemedium -->
		<xsl:param name="log-entry.write-to-console" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-to-file" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-comment" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-element" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-html" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-text" as="xs:boolean" required="yes"/>
		<!-- Steuerung der auzugebenden Elemente -->
		<xsl:param name="log-entry.write-preText" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-ID" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-timeStamp" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-processedFile" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-level" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-text" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-category" as="xs:boolean" required="yes"/>
		<xsl:param name="log-entry.write-postText" as="xs:boolean" required="yes"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<xsl:call-template name="intern:internals.logging.Dispatcher">
			<!-- Content -->
			<xsl:with-param name="log-entry.preText.tunneld" as="xs:string?" select="$log-entry.preText" tunnel="yes"/>
			<xsl:with-param name="log-entry.ID.tunneld" as="xs:string?" select="$log-entry.ID" tunnel="yes"/>
			<xsl:with-param name="log-entry.timeStamp.tunneld" as="xs:dateTime?" select="$log-entry.timeStamp" tunnel="yes"/>
			<xsl:with-param name="log-entry.processedFile.tunneld" as="xs:string?" select="$log-entry.processedFile" tunnel="yes"/>
			<xsl:with-param name="log-entry.level.tunneld" as="xs:string?" select="$log-entry.level" tunnel="yes"/>
			<xsl:with-param name="log-entry.text.tunneld" as="xs:string?" select="$log-entry.text" tunnel="yes"/>
			<xsl:with-param name="log-entry.category.tunneld" as="xs:string?" select="$log-entry.category" tunnel="yes"/>
			<xsl:with-param name="log-entry.postText.tunneld" as="xs:string?" select="$log-entry.postText" tunnel="yes"/>
			<!-- Formatierung -->
			<xsl:with-param name="log-entry.linebreak-string.tunneld" as="xs:string?" select="$log-entry.linebreak-string" tunnel="yes"/>
			<!-- Ausgabemedium -->
			<xsl:with-param name="log-entry.write-to-console.tunneld" as="xs:boolean" select="$log-entry.write-to-console" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-to-file.tunneld" as="xs:boolean" select="$log-entry.write-to-file" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-to-file-as-comment.tunneld" as="xs:boolean" select="$log-entry.write-to-file-as-comment" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-to-file-as-element.tunneld" as="xs:boolean" select="$log-entry.write-to-file-as-element" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-to-file-as-html.tunneld" as="xs:boolean" select="$log-entry.write-to-file-as-html" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-to-file-as-text.tunneld" as="xs:boolean" select="$log-entry.write-to-file-as-text" tunnel="yes"/>
			<!-- Steuerung der auzugebenden Elemente -->
			<xsl:with-param name="log-entry.write-preText.tunneld" as="xs:boolean" select="$log-entry.write-preText" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-ID.tunneld" as="xs:boolean" select="$log-entry.write-ID" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-timeStamp.tunneld" as="xs:boolean" select="$log-entry.write-timeStamp" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-processedFile.tunneld" as="xs:boolean" select="$log-entry.write-processedFile" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-level.tunneld" as="xs:boolean" select="$log-entry.write-level" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-text.tunneld" as="xs:boolean" select="$log-entry.write-text" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-category.tunneld" as="xs:boolean" select="$log-entry.write-category" tunnel="yes"/>
			<xsl:with-param name="log-entry.write-postText.tunneld" as="xs:boolean" select="$log-entry.write-postText" tunnel="yes"/>
		</xsl:call-template>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Dispatcher     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Dispatcher">Dieses Template verteilt die Nachrichten an die passenden Ausgabe-Templates. Parameter werden über 
			<code>tunnel="yes"</code> durchgereicht (getunnelt).</para>
		<para>Dieses zwischengeschaltete Template vermeidet außerdem, dass die Umwandlung in Tunnel-Parameter
			innerhalb von <link linkend="internals.logging.Output"><function>internal:internals.logging.Output</function></link> 
			mehrfach vorgenommen werden muss.</para>
		<!-- Ausgabemedium -->
		<doc:param name="log-entry.write-to-console.tunneld"><para>siehe Template <link linkend="log-entry.write-to-console"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-to-file.tunneld"><para>siehe Template <link linkend="log-entry.write-to-file"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-to-file-as-comment.tunneld"><para>siehe Template <link linkend="log-entry.write-to-file-as-comment"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-to-file-as-element.tunneld"><para>siehe Template <link linkend="log-entry.write-to-file-as-element"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-to-file-as-html.tunneld"><para>siehe Template <link linkend="log-entry.write-to-file-as-html"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-to-file-as-text.tunneld"><para>siehe Template <link linkend="log-entry.write-to-file-as-text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Dispatcher">
		<!-- Ausgabemedium -->
		<xsl:param name="log-entry.write-to-console.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-to-file.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-comment.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-element.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-html.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-to-file-as-text.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<xsl:if test="$log-entry.write-to-console.tunneld">
			<xsl:call-template name="intern:internals.logging.Write-to-console"/>
		</xsl:if>
		<xsl:if test="$log-entry.write-to-file.tunneld">
			<xsl:if test="$log-entry.write-to-file-as-comment.tunneld">
				<xsl:call-template name="intern:internals.logging.Write-to-file-as-comment"></xsl:call-template>
			</xsl:if>
			<xsl:if test="$log-entry.write-to-file-as-element.tunneld">
				<xsl:call-template name="intern:internals.logging.Write-to-file-as-element"></xsl:call-template>
			</xsl:if>
			<xsl:if test="$log-entry.write-to-file-as-html.tunneld">
				<xsl:call-template name="intern:internals.logging.Write-to-file-as-html"></xsl:call-template>
			</xsl:if>
			<xsl:if test="$log-entry.write-to-file-as-text.tunneld">
				<xsl:call-template name="intern:internals.logging.Write-to-file-as-text"></xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Write-to-console     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Write-to-console">Dieses Template gibt die Nachricht auf der Konsole aus. Parameter werden über 
			<code>tunnel="yes"</code> an das Template <function>intern:internals.logging.Render-to-string</function> 
			durchgereicht (getunnelt).</para>
		<para>Das Template wird normalerweise von <function>intern:internals.logging.Output</function> aufgerufen.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umleiten oder Umformatieren überschrieben werden.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Write-to-console">
		<!-- Parameter werden über tunnel="yes" durchgereicht (getunnelt) -->
		<xsl:message terminate="no" intern:solved="CheckXSLMessage"><xsl:call-template name="intern:internals.logging.Render-to-string"/></xsl:message>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Write-to-file-as-comment     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Write-to-file-as-comment">Dieses Template gibt die Nachricht als Kommentar in den Output-Stream 
			(in der Regel: die Ergebnis-Datei) aus. Parameter werden über <code>tunnel="yes"</code> 
			an das <function>Template intern:internals.logging.Render-to-string</function> durchgereicht (getunnelt).</para>
		<para>Das Template wird normalerweise von <function>intern:internals.logging.Output</function> aufgerufen.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umleiten oder Umformatieren überschrieben werden.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Write-to-file-as-comment" as="comment()">
		<!-- Parameter werden über tunnel="yes" durchgereicht (getunnelt) -->
		<xsl:comment><xsl:call-template name="intern:internals.logging.Render-to-string"/></xsl:comment>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Write-to-file-as-element     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Write-to-file-as-element">Dieses Template gibt die Nachricht als XML-Element in den Output-Stream 
			(in der Regel: die Ergebnis-Datei) aus. Parameter werden über <code>tunnel="yes"</code> 
			an das <function>Template intern:internals.logging.Render-to-xml</function> durchgereicht (getunnelt).</para>
		<para>Das Template wird normalerweise von <function>intern:internals.logging.Output</function> aufgerufen.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umleiten oder Umformatieren überschrieben werden.</para>
		<doc:param name="log-entry.linebreak-string.tunneld"><para>siehe Template <link linkend="log-entry.linebreak-string"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Write-to-file-as-element" as="node()*" intern:solved="EmptySequenceAllowed">
		<!-- Parameter werden über tunnel="yes" durchgereicht (getunnelt) -->
		<xsl:param name="log-entry.linebreak-string.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<!--  -->
		<xsl:call-template name="intern:internals.logging.Render-to-xml"/>
		<xsl:value-of select="$log-entry.linebreak-string.tunneld"/>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Write-to-file-as-html     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Write-to-file-as-html">Dieses Template gibt die Nachricht als HTML-Elemente in den Output-Stream 
			(in der Regel: die Ergebnis-Datei) aus. Parameter werden über <code>tunnel="yes"</code> 
			an das <function>Template intern:internals.logging.Render-to-html</function> durchgereicht (getunnelt).</para>
		<para>Das Template wird normalerweise von <function>intern:internals.logging.Output</function> aufgerufen.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umleiten oder Umformatieren überschrieben werden.</para>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Write-to-file-as-html" as="node()+">
		<xsl:call-template name="intern:internals.logging.Render-to-html"/>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Write-to-file-as-text     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Write-to-file-as-text">Dieses Template gibt die Nachricht als Text in den Output-Stream (in der Regel: die Ergebnis-Datei) aus. 
			Parameter werden über <code>tunnel="yes"</code> an das <function>Template intern:internals.logging.Render-to-string</function> 
			durchgereicht (getunnelt).</para>
		<para>Das Template wird normalerweise von <function>intern:internals.logging.Output</function> aufgerufen.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umleiten oder Umformatieren überschrieben werden.</para>
		<doc:param name="log-entry.linebreak-string.tunneld"><para>siehe Template <link linkend="log-entry.linebreak-string"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Write-to-file-as-text" as="xs:string*" intern:solved="EmptySequenceAllowed">
		<!-- Parameter werden über tunnel="yes" durchgereicht (getunnelt) -->
		<xsl:param name="log-entry.linebreak-string.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<!--  -->
		<xsl:call-template name="intern:internals.logging.Render-to-string"/>
		<xsl:sequence select="$log-entry.linebreak-string.tunneld"/>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Render-to-string     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Render-to-string">Dieses Template rendert die Message-Parameter als Text. 
			Parameter werden über <code>tunnel="yes"</code> empfangen (getunnelt).</para>
		<para>Werden keine Parameter übergeben, wird eine <code>empty sequence</code> zurückgegeben.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umformatieren überschrieben werden.</para>
		<!-- Content -->
		<doc:param name="log-entry.preText.tunneld"><para>siehe Template <link linkend="log-entry.preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.ID.tunneld"><para>siehe Template <link linkend="log-entry.ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.timeStamp.tunneld"><para>siehe Template <link linkend="log-entry.timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.processedFile.tunneld"><para>siehe Template <link linkend="log-entry.processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.level.tunneld"><para>siehe Template <link linkend="log-entry.level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.text.tunneld"><para>siehe Template <link linkend="log-entry.text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.category.tunneld"><para>siehe Template <link linkend="log-entry.category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.postText.tunneld"><para>siehe Template <link linkend="log-entry.postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<doc:param name="log-entry.write-preText.tunneld"><para>siehe Template <link linkend="log-entry.write-preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-ID.tunneld"><para>siehe Template <link linkend="log-entry.write-ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-timeStamp.tunneld"><para>siehe Template <link linkend="log-entry.write-timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-processedFile.tunneld"><para>siehe Template <link linkend="log-entry.write-processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-level.tunneld"><para>siehe Template <link linkend="log-entry.write-level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-text.tunneld"><para>siehe Template <link linkend="log-entry.write-text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-category.tunneld"><para>siehe Template <link linkend="log-entry.write-category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-postText.tunneld"><para>siehe Template <link linkend="log-entry.write-postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Render-to-string" as="xs:string?" intern:solved="EmptySequenceAllowed">
		<!-- Content -->
		<xsl:param name="log-entry.preText.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.ID.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.timeStamp.tunneld" as="xs:dateTime?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.processedFile.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.level.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.text.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.category.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.postText.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<!-- Steuerung der auzugebenden Elemente -->
		<xsl:param name="log-entry.write-preText.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-ID.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-timeStamp.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-processedFile.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-level.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-text.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-category.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-postText.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<xsl:variable name="temp" as="xs:string*">
			<xsl:if test="$log-entry.write-preText.tunneld">
				<xsl:sequence select="$log-entry.preText.tunneld"/>
			</xsl:if>
			<xsl:if test="$log-entry.write-ID.tunneld">
				<xsl:sequence select="$log-entry.ID.tunneld"/>
				<xsl:text>: </xsl:text>
			</xsl:if>
			<xsl:if test="$log-entry.write-timeStamp.tunneld">
				<xsl:text>[</xsl:text>
				<xsl:sequence select="$log-entry.timeStamp.tunneld"/>
				<xsl:text>] </xsl:text>
			</xsl:if>
			<xsl:if test="$log-entry.write-processedFile.tunneld">
				<xsl:sequence select="$log-entry.processedFile.tunneld"/>
				<xsl:text>: </xsl:text>
			</xsl:if>
			<xsl:if test="$log-entry.write-level.tunneld">
				<xsl:text>[</xsl:text>
				<xsl:sequence select="$log-entry.level.tunneld"/>
				<xsl:text>] </xsl:text>
			</xsl:if>
			<xsl:if test="$log-entry.write-text.tunneld">
				<xsl:sequence select="$log-entry.text.tunneld"/>
			</xsl:if>
			<xsl:if test="$log-entry.write-category.tunneld">
				<xsl:text>(</xsl:text>
				<xsl:sequence select="$log-entry.category.tunneld"/>
				<xsl:text>) </xsl:text>
			</xsl:if>
			<xsl:if test="$log-entry.write-postText.tunneld">
				<xsl:sequence select="$log-entry.postText.tunneld"/>
			</xsl:if>
		</xsl:variable>
		<xsl:sequence select="string-join($temp, '')"/>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Render-to-xml     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Render-to-xml">Dieses Template rendert die Message-Parameter als XML-Elemente. 
			Parameter werden über <code>tunnel="yes"</code> empfangen (getunnelt).</para>
		<para>Die Nachricht wird in ein message-Element mit Kindelementen umgewandelt.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umformatieren überschrieben werden.</para>
		<!-- Content -->
		<doc:param name="log-entry.preText.tunneld"><para>siehe Template <link linkend="log-entry.preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.ID.tunneld"><para>siehe Template <link linkend="log-entry.ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.timeStamp.tunneld"><para>siehe Template <link linkend="log-entry.timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.processedFile.tunneld"><para>siehe Template <link linkend="log-entry.processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.level.tunneld"><para>siehe Template <link linkend="log-entry.level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.text.tunneld"><para>siehe Template <link linkend="log-entry.text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.category.tunneld"><para>siehe Template <link linkend="log-entry.category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.postText.tunneld"><para>siehe Template <link linkend="log-entry.postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<doc:param name="log-entry.write-preText.tunneld"><para>siehe Template <link linkend="log-entry.write-preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-ID.tunneld"><para>siehe Template <link linkend="log-entry.write-ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-timeStamp.tunneld"><para>siehe Template <link linkend="log-entry.write-timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-processedFile.tunneld"><para>siehe Template <link linkend="log-entry.write-processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-level.tunneld"><para>siehe Template <link linkend="log-entry.write-level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-text.tunneld"><para>siehe Template <link linkend="log-entry.write-text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-category.tunneld"><para>siehe Template <link linkend="log-entry.write-category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-postText.tunneld"><para>siehe Template <link linkend="log-entry.write-postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.139</revnumber>
				<date>2011-04-24</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Trennung von preText, Text und postText</para>
				</revdescription>
			</revision>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Render-to-xml" as="node()">
		<!-- Content -->
		<xsl:param name="log-entry.preText.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.ID.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.timeStamp.tunneld" as="xs:dateTime?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.processedFile.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.level.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.text.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.category.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.postText.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<!-- Steuerung der auzugebenden Elemente -->
		<xsl:param name="log-entry.write-preText.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-ID.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-timeStamp.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-processedFile.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-level.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-text.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-category.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-postText.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<message>
			<xsl:if test="$log-entry.write-ID.tunneld">
				<xsl:attribute name="id" select="$log-entry.ID.tunneld"/>
			</xsl:if>
			<xsl:if test="$log-entry.write-timeStamp.tunneld">
				<timeStamp>
					<xsl:sequence select="$log-entry.timeStamp.tunneld"/>
				</timeStamp>
			</xsl:if>
			<xsl:if test="$log-entry.write-processedFile.tunneld">
				<processedFile>
					<xsl:sequence select="$log-entry.processedFile.tunneld"/>
				</processedFile>
			</xsl:if>
			<xsl:if test="$log-entry.write-level.tunneld">
				<level>
					<xsl:sequence select="$log-entry.level.tunneld"/>
				</level>
			</xsl:if>
			<xsl:if test="$log-entry.write-preText.tunneld">
				<preText>
					<xsl:sequence select="$log-entry.preText.tunneld"/>
				</preText>
			</xsl:if>
			<xsl:if test="$log-entry.write-text.tunneld">
				<text>
					<xsl:sequence select="($log-entry.text.tunneld)"/>
				</text>
			</xsl:if>
			<xsl:if test="$log-entry.write-postText.tunneld">
				<postText>
					<xsl:sequence select="$log-entry.postText.tunneld"/>
				</postText>
			</xsl:if>
			<xsl:if test="$log-entry.write-category.tunneld">
				<category>
					<xsl:sequence select="$log-entry.category.tunneld"/>
				</category>
			</xsl:if>
		</message>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.Render-to-html     __________ -->
	<doc:template>
		<para xml:id="internals.logging.Render-to-html">Dieses Template rendert die Message-Parameter als HTML-Elemente. 
			Parameter werden über <code>tunnel="yes"</code> empfangen (getunnelt).</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umformatieren überschrieben werden.</para>
		<!-- Content -->
		<doc:param name="log-entry.preText.tunneld"><para>siehe Template <link linkend="log-entry.preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.ID.tunneld"><para>siehe Template <link linkend="log-entry.ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.timeStamp.tunneld"><para>siehe Template <link linkend="log-entry.timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.processedFile.tunneld"><para>siehe Template <link linkend="log-entry.processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.level.tunneld"><para>siehe Template <link linkend="log-entry.level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.text.tunneld"><para>siehe Template <link linkend="log-entry.text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.category.tunneld"><para>siehe Template <link linkend="log-entry.category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.postText.tunneld"><para>siehe Template <link linkend="log-entry.postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<doc:param name="log-entry.write-preText.tunneld"><para>siehe Template <link linkend="log-entry.write-preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-ID.tunneld"><para>siehe Template <link linkend="log-entry.write-ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-timeStamp.tunneld"><para>siehe Template <link linkend="log-entry.write-timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-processedFile.tunneld"><para>siehe Template <link linkend="log-entry.write-processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-level.tunneld"><para>siehe Template <link linkend="log-entry.write-level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-text.tunneld"><para>siehe Template <link linkend="log-entry.write-text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-category.tunneld"><para>siehe Template <link linkend="log-entry.write-category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-postText.tunneld"><para>siehe Template <link linkend="log-entry.write-postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para><function>log-entry.command</function> entfernt</para>
				</revdescription>
			</revision>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.Render-to-html" as="node()+">
		<!-- Content -->
		<xsl:param name="log-entry.preText.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.ID.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.timeStamp.tunneld" as="xs:dateTime?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.processedFile.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.level.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.text.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.category.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<xsl:param name="log-entry.postText.tunneld" as="xs:string?" tunnel="yes" required="no"/>
		<!-- Steuerung der auzugebenden Elemente -->
		<xsl:param name="log-entry.write-preText.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-ID.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-timeStamp.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-processedFile.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-level.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-text.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-category.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<xsl:param name="log-entry.write-postText.tunneld" as="xs:boolean" tunnel="yes" required="yes"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<tr>
			<xsl:attribute name="style">
				<xsl:text>background: </xsl:text>
				<xsl:choose>
					<xsl:when test="$log-entry.level.tunneld eq 'FATAL'">red</xsl:when>
					<xsl:when test="$log-entry.level.tunneld eq 'ERROR'">red</xsl:when>
					<xsl:when test="$log-entry.level.tunneld eq 'WARN'">orange</xsl:when>
					<xsl:when test="$log-entry.level.tunneld eq 'INFO'">yellow</xsl:when>
					<!-- ALL, TRACE, DEBUG und andere Werte -->
					<xsl:otherwise>none</xsl:otherwise>
				</xsl:choose>
				
			</xsl:attribute>
			<xsl:if test="$log-entry.write-preText.tunneld">
				<td>
					<xsl:sequence select="$log-entry.preText.tunneld"/>
				</td>
			</xsl:if>
			<xsl:if test="$log-entry.write-ID.tunneld">
				<td><a name="{$log-entry.ID.tunneld}"/><xsl:sequence select="$log-entry.ID.tunneld"/></td>
			</xsl:if>
			<xsl:if test="$log-entry.write-timeStamp.tunneld">
				<td>
					<xsl:sequence select="$log-entry.timeStamp.tunneld"/>
				</td>
			</xsl:if>
			<xsl:if test="$log-entry.write-processedFile.tunneld">
				<td>
					<xsl:sequence select="$log-entry.processedFile.tunneld"/>
				</td>
			</xsl:if>
			<xsl:if test="$log-entry.write-level.tunneld">
				<td>
					<xsl:sequence select="$log-entry.level.tunneld"/>
				</td>
			</xsl:if>
			<xsl:if test="$log-entry.write-text.tunneld">
				<td>
					<xsl:sequence select="$log-entry.text.tunneld"/>
				</td>
			</xsl:if>
			<xsl:if test="$log-entry.write-category.tunneld">
				<td>
					<xsl:sequence select="$log-entry.category.tunneld"/>
				</td>
			</xsl:if>
			<xsl:if test="$log-entry.write-postText.tunneld">
				<td>
					<xsl:sequence select="$log-entry.postText.tunneld"/>
				</td>
			</xsl:if>
		</tr>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.MakeHeader.element     __________ -->
	<doc:template>
		<para xml:id="internals.logging.MakeHeader.element">Dieses Template erzeugt bei der Ausgabe als xml den Kopf, speziell das öffnende Element</para>
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
	<xsl:template name="intern:internals.logging.MakeHeader.element">
		&crt;
		<xsl:text disable-output-escaping="yes"><![CDATA[<log>]]></xsl:text>&crt;
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.MakeHeader.html     __________ -->
	<doc:template>
		<para xml:id="internals.logging.MakeHeader.html">Dieses Template erzeugt bei der Ausgabe als xml den Kopf, speziell das öffnende Element</para>
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
		<doc:param name="titel"><para>optionaler Seitentitel</para></doc:param>
	</doc:template>
	<xsl:template name="intern:internals.logging.MakeHeader.html" exclude-result-prefixes="#all">
		<xsl:param name="titel" as="xs:string?" required="no"/>
		&crt;
		<xsl:text disable-output-escaping="yes"><![CDATA[<html>]]></xsl:text>&crt;
		<head>
			<title>
				<xsl:choose>
					<xsl:when test="normalize-space($titel)">
						<xsl:value-of select="$titel"/>
					</xsl:when>
					<xsl:otherwise>Protokoll</xsl:otherwise>
				</xsl:choose>
			</title>
		</head>
		<xsl:text disable-output-escaping="yes"><![CDATA[<body>]]></xsl:text>&crt;
		<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>&crt;
		<xsl:call-template name="intern:internals.logging.MakeThead.HTML">
			<xsl:with-param name="log-entry.preText">---</xsl:with-param>
		</xsl:call-template>
		<xsl:text disable-output-escaping="yes"><![CDATA[<tbody>]]></xsl:text>&crt;
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.MakeFooter.element     __________ -->
	<doc:template>
		<para xml:id="internals.logging.MakeFooter.element">Dieses Template erzeugt bei der Ausgabe als XML den Fuß, speziell das schließende Element</para>
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
	<xsl:template name="intern:internals.logging.MakeFooter.element">
		<xsl:text disable-output-escaping="yes"><![CDATA[</log>]]></xsl:text>&crt;
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.MakeFooter.html     __________ -->
	<doc:template>
		<para xml:id="internals.logging.MakeFooter.html">Dieses Template erzeugt bei der Ausgabe als HTML den Fuß, speziell die schließenden Tags</para>
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
	<xsl:template name="intern:internals.logging.MakeFooter.html" exclude-result-prefixes="#all">
		<xsl:text disable-output-escaping="yes"><![CDATA[</tbody>]]></xsl:text>&crt;
		<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>&crt;
		<xsl:text disable-output-escaping="yes"><![CDATA[</body>]]></xsl:text>&crt;
		<xsl:text disable-output-escaping="yes"><![CDATA[</html>]]></xsl:text>&crt;
	</xsl:template>
	<!--  -->
	<!--  -->
	<!-- __________     intern:internals.logging.MakeThead.HTML     __________ -->
	<doc:template>
		<para xml:id="internals.logging.MakeThead.HTML">Dieses Template erzeugt eine Zeile mit dem Tabellenkopf für die Ausgabe als HTML. 
			Die Signatur des Templates entspricht einem normalen Logging-Eintrag (mit Ausnahme von
			<code>log-entry.timeStamp</code>, das hier <code>xs:string</code> ist), die übergebenen 
			Werte werden in die Spaltenüberschriften geschrieben. Werden keine Werte übergeben, 
			werden Standardwerte verwendet.</para>
		<para><emphasis role="bold">Hook</emphasis>: kann zum Umformatieren überschrieben werden.</para>
		<!-- Content -->
		<doc:param name="log-entry.preText"><para>siehe Template <link linkend="log-entry.preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.ID"><para>siehe Template <link linkend="log-entry.ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.timeStamp"><para>siehe Template <link linkend="log-entry.timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.processedFile"><para>siehe Template <link linkend="log-entry.processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.level"><para>siehe Template <link linkend="log-entry.level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.text"><para>siehe Template <link linkend="log-entry.text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.category"><para>siehe Template <link linkend="log-entry.category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.postText"><para>siehe Template <link linkend="log-entry.postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<doc:param name="log-entry.write-preText"><para>siehe Template <link linkend="log-entry.write-preText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-ID"><para>siehe Template <link linkend="log-entry.write-ID"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-timeStamp"><para>siehe Template <link linkend="log-entry.write-timeStamp"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-processedFile"><para>siehe Template <link linkend="log-entry.write-processedFile"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-level"><para>siehe Template <link linkend="log-entry.write-level"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-text"><para>siehe Template <link linkend="log-entry.write-text"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-category"><para>siehe Template <link linkend="log-entry.write-category"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<doc:param name="log-entry.write-postText"><para>siehe Template <link linkend="log-entry.write-postText"><function>intern:internals.logging.Output</function></link></para></doc:param>
		<revhistory>
			<revision>
				<revnumber>0.141</revnumber>
				<date>2011-04-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>als selbständiges Template neben der Logging-Infrastruktur umgeschrieben</para>
				</revdescription>
			</revision>
			<revision>
				<revnumber>0.53</revnumber>
				<date>2009-10-25</date>
				<authorinitials>Stf</authorinitials>
				<revdescription>
					<para conformance="beta">Status: beta</para>
					<para>Umstellung auf Namespaces <code>xsb:</code> und <code>intern:</code></para>
				</revdescription>
			</revision>
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
	<xsl:template name="intern:internals.logging.MakeThead.HTML" as="node()">
		<!-- Content -->
		<xsl:param name="log-entry.preText" as="xs:string?" required="no">n/a</xsl:param>
		<xsl:param name="log-entry.ID" as="xs:string?" required="no">ID</xsl:param>
		<xsl:param name="log-entry.timeStamp" as="xs:string?" required="no">Datum/Zeit</xsl:param>
		<xsl:param name="log-entry.processedFile" as="xs:string?" required="no">Datei</xsl:param>
		<xsl:param name="log-entry.level" as="xs:string?" required="no">Level</xsl:param>
		<xsl:param name="log-entry.text" as="xs:string?" required="no">Nachricht</xsl:param>
		<xsl:param name="log-entry.category" as="xs:string?" required="no">Kategorie</xsl:param>
		<xsl:param name="log-entry.postText" as="xs:string?" required="no">n/a</xsl:param>
		<!-- Steuerung der auzugebenden Elemente -->
		<xsl:param name="log-entry.write-preText" as="xs:boolean" required="no" select="true()"/>
		<xsl:param name="log-entry.write-ID" as="xs:boolean" required="no" select="false()"/>
		<xsl:param name="log-entry.write-timeStamp" as="xs:boolean" required="no" select="false()"/>
		<xsl:param name="log-entry.write-processedFile" as="xs:boolean" required="no" select="false()"/>
		<xsl:param name="log-entry.write-level" as="xs:boolean" required="no" select="true()"/>
		<xsl:param name="log-entry.write-text" as="xs:boolean" required="no" select="true()"/>
		<xsl:param name="log-entry.write-category" as="xs:boolean" required="no" select="false()"/>
		<xsl:param name="log-entry.write-postText" as="xs:boolean" required="no" select="false()"/>
		<!--  -->
		<!--  -->
		<!-- Verarbeitung -->
		<thead>
			<tr>
				<xsl:if test="$log-entry.write-preText">
					<th>
						<xsl:sequence select="$log-entry.preText"/>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-ID">
					<th>
						<xsl:choose>
							<xsl:when test="normalize-space($log-entry.ID)">
								<a name="{$log-entry.ID}"><xsl:sequence select="$log-entry.ID"/></a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:sequence select="$log-entry.ID"/>
							</xsl:otherwise>
						</xsl:choose>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-timeStamp">
					<th>
						<xsl:sequence select="xs:string($log-entry.timeStamp)"/>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-processedFile">
					<th>
						<xsl:sequence select="$log-entry.processedFile"/>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-level">
					<th>
						<xsl:sequence select="$log-entry.level"/>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-text">
					<th>
						<xsl:sequence select="$log-entry.text"/>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-category">
					<th>
						<xsl:sequence select="$log-entry.category"/>
					</th>
				</xsl:if>
				<xsl:if test="$log-entry.write-postText">
					<th>
						<xsl:sequence select="$log-entry.postText"/>
					</th>
				</xsl:if>
			</tr>			
		</thead>
	</xsl:template>
	<!--  -->
	<!--  -->
	<!--  -->
</xsl:stylesheet>
