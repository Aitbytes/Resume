#!/bin/bash

# This script converts a Markdown file to an HTML file using Pandoc,
# and then converts the HTML file to a PDF using Chromium in headless mode.

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <option> <input_markdown_file> <output_pdf_file>"
    exit 1
fi

option="$1"
input_markdown="$2"
output_pdf="$3"
output_html="index.html"

case "$option" in
    "fr") css_file="fr.css"
    ;;
    "en") css_file="en.css"
    ;;
    *) echo "Wrong option. Use 'fr' or 'en'"
    ;;
esac


awesome_font_url="../font-awesome-4.7.0/css/font-awesome.css"
html_file_path="_site/${output_html}"
#conversion_script_path="/home/a8taleb/dev/resume/md_resume/markdown-resume/source/to_english.py"
#
#Check whether markdown file is present
if [ ! -f "$input_markdown" ]; then
    echo "Input file not found"
    exit 1
fi


mkdir -p _site

# Convert Markdown to HTML
if ! pandoc "$input_markdown" --standalone --to html5 -o "$html_file_path"  --css "$css_file" --css "$awesome_font_url"; then
    echo "Error in Markdown to HTML conversion"
    exit 1
fi

# if [[ $option == "en" ]]; then
#     if ! $conversion_script_path "$output_html"; then 
#         echo "Error in conversion to English"
#         exit 1
#     fi
#     output_html="modified.html"
#     html_file_path="/home/a8taleb/dev/resume/md_resume/markdown-resume/${output_html}"
# fi
# Checks whether HTML file is present
if [ ! -f "$html_file_path" ]; then
    echo "HTML file not found"
    exit 1
fi

# Define file uri for chromium
html_file_uri=file://$(pwd)/${html_file_path}

# Convert HTML to PDF
if ! chromium --headless --print-to-pdf="$output_pdf" --no-margins "$html_file_uri"; then
    echo "Error in HTML to PDF conversion"
    exit 1
fi

echo "Conversion completed successfully."

