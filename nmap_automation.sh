#!/bin/bash

# Nmap Automation Script
# Author: Huzaifa Khan

echo "====================================="
echo "      Nmap Automation Script"
echo "====================================="
echo

# Check if user provided target
if [ -z "$1" ]; then
  echo "Usage: $0 <target-ip-or-domain>"
  exit 1
fi

TARGET=$1
OUTPUT_DIR="nmap_results"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create results folder
mkdir -p $OUTPUT_DIR

echo "[+] Scanning target: $TARGET"
echo "[+] Results will be saved in $OUTPUT_DIR/$TARGET-$TIMESTAMP.txt"
echo

RESULT_FILE="$OUTPUT_DIR/$TARGET-$TIMESTAMP.txt"

# 1. Ping Scan
echo "[*] Running Ping Scan..."
nmap -sn $TARGET >> $RESULT_FILE
echo "[+] Ping Scan complete!"
echo "-------------------------------------" >> $RESULT_FILE

# 2. Quick Scan (Top 100 ports)
echo "[*] Running Quick Scan (Top 100 Ports)..."
nmap --top-ports 100 -T4 $TARGET >> $RESULT_FILE
echo "[+] Quick Scan complete!"
echo "-------------------------------------" >> $RESULT_FILE

# 3. Full TCP Scan
echo "[*] Running Full TCP Scan..."
nmap -p- -T4 $TARGET >> $RESULT_FILE
echo "[+] Full TCP Scan complete!"
echo "-------------------------------------" >> $RESULT_FILE

# 4. Service Version Detection
echo "[*] Detecting Services and Versions..."
nmap -sV $TARGET >> $RESULT_FILE
echo "[+] Service Version Detection complete!"
echo "-------------------------------------" >> $RESULT_FILE

# 5. OS Detection
echo "[*] Detecting OS..."
nmap -O $TARGET >> $RESULT_FILE
echo "[+] OS Detection complete!"
echo "-------------------------------------" >> $RESULT_FILE

echo
echo "====================================="
echo "[+] All scans completed!"
echo "Results saved in: $RESULT_FILE"
echo "====================================="
