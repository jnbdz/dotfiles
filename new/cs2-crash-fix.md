# Cities: Skylines II - Crash on Save Load Fix

**Date:** 2026-04-08
**Game version:** 1.5.6f1 (234.38189)
**System:** Kali Linux, NVIDIA RTX 4070 Ti (12GB), Intel i9-14900KF, 64GB RAM
**Proton:** 10.1 (broken) -> Experimental (fixed)
**NVIDIA Driver:** 595.58.03

## Symptoms

- Game crashes to desktop immediately after loading any saved game
- No error dialog — game just silently closes
- Affects all saves (24-43MB), not save-specific
- No mods installed
- 7 crash dumps generated over 2 days (~167MB each)

## Investigation

### 1. Game Logs

**Path:** `~/.local/share/Steam/steamapps/compatdata/949230/pfx/drive_c/users/steamuser/AppData/LocalLow/Colossal Order/Cities Skylines II/`

- `Player.log` — showed no explicit error, just stopped mid-output (typical of native crash)
- `Logs/SceneFlow.log` — confirmed loading completed successfully before crash
- No GPU errors (Xid), OOM kills, or segfaults in `dmesg` or `journalctl`

### 2. Initial Hypotheses (All Ruled Out)

| Hypothesis | Test | Result |
|---|---|---|
| VRAM exhaustion | Lowered all graphics to Medium | Still crashed |
| GPU driver fault | Checked dmesg for Xid errors | None found |
| CPU P/E-core scheduling | `taskset -c 0-15 %command%` | Still crashed |
| Stale Burst cache | Cleared `.cache` directory | Still crashed |
| Vulkan rendering | `-force-vulkan` launch option | "InitializeEngineGraphics failed" (conflicts with Proton DXVK) |
| Mod conflicts | Checked `content_load.json` | No mods installed |
| Save corruption | Multiple saves tested | All crash identically |

### 3. Enabling Proton Logging

Added to Steam launch options:
```
PROTON_LOG=1 DXVK_LOG_LEVEL=info taskset -c 0-15 %command%
```

This generates `~/steam-949230.log` with Wine/DXVK debug output.

### 4. Root Cause Found

Searching the Proton log for exceptions:
```bash
grep "Exception 0x" ~/steam-949230.log
```

Revealed:
```
Exception 0xc0000005 (EXCEPTION_ACCESS_VIOLATION) addr=00006FFFEDBE193D
```

Full backtrace:
```
lib_burst_generated.dll + 0x193D        <- crash site
lib_burst_generated.dll + 0x1B0544      <- Burst job system
lib_burst_generated.dll + 0x1B0458
lib_burst_generated.dll + 0x1B0EE0
lib_burst_generated.dll + 0x35BE1E7     <- Burst scheduler
UnityPlayer.dll + 0x57EA26              <- Unity job worker thread
UnityPlayer.dll + 0x57ED42
UnityPlayer.dll + 0x57AAE2
UnityPlayer.dll + 0x57B3EB
UnityPlayer.dll + 0x57B479
UnityPlayer.dll + 0x6B9D6C
```

**`lib_burst_generated.dll`** is Unity's Burst compiler output — JIT-compiled native code for the game's Entity Component System (ECS) simulation. The crash was deterministic (same offset `0x193D` every time), indicating a Proton 10.1 Wine runtime incompatibility with Unity Burst's generated code.

## Fix

Switch from **Proton 10.1** to **Proton Experimental**:

1. Right-click Cities: Skylines II in Steam
2. Click **Properties**
3. Go to **Compatibility** tab
4. Check **"Force the use of a specific Steam Play compatibility tool"**
5. Select **Proton Experimental**
6. Launch the game

### Recommended Launch Options

```
taskset -c 0-15 %command%
```

- `taskset -c 0-15` — restricts game to P-cores only on the i9-14900KF (optional but may improve stability)

## Key File Locations

| File | Purpose |
|---|---|
| `~/.local/share/Steam/steamapps/compatdata/949230/` | Proton prefix for CS2 |
| `.../AppData/LocalLow/Colossal Order/Cities Skylines II/Player.log` | Main game log |
| `.../Cities Skylines II/Player-prev.log` | Previous session log |
| `.../Cities Skylines II/Logs/SceneFlow.log` | Loading/scene flow log |
| `.../Cities Skylines II/Logs/Modding.log` | Mod loading log |
| `.../Cities Skylines II/.cache/backtrace/crashpad/reports/` | Crash dump files (.dmp) |
| `~/steam-949230.log` | Proton/Wine log (when PROTON_LOG=1) |
| `.../Cities Skylines II/content_load.json` | Enabled mods/DLC list |
| `.../Cities Skylines II/launcher-settings.json` | Display/resolution settings |

## Useful Debug Commands

```bash
# Enable Proton logging (Steam launch options)
PROTON_LOG=1 DXVK_LOG_LEVEL=info %command%

# Search for crashes in Proton log
grep "Exception 0x" ~/steam-949230.log

# Get crash backtrace
grep -A20 "Exception 0xc0000005" ~/steam-949230.log | grep "backtrace:"

# Check for GPU errors
dmesg --time-format iso | grep -i "xid\|nvrm\|gpu.*error\|fault"

# Check system logs around crash time
journalctl --since "2026-04-08 14:00" --until "2026-04-08 14:10" | grep -i "nvidia\|oom\|kill\|segfault\|cities\|wine"

# Check VRAM usage
nvidia-smi

# Clear Burst cache and crash dumps
rm -rf "$HOME/.local/share/Steam/steamapps/compatdata/949230/pfx/drive_c/users/steamuser/AppData/LocalLow/Colossal Order/Cities Skylines II/.cache"

# Check installed Proton versions
ls "$HOME/.local/share/Steam/steamapps/common/" | grep -i proton

# Check current Proton version for CS2
cat "$HOME/.local/share/Steam/steamapps/compatdata/949230/version"
```
