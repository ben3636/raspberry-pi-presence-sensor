#!/bin/bash
# Add me to a cron job for every 5 mins :)

# Get quiet hours and do not run if current time is within that period
current_hour=$(date +%R | awk -F ':' ' { print $1 } ')

# Ping the Bluetooth Device
ping=$(sudo l2ping -i hci0 BLUETOOTH_MAC_ADDRESS_HERE -c 10)

# If the device is reachable, turn/leave the display on, turn it off if not
if [[ $current_hour -ge 8 ]] && [[ $current_hour -lt 22 ]]
then
	if [[ $ping == *"bytes from"* ]]
	then
		echo "User is home"
		 vcgencmd display_power 1
	else
		echo "User is away"
		 vcgencmd display_power 0
	fi
fi
