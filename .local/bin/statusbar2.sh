#!/bin/sh
while true; do
    # Same content as before
    #TIME=$(date "+%Y-%m-%d %H:%M")
    CLOCK=$(./statusbar/sb-clock)
    #WEATHER=$(curl -s 'wttr.in/montreal?format=1')
    WEATHER=$(./statusbar/sb-forecast)
    PACKAGE_STATUS=$(./statusbar/sb-aptpackages)
    DISK=$(./statusbar/sb-disk)
    xsetroot -name "$DISK | $PACKAGE_STATUS | $WEATHER | $CLOCK"
    
    # Update every minute
    sleep 60
done
