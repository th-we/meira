<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.music-encoding.org/ns/mei" xpath-default-namespace="http://www.music-encoding.org/ns/mei" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
        	<xd:p><xd:b>Created on:</xd:b> Jan 18, 2012</xd:p>
        	<xd:p><xd:b>Author:</xd:b> Johannes Kepper</xd:p>
        	<xd:p><xd:b>Modified on:</xd:b> Feb 25, 2012</xd:p>
        	<xd:p><xd:b>By:</xd:b> Thomas Weber</xd:p>
        	<xd:p>
                Reduces an MEI Document to just one movement. Strips Comments, Processing Instructions, and most of the Header. 
                Therefore, the output of this stylesheet is only usable for rendering purposes.
            </xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:param name="mdiv2show"/>
    
    <xsl:template match="/" priority="-10">
      <xsl:apply-templates select="." mode="reduceToMdiv"/>
    </xsl:template>
    
    <xsl:template mode="reduceToMdiv" match="* | text()| @*">
        <xsl:copy>
            <xsl:apply-templates mode="reduceToMdiv" select="* | text() | @*"/>    
        </xsl:copy>
    </xsl:template>
    
    <!-- If the parameter $mdiv2show is specified, ignore mdivs that don't have the specified ID -->
	  <xsl:template mode="reduceToMdiv" match="mdiv[$mdiv2show and @xml:id != $mdiv2show]"/>
    
    <xsl:template mode="reduceToMdiv" match="meiHead">
        <meiHead>
            <fileDesc>
                <titleStmt>
                    <title/>
                </titleStmt>
                <pubStmt/>
            </fileDesc>
        </meiHead>
    </xsl:template>
    
    <xsl:template mode="reduceToMdiv" match="facsimile"/>
</xsl:stylesheet>
