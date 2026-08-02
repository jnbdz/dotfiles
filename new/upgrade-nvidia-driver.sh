#!/bin/bash
# Upgrade NVIDIA driver from 550.163.01 to 595.58.03
# RTX 4070 Ti — Ada Lovelace
#
# USAGE:
#   Step 1 (from GUI): Run with "download" to fetch the installer
#     ./upgrade-nvidia-driver.sh download
#
#   Step 2 (from TTY): Switch to TTY with Ctrl+Alt+F3, log in, then:
#     ./upgrade-nvidia-driver.sh install
#
#   Step 3: Reboot
#     sudo reboot

set -euo pipefail

DRIVER_VERSION="595.58.03"
DRIVER_FILE="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
DRIVER_URL="https://download.nvidia.com/XFree86/Linux-x86_64/${DRIVER_VERSION}/${DRIVER_FILE}"
DOWNLOAD_DIR="/home/jn"

case "${1:-}" in
  download)
    echo "==> Downloading NVIDIA driver ${DRIVER_VERSION}..."
    cd "$DOWNLOAD_DIR"
    if [ -f "$DRIVER_FILE" ]; then
      echo "File already exists: ${DOWNLOAD_DIR}/${DRIVER_FILE}"
      echo "Delete it first if you want to re-download."
      exit 0
    fi
    wget -O "$DRIVER_FILE" "$DRIVER_URL"
    chmod +x "$DRIVER_FILE"
    echo ""
    echo "==> Download complete: ${DOWNLOAD_DIR}/${DRIVER_FILE}"
    echo ""
    echo "Next steps:"
    echo "  1. Press Ctrl+Alt+F3 to switch to a TTY"
    echo "  2. Log in"
    echo "  3. Run: ~/Projects/jnbdz/dotfiles/new/upgrade-nvidia-driver.sh install"
    ;;

  install)
    if [ "$(id -u)" -ne 0 ]; then
      echo "Error: Must run as root. Use: sudo $0 install"
      exit 1
    fi

    if [ ! -f "${DOWNLOAD_DIR}/${DRIVER_FILE}" ]; then
      echo "Error: Driver file not found at ${DOWNLOAD_DIR}/${DRIVER_FILE}"
      echo "Run '$0 download' first."
      exit 1
    fi

    echo "==> Current driver:"
    nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null || echo "(not running)"

    echo ""
    echo "==> Stopping display manager..."
    systemctl stop lightdm 2>/dev/null || systemctl stop sddm 2>/dev/null || true
    sleep 2

    echo "==> Removing ALL packaged NVIDIA drivers and libraries..."
    apt-get remove --purge -y '*nvidia*' 'libcuda*' 'libnvcuvid*' 'libnvidia*' 2>/dev/null || true
    apt-get autoremove -y 2>/dev/null || true

    echo "==> Cleaning up leftover NVIDIA sentinel files and alternatives..."
    rm -rf /usr/lib/nvidia
    rm -f /usr/lib/x86_64-linux-gnu/libEGL_nvidia* \
          /usr/lib/x86_64-linux-gnu/libGLESv2_nvidia* \
          /usr/lib/x86_64-linux-gnu/libGLX_nvidia* \
          /usr/lib/x86_64-linux-gnu/libnvidia* \
          /usr/lib/x86_64-linux-gnu/libcuda* \
          /usr/lib/x86_64-linux-gnu/libnvcuvid*
    update-alternatives --remove-all nvidia 2>/dev/null || true
    update-alternatives --remove-all "nvidia--alt-compute-xx" 2>/dev/null || true
    # Remove any dpkg info fragments left behind
    rm -f /var/lib/dpkg/info/nvidia*.list \
          /var/lib/dpkg/info/nvidia*.postinst \
          /var/lib/dpkg/info/nvidia*.postrm \
          /var/lib/dpkg/info/nvidia*.prerm \
          /var/lib/dpkg/info/nvidia*.preinst \
          /var/lib/dpkg/info/nvidia*.conffiles \
          /var/lib/dpkg/info/nvidia*.md5sums \
          /var/lib/dpkg/info/libnvidia*.list \
          /var/lib/dpkg/info/libnvidia*.postinst \
          /var/lib/dpkg/info/libnvidia*.postrm \
          /var/lib/dpkg/info/libnvidia*.prerm \
          /var/lib/dpkg/info/libnvidia*.md5sums \
          /var/lib/dpkg/info/libcuda*.list \
          /var/lib/dpkg/info/libcuda*.md5sums
    dpkg --configure -a 2>/dev/null || true

    echo "==> Unloading NVIDIA kernel modules..."
    modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia 2>/dev/null || true

    echo "==> Installing NVIDIA ${DRIVER_VERSION}..."
    "${DOWNLOAD_DIR}/${DRIVER_FILE}" --silent --dkms --no-check-for-alternate-installs

    echo ""
    echo "==> Installation complete!"
    echo "==> Reboot now with: sudo reboot"
    ;;

  *)
    echo "Usage: $0 {download|install}"
    echo ""
    echo "  download  — Download the driver (run from GUI)"
    echo "  install   — Install the driver (run from TTY as root)"
    exit 1
    ;;
esac
