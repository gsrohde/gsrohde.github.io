<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="utf-8"/>
      </head>
      <body>
        <pre>
        <xsl:text>name,description,units,range,notes&#xA;</xsl:text>
        <xsl:apply-templates select="quantities/variable">
          <xsl:sort select="@name"/>
        </xsl:apply-templates>
        </pre>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="variable">
    <xsl:call-template name="maybe-escape">
      <xsl:with-param name="value" select="@name"/>
    </xsl:call-template>
    <xsl:text>,</xsl:text>
    <xsl:call-template name="maybe-escape">
      <xsl:with-param name="value" select="description"/>
    </xsl:call-template>
    <xsl:text>,</xsl:text>
    <xsl:call-template name="maybe-escape">
      <xsl:with-param name="value" select="@units"/>
    </xsl:call-template>
    <xsl:text>,</xsl:text>
    <xsl:if test="minimum or maximum">
      <xsl:text>"</xsl:text>
      <xsl:choose>
        <xsl:when test="minimum">
          <xsl:choose>
            <xsl:when test="minimum/@type = 'inclusive'">
              <xsl:text>[</xsl:text>
            </xsl:when>
            <xsl:when test="minimum/@type = 'exclusive'">
              <xsl:text>(</xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="minimum"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>(&#x221e;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>, </xsl:text>
      <xsl:choose>
        <xsl:when test="maximum">
          <xsl:value-of select="maximum"/>
          <xsl:choose>
            <xsl:when test="maximum/@type = 'inclusive'">
              <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:when test="minimum/@type = 'exclusive'">
              <xsl:text>)</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>&#x221e;)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>"</xsl:text>
    </xsl:if>
    <!--<xsl:call-template name="range"/>-->
    <xsl:text>,</xsl:text>
    <xsl:call-template name="maybe-escape">
      <xsl:with-param name="value" select="notes"/>
    </xsl:call-template>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="maybe-escape">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="matches($value, ',|&quot;|&#xA;')">
        <xsl:value-of select="concat('&quot;', replace($value, '&quot;', '&quot;&quot;'), '&quot;')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
