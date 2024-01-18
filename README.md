# Resume and script for generating pdf resume from Markdown


## Description

## Prerequisites
Before you use this script, you need to have the following installed on your system:
- **Pandoc**: A universal document converter.
- **Chromium**: An open-source browser used for the HTML to PDF conversion.

## Installation
### Install Pandoc
For Debian/Ubuntu-based systems, use:
```bash
sudo apt-get install pandoc
```

For Red Hat/Fedora-based systems, use:
```bash
sudo yum install pandoc
```

For macOS, you can use Homebrew:
```bash
brew install pandoc
```

### Install Chromium
For Debian/Ubuntu-based systems, use:
```bash
sudo apt-get install chromium-browser
```

For Red Hat/Fedora-based systems, use:
```bash
sudo yum install chromium
```

For macOS, you can use Homebrew:
```bash
brew install chromium
```

## Usage
To use the script, navigate to the directory where the script is located and run:

```bash
./generate.sh <input_markdown_file> <output_pdf_file>
```

Replace `<input_markdown_file>` with the path to your Markdown file and `<output_pdf_file>` with the desired path for the output PDF file.

For example:
```bash
./generate.sh my_resume.md my_resume.pdf
```

## Note
- You may need to give execute permissions to the script using `chmod +x generate.sh`.
