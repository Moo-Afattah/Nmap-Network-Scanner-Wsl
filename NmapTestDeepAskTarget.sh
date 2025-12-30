#!/bin/bash

echo "Enter the target IP or subnet (e.g., 192.168.1.0/24 or example.com):"
read target

sudo nmap -sS -sV -O -T4 "$target" -oX output.xml

xsltproc output.xml -o output.html

cp output.html /mnt/c/report/

echo "Deep scan completed. Report saved to C:\\report"
