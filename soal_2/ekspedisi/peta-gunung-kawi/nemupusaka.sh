#!/bin/bash

INPUT="titik-penting.txt"
OUTPUT="posisipusaka.txt"

lat1=$(grep "node_001" "$INPUT" | awk -F',' '{print $3}')
lon1=$(grep "node_001" "$INPUT" | awk -F',' '{print $4}')
lat2=$(grep "node_003" "$INPUT" | awk -F',' '{print $3}')
lon2=$(grep "node_003" "$INPUT" | awk -F',' '{print $4}')

lat_tengah=$(awk "BEGIN {print ($lat1 + $lat2) / 2}")
lon_tengah=$(awk "BEGIN {print ($lon1 + $lon2) / 2}")

echo "Koordinat pusat: $lat_tengah, $lon_tengah"
echo "$lat_tengah, $lon_tengah" > "$OUTPUT"
