#!/bin/bash
# @isx47590131 Projecte radius
# De markdown a pdf
#---------------------------------------------------------
pandoc --standalone --to=dzslides --incremental \
  --css=css.css --output=presentacio.html presentacio.md
