#!/bin/sh
OUT="$HOME/gui-diagnose.txt"

echo "=== GUI Freeze Diagnosis ===" > "$OUT"
echo "Date: $(date)" >> "$OUT"
echo "" >> "$OUT"

echo "=== Active Window ===" >> "$OUT"
xdotool getactivewindow getwindowname >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "=== Active Window Property ===" >> "$OUT"
xprop -root | grep -i active >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "=== Top CPU Processes ===" >> "$OUT"
ps aux --sort=-%cpu | head -20 >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "=== Top Memory Processes ===" >> "$OUT"
ps aux --sort=-%mem | head -20 >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "=== Window List ===" >> "$OUT"
wmctrl -l >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "=== X Input Grabs ===" >> "$OUT"
xinput list >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "Output saved to $OUT"
