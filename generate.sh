#!/bin/bash
#

echo $1
echo $2

pandoc "$1" --standalone --to html5 -o cv.html --css source/resume.css && 
  chromium --headless --print-to-pdf="$2" --no-margins "file:///home/a8taleb/Repos/resume/md_resume/markdown-resume/cv.html"
  

