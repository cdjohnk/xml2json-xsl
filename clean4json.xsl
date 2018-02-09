<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <!-- Clean up text to make it json compatible -->
    <xsl:template match="//text()">
        <xsl:value-of select="replace(replace(normalize-space(.),'\\','\\\\'),'&quot;','\\&quot;')"/>
    </xsl:template>
    <!-- Sort elements so that json arrays will build properly -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@*">
                <xsl:sort select="name()"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="node()">
                <xsl:sort select="name()"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>