<?xml version="1.0"?>
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <head>
    <style>
      h1 { text-align: center; }
      dt, dd { padding: 0.5em; }
      div { padding: 0.2em 0 0.2em 0; }
      span.label { font-weight: bold; }
      span.code { font-family: Courier; }
      span.range { white-space: nowrap; }
      span.freeform { font-family: Roman; }
      li { text-decoration: none; }
    </style>
  </head>
  <body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE">
    <h1>Master BioCro Variable List</h1>
    <dl>
      <xsl:for-each select="quantities/variable">
        <xsl:sort select="@units"/>
        <xsl:sort select="@name"/>
        <hr/>
        <dt>
          <div><span class="code"><xsl:value-of select="@name"/></span></div>
        </dt>
        <dd>
          <div><span class="label">Description: </span> <xsl:value-of select="description"/></div>
          <div><span class="label">Units: </span> <xsl:value-of select="@units"/></div>
          <div><span class="label">Range: </span>
          <xsl:choose>
            <xsl:when test="minimum or maximum">
              <span class="range">
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
              </span>
            </xsl:when>
            <xsl:otherwise>
              [none specified]
            </xsl:otherwise>
          </xsl:choose>
          </div>
          <xsl:if test="notes">
            <div><span class="label">Notes: </span> <span class="freeform"><xsl:value-of select="notes"/></span></div>
          </xsl:if>
        </dd>
      </xsl:for-each>
    </dl>
  </body>
</html>
