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
  echo "IOTBit 3G HAT is not detected."
  echo "Please reseat the HAT or change USB cables."
  echo $SPACING
  echo $SPACING
  exit 1
else
  sudo lsusb | grep $Manufacturer
  echo "IOTBit 3G Hat is Detected"
  echo $SPACING
  echo $SPACING
fi

# Changing permissions for driver package.
sudo chmod u+x IOTBit_Install.sh

# Installing the driver.
echo "Starting to Install Drivers"
echo "This will take about 10-30 minutes depending on network speeds."
sudo ./IOTBit_Install.sh


Driver=GobiSerial
DETECT_DRIVER=$(modinfo $Driver)
if [[ $DETECT_DRIVER = "" ]]
then
  echo "ERROR: Driver Installation has failed."
  echo "Please take a look at the README in this folder to help setup the 3G HAT."
  exit 1
fi

echo $SPACING
echo $SPACING
echo "Driver has sucessfully been installed."
echo "After reboot, please run the DialSetup.sh bash script."
echo "Rebooting in 60 seconds."
sleep 1m
echo "Rebooting"
sleep 5
sudo reboot
