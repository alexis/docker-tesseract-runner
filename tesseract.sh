#!/bin/sh -x

tesseract $1 ${2:-$1} -l eng+rus --psm 1 --oem 3 txt
