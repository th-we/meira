#!/bin/bash

# Syntax: viewsvg.sh [options] FILE
# Option are:
# -b or --bounding-boxes
#   adds bounding boxes and draws them in the SVG
# -z=NUMBER or --zoom=NUMBER
#   Set zoom factor (standard is 1)

initialMode=""
zoom=""

for arg; do 
  case $arg in
    -b|--bounding-boxes)
      initialMode="-im:svg-with-bounding-boxes"
      ;;
    -z=*|--zoom=*)
      zoom="--x-zoom ${arg#*=} --y-zoom ${arg#*=}"
      ;;
    *)
      filename=$arg
      ;;
  esac
done

saxonb-xslt -xsl:def2xsl.xsl -s:elementDefinitions/musx.def | saxonb-xslt -xsl:- $initialMode -s:$filename | rsvg-view --stdin $zoom