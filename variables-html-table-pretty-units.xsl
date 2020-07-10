<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="xhtml"/>

  <xsl:variable name="unit-table">
    <unit ascii-name="micromole / m^2 / s">
      <html-display-name>μmol / m<sup>2</sup> / s</html-display-name>
    </unit>
    <unit ascii-name="degrees N">
      <html-display-name>°N</html-display-name>
    </unit>
    <unit ascii-name="Mg / m^3">
      <html-display-name>Mg / m<sup>3</sup></html-display-name>
    </unit>
    <unit ascii-name="m^3 / m^3">
      <html-display-name>m<sup>3</sup> / m<sup>3</sup></html-display-name>
    </unit>
    <unit ascii-name="mol / m^2 / s">
      <html-display-name>mol / m<sup>2</sup> / s</html-display-name>
    </unit>
    <unit ascii-name="m^2 / m^2 / m">
      <html-display-name>m<sup>2</sup> / m<sup>2</sup> / m</html-display-name>
    </unit>
    <unit ascii-name="mol / m^2 / s">
      <html-display-name>mol / m<sup>2</sup> / s</html-display-name>
    </unit>
    <unit ascii-name="degrees C">
      <html-display-name>°C</html-display-name>
    </unit>
    <unit ascii-name="m^2 / m^2">
      <html-display-name>m<sup>2</sup> / m<sup>2</sup></html-display-name>
    </unit>
    <unit ascii-name="micromole / mol">
      <html-display-name>μmol / mol</html-display-name>
    </unit>
    <unit ascii-name="mol / m^2 / s / Pa">
      <html-display-name>mol / m<sup>2</sup> / s / Pa</html-display-name>
    </unit>
    <unit ascii-name="kg / m^3 / K">
      <html-display-name>kg / m<sup>3</sup> / K</html-display-name>
    </unit>
    <unit ascii-name="kg / s / m^3">
      <html-display-name>kg / s / m<sup>3</sup></html-display-name>
    </unit>
    <unit ascii-name="kg / m^3">
      <html-display-name>kg / m<sup>3</sup></html-display-name>
    </unit>
    <unit ascii-name="ha / Mg / degrees C / day">
      <html-display-name>ha / Mg / °C / d</html-display-name>
    </unit>
    <unit ascii-name="degrees C * day">
      <html-display-name>°C · d</html-display-name>
    </unit>
    <unit ascii-name="m / s^2">
      <html-display-name>m / s<sup>2</sup></html-display-name>
    </unit>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <head>
        <style>
          h1 { text-align: center; }
          td { padding: 1em; }
          .code { font-family: Courier; }
          td.range { white-space: nowrap; }
          td.freeform { font-family: Roman; }
        </style>
      </head>
      <body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE">
        <h1>Master BioCro Variable List</h1>
        <table>
          <tr>
            <th>name</th><th>description</th><th>units</th><th>range</th><th>notes</th>
          </tr>
          <xsl:for-each select="quantities/variable">
            <tr>
              <td class="code"><xsl:value-of select="@name"/></td>
              <td><xsl:value-of select="description"/></td>
              <td>
                <xsl:call-template name="pretty-units">
                  <xsl:with-param name="ascii-units" select="@units"/>
                </xsl:call-template>
              </td>
              <td class="range">
                <xsl:if test="minimum or maximum">
                  <xsl:choose>
                    <xsl:when test="minimum/@type = 'inclusive'">[</xsl:when>
                    <xsl:when test="minimum/@type = 'exclusive'">(</xsl:when>
                    <xsl:when test="not(minimum)">(unsp.</xsl:when>
                  </xsl:choose>
                  <xsl:value-of select="minimum"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="maximum"/>
                  <xsl:choose>
                    <xsl:when test="maximum/@type = 'inclusive'">]</xsl:when>
                    <xsl:when test="maximum/@type = 'exclusive'">)</xsl:when>
                    <xsl:when test="not(maximum)">unsp.)</xsl:when>
                  </xsl:choose>
                </xsl:if>
              </td>
              <td class="freeform"><xsl:value-of select="notes"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="pretty-units">
    <xsl:param name="ascii-units"/>
    <xsl:choose>
      <xsl:when test="$ascii-units = $unit-table/*:unit/@ascii-name">
        <xsl:for-each select="$unit-table/*:unit[@ascii-name = $ascii-units]/*:html-display-name/node()">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="span">
          <xsl:attribute name="class">
            <xsl:text>code</xsl:text>
          </xsl:attribute>
          <xsl:value-of select="$ascii-units"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
