<?xml version="1.0"?>
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <head>
    <style>
      h1 { text-align: center; }
      td { padding: 0.5em; }
      td.code { font-family: Courier; }
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
        <xsl:sort select="@name"/>
        <tr>
          <td class="code"><xsl:value-of select="@name"/></td>
          <td><xsl:value-of select="description"/></td>
          <td><xsl:value-of select="@units"/></td>
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
