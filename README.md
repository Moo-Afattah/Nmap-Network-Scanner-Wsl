# Nmap Network Scanner (WSL → Windows reports)

This project contains simple Bash scripts to scan a local network (192.168.1.0/24). You can amend  using Nmap from Ubuntu/WSL and save HTML reports directly to the Windows filesystem at `C:\report` (`/mnt/c/report` in WSL).

## Scripts

- `NmapTest.sh`  
  Basic scan with service detection and HTML report.

- `NmapTestDeep.sh`  
  Deeper scan using:
  - `-sS` stealth SYN scan  
  - `-sV` service/version detection  
  - `-sC` default safe scripts  
  - `-O` OS detection

## Requirements

- Ubuntu/WSL
- `nmap`
- `xsltproc`
- Windows folder `C:\report` (created manually or by the script)

## Usage

From Ubuntu/WSL:

```bash
cd ~/NmapNetworkScanner

# Basic scan
./NmapTest.sh

# Deep scan (will ask for sudo)
./NmapTestDeep.sh
