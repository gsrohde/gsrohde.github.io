<?xml version="1.0"?>
<html xsl:version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <head>
    <style>
      .code { font-family: Courier; }
    </style>
  </head>
  <body>
    <pre>
#ifndef PARAMETERS_H
#define PARAMETERS_H

#include &lt;cmath> // for HUGE_VAL
#include "parameter.h"

namespace biocro_parameters {

<xsl:for-each select="quantities/variable">
  <xsl:value-of select="concat('    const parameter ',
                        @name,
                        '{&quot;',
                        @name,
                        '&quot;, &quot;',
                        replace(description, '&quot;', '\\&quot;'),
                        '&quot;, ',
                        (if (minimum) then number(minimum) else '-HUGE_VAL'),
                        ', ',
                        (if (minimum/@type = 'inclusive') then 'true' else 'false'),
                        ', ',
                        (if (maximum) then number(maximum) else 'HUGE_VAL'),
                        ', ',
                        (if (maximum/@type = 'inclusive') then 'true' else 'false'),
                        '};&#xA;')
                        "/>




</xsl:for-each>
}

# endif

    </pre>
  </body>
</html>
