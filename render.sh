#!/bin/bash -eu

mkdir -p output

cp -r static/* output/

for file in pages/*.md; do
	filename=$(basename "$file" .md)
	pandoc "$file" --template="template.html" -o "output/$filename.html"
done

