<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <!-- Convert XML to JSON. XML Nodes must be ordered for JSON object arrays to be properly parsed.
        Attributes on parent nodes that are parsed into an array will not be captured -->
    
    <xsl:template match="/">{
        <xsl:apply-templates select="*"/>}
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:call-template name="Properties"/>
    </xsl:template>
    
    <xsl:template name="Properties">
        <xsl:variable name="isarray" select="count(../*[name()=current()/name()]) > 1"/>
        <xsl:variable name="printarrayhead" select="position()=index-of(../*,../*[name()=current()/name()][1])[1]"/>
        <xsl:variable name="printarraytail" select="position()=index-of(../*,../*[name()=current()/name()][last()])[last()]"/>
        <xsl:choose>
            <xsl:when test="not(*|@*)">"<xsl:value-of select="name()"/>":"<xsl:value-of  select="normalize-space(./text())"/>"</xsl:when>
            <xsl:when test="$isarray"><xsl:if test="$printarrayhead">"<xsl:value-of select="./name()"/>" :[</xsl:if>{<xsl:apply-templates select="*"/>}<xsl:if test="$printarraytail">]</xsl:if></xsl:when>
            <xsl:otherwise>"<xsl:value-of select="name()"/>":{
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates select="*"/>}</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="following-sibling::*">,
        </xsl:if>
    </xsl:template>
    
    <!-- Attribute Property -->
    <xsl:template match="@*">"<xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>",</xsl:template>
</xsl:stylesheet>
