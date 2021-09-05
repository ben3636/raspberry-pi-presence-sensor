#!/bin/bash
current_hour=$(date +%R | awk -F ':' ' { print $1 } ')
ping=$(sudo l2ping -i hci0 BLUETOOTH_MAC_ADDRESS_HERE -c 10)
if [[ $current_hour -ge 8 ]] && [[ $current_hour -lt 22 ]]
then
	if [[ $ping == *"bytes from"* ]]
	then
		echo "Ben is home"
		 vcgencmd display_power 1
	else
		echo "Ben is away"
		 vcgencmd display_power 0
	fi
fi
