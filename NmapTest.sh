#!/bin/bash

# NmapTest - Scan 192.168.1.0/24 and export HTML report to Windows

NETWORK="192.168.1.0/24"
OUTPUT_DIR="/mnt/c/report"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

XML_FILE="$OUTPUT_DIR/nmap_scan_$TIMESTAMP.xml"
HTML_FILE="$OUTPUT_DIR/nmap_scan_$TIMESTAMP.html"

# Check if nmap is installed
if ! command -v nmap >/dev/null 2>&1; then
    echo "Error: nmap is not installed."
    echo "Install it using: sudo apt install nmap"
    exit 1
fi

# Check if xsltproc is installed (needed for HTML conversion)
if ! command -v xsltproc >/dev/null 2>&1; then
    echo "Error: xsltproc is not installed."
    echo "Install it using: sudo apt install xsltproc"
    exit 1
fi

# Ensure output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Creating directory $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

echo "Running Nmap scan on $NETWORK..."
nmap -sV -oX "$XML_FILE" "$NETWORK"

echo "Converting XML to HTML..."
xsltproc /usr/share/nmap/nmap.xsl "$XML_FILE" > "$HTML_FILE"

echo
echo "Scan complete!"
echo "XML report saved to:  $XML_FILE"
echo "HTML report saved to: $HTML_FILE"
echo
echo "Open the report in Windows with:"
echo "explorer.exe /mnt/c/report"
