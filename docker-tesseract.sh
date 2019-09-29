#!/bin/bash

INPUTFILE=$(cd $(dirname "$1") && pwd -P)/$(basename "$1")
INPUT_BASENAME=$(basename $INPUTFILE)

OUTPUTPATH="$(pwd -P)"

echo "=== $1 --> ./tesseract-output/ ==="

docker-compose -f "$(dirname $0)/docker-compose.yml"  \
  run --rm \
  -v "$INPUTFILE":/tmp/"$INPUT_BASENAME" \
  -v "$OUTPUTPATH"/tesseract-output:/tmp/output \
  runner \
  ./tesseract.sh "/tmp/$INPUT_BASENAME" "/tmp/output/$INPUT_BASENAME"
