# switch_display
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
