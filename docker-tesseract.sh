#!/bin/bash

# Usage:
# TESLANG=rus+eng ./docker-tesseract.sh /path/to/file.jpg

INPUTFILE=$(cd $(dirname "$1") && pwd -P)/$(basename "$1")
INPUT_BASENAME=$(basename $INPUTFILE)

OUTPUTPATH="$(pwd -P)"

docker-compose -f "$(dirname $0)/docker-compose.yml"  \
  run --rm \
  -v "$INPUTFILE":/tmp/"$INPUT_BASENAME" \
  -v "$OUTPUTPATH"/tesseract-output:/tmp/output \
  -e "TESLANG=$TESLANG" \
  runner \
  /project/tesseract.sh "/tmp/$INPUT_BASENAME" "/tmp/output/$INPUT_BASENAME"
