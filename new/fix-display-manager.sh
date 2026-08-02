#!/bin/bash
set -e

echo "Switching from SDDM to LightDM..."
sudo systemctl disable sddm
sudo systemctl enable lightdm

echo "Done. Rebooting in 3 seconds..."
sleep 3
sudo reboot
