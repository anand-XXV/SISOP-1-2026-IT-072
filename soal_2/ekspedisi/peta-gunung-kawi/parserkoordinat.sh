#!/bin/bash

INPUT="gsxtrack.json"
OUTPUT="titik-penting.txt"

> "$OUTPUT"

grep -E '"id"|"site_name"|"latitude"|"longitude"' "$INPUT" | awk -F'"' '
/"id"/ { id = $4 }
/"site_name"/ { name = $4 }
/"latitude"/ { lat = $3; gsub(/: /, "", lat); gsub(/,/, "", lat) }
/"longitude"/ { lon = $3; gsub(/: /, "", lon); gsub(/,/, "", lon); print id","name","lat","lon }
' >> "$OUTPUT"

cat "$OUTPUT"
