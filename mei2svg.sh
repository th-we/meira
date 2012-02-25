#!/bin/bash

saxonb-xslt -xsl:preprocessor/reduceToMdiv.xsl -s:$1 |\
xsltproc preprocessor/add-ids.xsl $1 | \
xsltproc preprocessor/canonicalize.xsl - | \
saxonb-xslt -xsl:preprocessor/addDurations.xsl -s:- | \
saxonb-xslt -xsl:preprocessor/addSynchronicity.xsl -s:- |\
saxonb-xslt -xsl:mei2musx/mei2musx.xsl -s:- |\
saxonb-xslt -xsl:formatter/accidentalFormatter.xsl -s:- |\
saxonb-xslt -xsl:formatter/spacing.xsl -s:- |\
saxonb-xslt -xsl:musx2svg/musx2svg.xsl -s:-