#!/bin/sh

# Initialize the last update time as -1 hour or -2 hours for variables that need it
last_weather_update=$(date +%s --date='-1 hour')
last_package_update=$(date +%s --date='-2 hours')
last_disk_update=$(date +%s --date='-1 hour')

update_weather() {
    WEATHER=$(./statusbar/sb-forecast)
    last_weather_update=$(date +%s)
    echo "Update weather"
}

update_packages() {
    PACKAGE_STATUS=$(./statusbar/sb-aptpackages)
    last_package_update=$(date +%s)
    echo "Update packages count"
}

update_disk() {
    DISK=$(./statusbar/sb-disk)
    last_disk_update=$(date +%s)
    echo "Update disk"
}

while true; do
    # Always update time
    CLOCK=$(./statusbar/sb-clock)
    
    # Get the current time in seconds since epoch
    current_time=$(date +%s)
    
    # Update weather if it has been an hour
    if [ $(($current_time - $last_weather_update)) -ge 3600 ]; then
        update_weather
    fi
    
    # Update package status if it has been 2 hours
    if [ $(($current_time - $last_package_update)) -ge 7200 ]; then
        update_packages
    fi

    # Update disk usage if it has been an hour
    if [ $(($current_time - $last_disk_update)) -ge 3600 ]; then
        update_disk
    fi
    
    # Set the root window name to update the status bar
    xsetroot -name "$DISK | $PACKAGE_STATUS | $WEATHER | $CLOCK"
    
    # Sleep for 10 seconds before updating again
    sleep 1
done
