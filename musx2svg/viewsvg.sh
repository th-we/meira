#!/bin/bash

# Syntax: viewsvg.sh [-bb] FILE
# Option -bb adds bounding boxes and draws them in the SVG

initialMode=""

for arg; do 
  if [ "$arg" == "-bb" ] ; then
    initialMode="-im:svg-with-bounding-boxes"
  else
    filename=$arg
  fi
done

saxonb-xslt -xsl:def2xsl.xsl -s:elementDefinitions/musx.def | saxonb-xslt -xsl:- $initialMode -s:$filename | rsvg-view -s