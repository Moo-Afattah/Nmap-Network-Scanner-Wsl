#!/bin/bash

# NmapTestDeep - deeper scan of 192.168.1.0/24 with HTML report to Windows

NETWORK="192.168.1.0/24"
OUTPUT_DIR="/mnt/c/report"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

XML_FILE="$OUTPUT_DIR/nmap_deep_$TIMESTAMP.xml"
HTML_FILE="$OUTPUT_DIR/nmap_deep_$TIMESTAMP.html"

echo "=== NmapTestDeep - Authorized internal scan only ==="
echo "Target network: $NETWORK"
echo

# Check if nmap is installed
if ! command -v nmap >/dev/null 2>&1; then
    echo "Error: nmap is not installed."
    echo "Install it using: sudo apt install nmap"
    exit 1
fi

# Check if xsltproc is installed
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

echo "Running deeper Nmap scan with:"
echo "  -sS (stealth SYN scan)"
echo "  -sV (service/version detection)"
echo "  -sC (default safe scripts)"
echo "  -O  (OS detection)"
echo

sudo nmap -sS -sV -sC -O -oX "$XML_FILE" "$NETWORK"

echo
echo "Converting XML to HTML..."
xsltproc /usr/share/nmap/nmap.xsl "$XML_FILE" > "$HTML_FILE"

echo
echo "Deep scan complete!"
echo "XML report:  $XML_FILE"
echo "HTML report: $HTML_FILE"
echo
echo "Open in Windows with:"
echo "  explorer.exe /mnt/c/report"
