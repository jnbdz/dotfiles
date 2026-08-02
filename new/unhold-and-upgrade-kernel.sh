#!/usr/bin/env bash
set -euo pipefail

LOGFILE="$HOME/kernel-upgrade.log"
exec > >(tee "$LOGFILE") 2>&1

echo "=== Unheld kernel packages ==="
HELD=$(apt-mark showhold | grep linux || true)

if [ -z "$HELD" ]; then
    echo "No kernel packages are held."
else
    echo "$HELD"
    echo ""
    echo "Removing hold on these packages..."
    echo "$HELD" | while read -r pkg; do
        echo "$pkg install" | sudo dpkg --set-selections
    done
fi

echo ""
echo "=== Updating package lists ==="
sudo apt update

echo ""
echo "=== Upgrading kernel ==="
sudo apt upgrade -y

echo ""
echo "=== Done ==="
echo "Current kernel: $(uname -r)"
echo "Reboot to use the new kernel: sudo reboot"
