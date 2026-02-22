# ipconfig-for-linux
Ever switch from Windows to Linux and find yourself typing `ipconfig` out of muscle memory, only to get a "command not found" error? Or maybe you just prefer the clean, human-readable output of Windows `ipconfig /all` over parsing through `ip a` and `nmcli device show`?

This script brings the classic `ipconfig` experience natively to Linux. It strikingly captures the familiar visual layout and core functionality of the Windows utility, while actively querying the Linux kernel, `NetworkManager`, and `systemd-resolved` under the hood to deliver highly accurate networking data. 

## Features

* **The Familiar Layout:** Maps Linux network data directly into the classic Windows standard and `/all` output formats so you feel right at home.
* **Core Functional Flags:** Fully supports `/release`, `/renew`, `/flushdns`, `/displaydns`, `/registerdns`, `/showclassid`, and `/setclassid`.
* **Smart DHCP & IPv6 Parsing:** Dynamically calculates exact DHCP lease obtained/expiration times and intelligently tags IP addresses as `(DHCP)`, `(Auto)`, or `(Static)`.
* **Intelligent Interface Protection:** Hardcoded to prevent destructive commands (like `/release`) from accidentally breaking `lo`, `docker0`, `veth`, or virtual bridge interfaces.
* **IP Conflict Detection:** Actively watches the Linux kernel for Duplicate Address Detection (DAD) failures and alerts you on the output.
* **Linux-Optimized Data:** Leaves out legacy Windows protocols and focuses entirely on the data that actually matters to a modern Linux environment.

## Supported Distributions
The included installer automatically detects your OS and grabs the necessary core dependencies (`iproute2`, `networkmanager`, `coreutils`, `gawk`, `sed`, `grep`).
* **Arch-based:** Arch, CachyOS, EndeavourOS (Supports `pacman`, `paru`, and `yay`)
* **Debian-based:** Ubuntu, Debian, Pop!_OS, Linux Mint (`apt`)
* **Fedora-based:** Fedora, RHEL, CentOS (`dnf`)
* **openSUSE-based:** Tumbleweed, Leap (`zypper`)

## Installation

Clone the repository, make the installer executable, and run it. The installer will dynamically handle `sudo` prompts depending on your package manager.

```bash
git clone https://github.com/ZeroIndex-x636A06/ipconfig-for-linux.git
cd ipconfig-for-linux
chmod +x install.sh
./install.sh
```
## Usage
Once installed, you can run ```ipconfig``` from anywhere in your terminal, just like you would on Windows.
```bash
# Standard output
ipconfig

# Detailed output including MAC addresses, DNS servers, and DHCP leases
ipconfig /all

# Release or renew DHCP leases (can target specific adapters)
ipconfig /release
ipconfig /renew wlan0

# Flush the systemd-resolved DNS cache
ipconfig /flushdns

# Display the full help menu
ipconfig /?
```
## Uninstallation
If you ever want to remove the command from your system path, simply run the included safe uninstaller. It strictly removes the script without touching your critical system dependencies.
```bash
git clone https://github.com/ZeroIndex-x636A06/ipconfig-for-linux.git
cd ipconfig-for-linux
chmod +x uninstall.sh
./uninstall.sh
```
