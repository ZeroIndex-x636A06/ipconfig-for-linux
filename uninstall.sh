#!/bin/bash

echo "========================================="
echo "   Linux ipconfig Uninstaller            "
echo "========================================="
echo ""

# 1. Target Check
if [ ! -f "/usr/local/bin/ipconfig" ]; then
    echo "The 'ipconfig' command was not found in /usr/local/bin."
    echo "It appears it is already uninstalled or was never installed."
    exit 0
fi

# 2. Removal Execution
echo "Removing ipconfig from your system path..."
sudo rm -f /usr/local/bin/ipconfig

# 3. Safe Exit Notice
echo ""
echo "Note: Core system dependencies (iproute2, NetworkManager, coreutils, etc.)"
echo "were intentionally left untouched, as they are critical to your OS."
echo ""
echo "========================================="
echo " Uninstallation Complete!                "
echo "========================================="
