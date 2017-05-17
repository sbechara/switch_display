#!/bin/bash

# switch_display.sh
# Author: Samuel Bechara
# Date created: Sometime in late 2016
# Date last modified: 17 May 2017
# Purpose: this little BASH script allows the user to easily switch
# between a PiTFT (adafruit) display and the HDMI output. It assumes you
# already have the custom adafruit kernel installed for the display

# Installation Instructions: 
# 1) first you have to make the script exectuable by doing
# "chmod +x switch_display.sh" (make sure you are in the same directory
# as the file)
# 2) then move the file to the /usr/bin/bash

# Usage Instructions:
# 1) From a terminal type "sudo switch_display option" (don't use quotes
# and the option refers to either pitft or hdmi depending on what you
# want to switch to

# Note: This script modifies a protected file so it 
# must be called using SUDO

# Store user input into variable called switch
switch=$1
user=$whoami

# Before we start, make sure that the user used "sudo" so that the
# script can modify the file
if [[ $user = "root" ]]; then
	# First, check if they forgot to specifiy a monitor
	if [[ -z "$switch" ]]; then
		echo "Error: user must specifiy which monitor to output to [pitft or hdmi]"
		success=false
	# Second, check for typos
	elif [[ "$switch" != "pitft" ]] && [[ "$switch" != "hdmi" ]]; then
		echo "Error: Invalid input. User must specify [pitft or hdmi] exactly"
		success=false
	# Third, check if they specified the pitft display. if they did, let them
	# know and use sed to appropriately modify the file
	elif [[ "$switch" = "pitft" ]]; then
		echo "User has selected pitft"
		sed -i 's/fb0/fb1/g' /usr/share/X11/xorg.conf.d/99-fbdev.conf
		success=true # flag to see if should run reboot
	elif [[ "$switch" = "hdmi" ]]; then
		echo "User has selected hdmi"
		sed -i 's/fb1/fb0/g' /usr/share/X11/xorg.conf.d/99-fbdev.conf
		success=true
	fi
	# ask to reboot now. Yes or No
	while $success; do
		read -p "You must reboot for changes to take effect. Do you wish to reboot now? (y/n)" yn
		case $yn in
			[Nn]* ) exit;;
			[Yy]* ) reboot;;
			* ) echo "Please answer y or n";;
		esac
	done
else
	echo "Error: Must execute script as sudo."
fi
