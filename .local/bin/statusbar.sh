#!/bin/sh

# Initialize the last update time as -1 hour or -2 hours for variables that need it
last_weather_update=$(date +%s --date='-1 hour')
last_package_update=$(date +%s --date='-2 hours')
last_disk_update=$(date +%s --date='-1 hour')
last_memory_update=$(date +%s --date='-1 minute')

update_weather() {
    WEATHER=$(./statusbar/sb-forecast)
    last_weather_update=$(date +%s)
}

update_packages() {
    PACKAGE_STATUS=$(./statusbar/sb-aptpackages)
    last_package_update=$(date +%s)
}

update_disk() {
    DISK=$(./statusbar/sb-disk)
    last_disk_update=$(date +%s)
}

update_memory() {
    MEMORY=$(./statusbar/sb-memory)
    last_memory_update=$(date +%s)
}

while true; do
    # Always update time
    CLOCK=$(./statusbar/sb-clock)
    BATTERY=$(./statusbar/sb-battery)
    CPUBARS=$(./statusbar/sb-cpubars)
    
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

    # Update memory if it has been a minute
    if [ $(($current_time - $last_memory_update)) -ge 60 ]; then
        update_memory
    fi
    
    # Set the root window name to update the status bar
    xsetroot -name " $WEATHER | $CPUBARS $MEMORY $DISK $PACKAGE_STATUS $BATTERY | $CLOCK"
    
    # Sleep for 10 seconds before updating again
    sleep 1
done
