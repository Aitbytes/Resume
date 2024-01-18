#!/bin/bash

# This script converts a Markdown file to an HTML file using Pandoc,
# and then converts the HTML file to a PDF using Chromium in headless mode.

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_markdown_file> <output_pdf_file>"
    exit 1
fi

input_markdown="$1"
output_pdf="$2"
output_html="cv.html"
css_file="source/resume.css"
html_file_path="/home/a8taleb/Repos/resume/md_resume/markdown-resume/${output_html}"

# Convert Markdown to HTML
if ! pandoc "$input_markdown" --standalone --to html5 -o "$output_html" --css "$css_file"; then
    echo "Error in Markdown to HTML conversion"
    exit 1
fi

# Convert HTML to PDF
if ! chromium --headless --print-to-pdf="$output_pdf" --no-margins "file://${html_file_path}"; then
    echo "Error in HTML to PDF conversion"
    exit 1
fi

echo "Conversion completed successfully."

