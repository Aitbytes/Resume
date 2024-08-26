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
output_html="cv.html"

case "$option" in
    "fr") css_file="source/fr.css"
    ;;
    "en") css_file="source/en.css"
    ;;
    *) echo "Wrong option. Use 'fr' or 'en'"
    ;;
esac


awesome_font_url="/home/a8taleb/dev/resume/md_resume/markdown-resume/font-awesome-4.7.0/css/font-awesome.css"
html_file_path="/home/a8taleb/dev/resume/md_resume/markdown-resume/${output_html}"
conversion_script_path="/home/a8taleb/dev/resume/md_resume/markdown-resume/source/to_english.py"


# Convert Markdown to HTML
if ! pandoc "$input_markdown" --standalone --to html5 -o "$output_html"  --css "$css_file" --css "$awesome_font_url"; then
    echo "Error in Markdown to HTML conversion"
    exit 1
fi

if [[ $option == "en" ]]; then
    if ! $conversion_script_path "$output_html"; then 
        echo "Error in conversion to English"
        exit 1
    fi
    output_html="modified.html"
    html_file_path="/home/a8taleb/dev/resume/md_resume/markdown-resume/${output_html}"
fi

# Convert HTML to PDF
if ! chromium --headless --print-to-pdf="$option$output_pdf" --no-margins "file://${html_file_path}"; then
    echo "Error in HTML to PDF conversion"
    exit 1
fi

echo "Conversion completed successfully."

