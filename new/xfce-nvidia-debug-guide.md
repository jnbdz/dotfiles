---
name: XFCE + NVIDIA display/input debugging playbook
description: Complete diagnostic guide for GUI freezes, broken clicks, and input issues on XFCE with NVIDIA — covers DRM contention, display managers, pointer grabs, and hardware failure
type: reference
---

# XFCE + NVIDIA Display & Input Debugging Playbook

Lessons learned from a multi-session debugging effort (April 2026) on Kali Linux, XFCE, NVIDIA RTX 4070 Ti (Ada Lovelace), kernel 6.18.12.

---

## Problem 1: GUI Freeze (complete lockup)

**Symptom:** Entire desktop freezes, can't interact at all.

**Root cause:** SDDM's X11 greeter spawns a second Xorg process. Two Xorg instances fighting over DRM master caused `nv_drm_revoke_modeset_permission` storms in the NVIDIA kernel module, leading to GPU deadlock.

**Diagnosis:**
```bash
pgrep -a Xorg                          # More than one Xorg = problem
journalctl -b -p warning | grep nvidia # Look for nv_drm_revoke_modeset_permission
dmesg | grep -i nv_drm                 # Same check via dmesg
```

**Fix:** Switch from SDDM to LightDM. LightDM runs the greeter inside the same Xorg as the user session — no dual-Xorg DRM contention.
```bash
sudo systemctl disable sddm && sudo systemctl enable lightdm && sudo reboot
```
At LightDM login: select "Xfce Session" (X11, not Wayland).

---

## Problem 2: Clicks broken after Wayland attempt

**Symptom:** Mouse hover/tooltips/animations worked, clicks did nothing.

**Root cause:** labwc 0.9.6 + NVIDIA + XFCE XWayland has broken click delivery. `<mouse><default/></mouse>` in rc.xml did not fix it.

**Fix:** Don't use Wayland with NVIDIA + XFCE. Stick with X11 via LightDM.

---

## Problem 3: Clicks stop after GNOME Keyring prompt

**Symptom:** After filling out GNOME Keyring password and clicking OK, X pointer grab is not released — hover works but clicks stop everywhere.

**Diagnosis:**
```bash
ps aux | grep -iE 'gnome-keyring|gcr|pinentry'
```

**Fix:** `sudo systemctl restart lightdm` (full session restart). To prevent: disable GNOME Keyring autostart in xfce4-session-settings, or replace gcr-prompter with seahorse.

---

## Problem 4: Input devices become floating (detached)

**Symptom:** Mouse cursor moves but clicks don't work, keyboard partially works. Caused by a script that detached X11 input devices.

**Diagnosis:**
```bash
DISPLAY=:0 xinput list    # Look for [floating slave] instead of [slave pointer/keyboard]
```

**Attempted fixes that DID NOT work:** xfwm4 --replace, xinput reattach, xinput enable, systemctl restart lightdm.

**Fix:** Only `sudo reboot` worked reliably.

---

## Problem 5: Mouse motion works but clicks don't (hardware failure)

**Symptom:** Cursor moves, hover works, keyboard works, but zero mouse clicks register. Happens immediately at login. No crashes, no freezes.

**This is easily confused with software bugs (Problems 2-4 above).** The key differentiator is the diagnostic below.

### Diagnostic ladder (follow in order):

**Step 1 — Check device attachment:**
```bash
DISPLAY=:0 xinput list
# All devices should show [slave pointer/keyboard (N)], NOT [floating slave]
```

**Step 2 — Check for pointer grabs:**
```bash
# Force ungrab
DISPLAY=:0 python3 -c "
import ctypes, ctypes.util
lib = ctypes.cdll.LoadLibrary(ctypes.util.find_library('X11'))
d = lib.XOpenDisplay(b':0')
lib.XUngrabPointer(d, 0); lib.XSync(d, False); lib.XCloseDisplay(d)
print('Ungrabbed')
"
```

**Step 3 — Kill suspected grab-holding processes:**
```bash
DISPLAY=:0 killall gnome-keyring-daemon polkit-mate-authentication-agent-1
```

**Step 4 — Capture XI2 events (THE KEY TEST):**
```bash
# Run this, then move mouse and click within the timeout period
DISPLAY=:0 timeout 8 xinput test-xi2 > /tmp/xi2_test.txt 2>&1
# Then check results:
grep -E "RawMotion|RawButton" /tmp/xi2_test.txt
```

**Interpreting results:**
| RawMotion | RawButtonPress | Meaning |
|-----------|---------------|---------|
| Yes | Yes | Software issue (grab, overlay window, compositor) |
| Yes | No | **Hardware failure** — mouse sensor works, button switches dead |
| No | No | Device not attached or driver not loaded |

**IMPORTANT:** `xinput test-xi2` (without `--root`) captures raw device events globally. Using `--root` only captures events delivered to the root window, which misses events consumed by other windows.

**Step 5 — Verify kernel sees the device capabilities:**
```bash
cat /sys/class/input/event10/device/capabilities/ev
# 17 (hex) = EV_SYN + EV_KEY + EV_REL + EV_MSC — means buttons are declared
cat /sys/class/input/event10/device/capabilities/key
# 1f0000 = BTN_LEFT through BTN_EXTRA — buttons are registered
```
If capabilities are present but no button events in Step 4, the micro-switches are physically dead.

**Step 6 — Confirm with synthetic clicks:**
```bash
DISPLAY=:0 xdotool mousemove 500 500 click 1
```
If synthetic clicks work but physical don't = hardware confirmed.

**Step 7 — Final confirmation:** Plug in a different mouse.

---

## NVIDIA driver upgrade notes

**Upgrading from apt-managed to .run installer:**
- The .run installer will refuse if Debian packages are still present
- Must purge ALL nvidia packages: `'*nvidia*' 'libcuda*' 'libnvcuvid*' 'libnvidia*'`
- Also remove leftover files: `/usr/lib/nvidia`, stale `.so` in `/usr/lib/x86_64-linux-gnu/`, NVIDIA alternatives entries, dpkg info fragments
- Use `--no-check-for-alternate-installs` as safety net
- Driver installed via .run is outside apt management — future upgrades are manual

**Checking driver status:**
```bash
nvidia-smi                              # Driver version + GPU info
dmesg | grep -i nvidia                  # Kernel module loading
journalctl -b -p warning | grep nvidia  # Warnings/errors this boot
```

---

## General debugging checklist for "clicks don't work"

1. `pgrep -a Xorg` — only one instance?
2. `xinput list` — devices attached, not floating?
3. `xinput test-xi2` — motion AND button events present?
4. Check for pointer grabs (ungrab + kill suspects)
5. Check Xorg log: `grep -iE 'EE|error|grab' /var/log/Xorg.0.log`
6. Check logind: `loginctl list-sessions` + `loginctl session-status`
7. If motion works but no buttons in xi2 — **try a different mouse**
