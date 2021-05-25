#!/bin/sh
for file in ./*.jpg ./*.png
do
  filename=$(basename -- "$file")
  output="../0.5x/${filename}"
  if [ ! -e "$output" ]; then
    convert -units PixelsPerInch "${filename}" -resample 80 "$output"
  fi
  output="../0.75x/${filename}"
  if [ ! -e "$output" ]; then
    convert -units PixelsPerInch "${filename}" -resample 120 "$output"
  fi
  output="../${filename}"
  if [ ! -e "$output" ]; then
    convert -units PixelsPerInch "${filename}" -resample 160 "$output"
  fi
  output="../1.5x/${filename}"
  if [ ! -e "$output" ]; then
    convert -units PixelsPerInch "${filename}" -resample 240 "$output"
  fi
  output="../2.0x/${filename}"
  if [ ! -e "$output" ]; then
    convert -units PixelsPerInch "${filename}" -resample 320 "$output"
  fi
  output="../3.0x/${filename}"
  if [ ! -e "$output" ]; then
    convert -units PixelsPerInch "${filename}" -resample 480 "$output"
  fi
done