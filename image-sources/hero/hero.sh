#!/usr/bin/env bash

rm -rf out
mkdir out

file='hero.jpg'
variants=( 720x480_-small 1440x960_-medium 2880x1920_-large )

for variant in "${variants[@]}"; do
	size="${variant%_*}"
	suffix="${variant#*_}"
	convert "${file}" -resize "${size}!" "out/${file%.jpg}${suffix}.jpg"
done
