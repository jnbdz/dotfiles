#!/bin/bash
set -e

echo "=== XFCE Wayland + NVIDIA Fix ==="
echo "Fixes dual-Xorg GPU contention by:"
echo "  1. Switching SDDM greeter from X11 to Wayland (using labwc)"
echo "  2. Configuring NVIDIA env vars for wlroots compositors"
echo "  3. Setting up labwc config for XFCE"
echo ""

# Check dependencies
for pkg in labwc xwayland; do
    if ! dpkg -l "$pkg" &>/dev/null; then
        echo "Installing $pkg..."
        sudo apt install -y "$pkg"
    fi
done

# 1. SDDM: switch greeter to Wayland with labwc compositor
echo "Configuring SDDM for Wayland greeter..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/wayland.conf > /dev/null <<'EOF'
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_DISABLE_WINDOWDECORATION=1,WLR_NO_HARDWARE_CURSORS=1,GBM_BACKEND=nvidia-drm,__GLX_VENDOR_LIBRARY_NAME=nvidia,WLR_RENDERER=vulkan

[Wayland]
CompositorCommand=labwc -C /etc/sddm/labwc
EOF

# Create labwc config for SDDM greeter
sudo mkdir -p /etc/sddm/labwc
if [ ! -f /etc/sddm/labwc/rc.xml ]; then
    sudo cp /usr/share/xfce4/labwc/labwc-rc.xml /etc/sddm/labwc/rc.xml
fi

sudo tee /etc/sddm/labwc/environment > /dev/null <<'EOF'
WLR_NO_HARDWARE_CURSORS=1
GBM_BACKEND=nvidia-drm
__GLX_VENDOR_LIBRARY_NAME=nvidia
WLR_RENDERER=vulkan
XKB_DEFAULT_LAYOUT=us
XKB_DEFAULT_MODEL=pc105
EOF

# 2. XFCE labwc session config
echo "Setting up XFCE labwc config..."
mkdir -p "$HOME/.config/xfce4/labwc"

if [ ! -f "$HOME/.config/xfce4/labwc/rc.xml" ]; then
    cp /usr/share/xfce4/labwc/labwc-rc.xml "$HOME/.config/xfce4/labwc/rc.xml"
fi

cat > "$HOME/.config/xfce4/labwc/environment" <<'EOF'
# Keyboard layout
XKB_DEFAULT_LAYOUT=us
XKB_DEFAULT_MODEL=pc105

# Cursor
XCURSOR_THEME=Adwaita

# NVIDIA Wayland support (wlroots-based compositors)
WLR_NO_HARDWARE_CURSORS=1
GBM_BACKEND=nvidia-drm
__GLX_VENDOR_LIBRARY_NAME=nvidia
WLR_RENDERER=vulkan
LIBVA_DRIVER_NAME=nvidia
EOF

# 3. Ensure nvidia-drm modeset is enabled (should already be)
if ! grep -q 'modeset=1' /etc/modprobe.d/nvidia-kms.conf 2>/dev/null; then
    echo "Enabling nvidia-drm modeset..."
    echo 'options nvidia-drm modeset=1' | sudo tee /etc/modprobe.d/nvidia-kms.conf
    sudo update-initramfs -u
fi

echo ""
echo "Done. Reboot for changes to take effect."
echo ""
echo "After reboot, verify with:"
echo '  loginctl show-session $(loginctl list-sessions --no-legend | awk "{print \$1}" | head -1) -p Type'
echo "Expected: Type=wayland"
echo ""
echo "If the greeter fails to load, switch to a TTY (Ctrl+Alt+F3) and run:"
echo "  sudo rm /etc/sddm.conf.d/wayland.conf && sudo systemctl restart sddm"
echo "This will revert SDDM to the X11 greeter."
