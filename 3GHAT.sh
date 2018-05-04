#!/bin/bash
# IOTBit 3G HAT Driver Installation Script by Mahen Krishnakumar

SPACING=""

echo $SPACING
echo $SPACING

# Grabbing Kernel Version
KERNEL=$(uname -r)
KMV_VAR=${KERNEL%.*}

# Kernel Version Extraction inspired from jdf and Etan Reisner
# https://stackoverflow.com/questions/30856609/extract-minor-version-from-kernel-to-bash-variable
# Version Regular Expression inspired from jlliagre and Dougnukem
# https://stackoverflow.com/questions/6245293/extract-version-number-from-file-in-shell-script

if ! [ $KMV_VAR == "4.4" ]
then
  echo "Incompatible Linux Kernel Detected."
  echo "Please install a distribution of Linux with Kernel 4.4."
  echo "Please flash your SD card with Raspbian Jessie 2016-11-29 Release."
  echo "You can download the image from here: http://downloads.raspberrypi.org/raspbian/images/raspbian-2016-11-29/"
  echo "Setup is aborting."
  echo $SPACING
  echo $SPACING
  exit 1
fi

# Checking if the HAT is ready to connect.
Manufacturer="Qualcomm"
DETECT_USB=$(sudo lsusb | grep $Manufacturer)
if [[ $DETECT_USB = "" ]]
then
  echo "3G HAT is not detected. Please reseat the HAT or change USB cables."
  echo $SPACING
  echo $SPACING
  exit 1
else
  sudo lsusb | grep $Manufacturer
  echo "IOTBit Hat is Detected"
fi

# # Changing permissions for driver package.
# sudo chmod u+x IOTBit_Install.sh
#
# # Installing the driver.
# echo "Starting to Install Drivers"
# echo "This will take about 10-30 minutes depending on network speeds."
# sudo ./IOTBit_Install.sh
#
#
# Driver=GobiSerial
# DETECT_DRIVER=lsmod | grep $Driver
# if [[ $DETECT_DRIVER = *$Driver* ]]
# then
#   echo "Driver has been installed properly! :)"
#   echo "Proceeding to customize wvidal config files."
#   echo $SPACING
#   sudo mv wvdial.config wvdial.bak.config
#   echo "What APN does your mobile carrier use? (Make sure it is used for data plans.)"
#   read APN
#   sudo sed -i .bak "s/YOUR.SIMCARD_APN.HERE/$APN/" *wvdial*
#   sudo mv /etc/wvdial.conf /etc/wvdial.conf.bak
#   sudo mv wvdial.conf /etc/wvdial.conf
#   sudo
