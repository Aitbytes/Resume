#!/usr/bin/env bash

# This script converts an HTML file to a PDF file using Chromium in headless mode.

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <option> <input_html_file> <output_pdf_file>"
    exit 1
fi

option="$1"
input_html="$2"
output_pdf="$3"
output_html_temp="_site/temp_resume.html"

case "$option" in
    "fr") css_file="fr.css"
    ;;
    "en") css_file="en.css"
    ;;
    *) echo "Wrong option. Use 'fr' or 'en'"
    ;;
esac

awesome_font_url="../font-awesome-4.7.0/css/font-awesome.css"

# Check whether input file is present
if [ ! -f "$input_html" ]; then
    echo "Input file not found"
    exit 1
fi

mkdir -p _site

# Create a temporary HTML file with a proper head
cat <<EOF > "$output_html_temp"
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Resume</title>
  <link rel="stylesheet" href="$css_file">
  <link rel="stylesheet" href="$awesome_font_url">
</head>
<body>
EOF

# Append the body content from the input file
cat "$input_html" >> "$output_html_temp"

# Add the closing body and html tags
echo "</body>" >> "$output_html_temp"
echo "</html>" >> "$output_html_temp"

# Define file uri for chromium
html_file_uri=file://$(pwd)/${output_html_temp}

# Convert HTML to PDF
if ! chromium --headless --no-sandbox --print-to-pdf="$output_pdf" --no-margins "$html_file_uri"; then
    echo "Error in HTML to PDF conversion"
    exit 1
fi

echo "Conversion completed successfully."

# Clean up the temporary file
rm "$output_html_temp"