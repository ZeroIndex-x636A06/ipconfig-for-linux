#!/bin/bash

echo "========================================="
echo "   Linux ipconfig Installer              "
echo "========================================="
echo ""

# 1. Payload Check
if [ ! -f "ipconfig" ]; then
    echo "Error: 'ipconfig' script was not found in the current directory."
    echo "Please place this install.sh script in the exact same folder as your ipconfig file and try again."
    exit 1
fi

echo "Detecting operating system..."

# 2. OS Detection
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    OS_LIKE=$ID_LIKE
else
    echo "Warning: Cannot detect OS from /etc/os-release. Skipping automatic dependency installation."
    OS="unknown"
fi

echo "Checking and installing dependencies for your OS..."

# 3. Dependency Installation (with yay/paru support)
if [[ "$OS" == "arch" || "$OS" == "cachyos" || "$OS_LIKE" == *"arch"* ]]; then
    echo "-> Detected Arch/CachyOS-based system."
    if command -v paru &> /dev/null; then
        echo "-> Using paru..."
        paru -S --needed --noconfirm iproute2 networkmanager awk grep coreutils sed
    elif command -v yay &> /dev/null; then
        echo "-> Using yay..."
        yay -S --needed --noconfirm iproute2 networkmanager awk grep coreutils sed
    else
        echo "-> Using pacman..."
        sudo pacman -Sy --needed --noconfirm iproute2 networkmanager awk grep coreutils sed
    fi
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" || "$OS_LIKE" == *"ubuntu"* || "$OS_LIKE" == *"debian"* ]]; then
    echo "-> Detected Debian/Ubuntu-based system."
    sudo apt-get update
    sudo apt-get install -y iproute2 network-manager gawk grep coreutils sed
elif [[ "$OS" == "fedora" || "$OS" == "rhel" || "$OS" == "centos" || "$OS_LIKE" == *"fedora"* || "$OS_LIKE" == *"rhel"* ]]; then
    echo "-> Detected Fedora/RHEL-based system."
    sudo dnf install -y iproute NetworkManager gawk grep coreutils sed
elif [[ "$OS" == "opensuse"* || "$OS_LIKE" == *"suse"* ]]; then
    echo "-> Detected openSUSE-based system."
    sudo zypper in -y iproute2 NetworkManager gawk grep coreutils sed
else
    echo "-> Unsupported or unknown OS ($OS). Please manually ensure NetworkManager and iproute2 are installed."
fi

# 4. Script Installation
echo ""
echo "Installing ipconfig to /usr/local/bin..."

sudo cp ipconfig /usr/local/bin/ipconfig
sudo chmod +x /usr/local/bin/ipconfig

echo ""
echo "========================================="
echo " Installation Complete!                  "
echo " You can now run 'ipconfig' from         "
echo " anywhere in your terminal.              "
echo "========================================="
