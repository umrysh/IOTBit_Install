#!/bin/bash
Driver=GobiSerial
DETECT_DRIVER=$(lsmod | grep $Driver)
if [[ $DETECT_DRIVER = "" ]]
then
  echo "ERROR: Driver Installation has failed."
  echo "Please take a look at the README in this folder to help setup the 3G HAT."
  exit 1
fi

# Editing WVDIAL Configuration Files
echo $SPACING
echo $SPACING
echo "Driver has been installed properly! :)"
echo $SPACING
sudo mv /etc/wvdial.conf /etc/wvdial.conf.bak
sudo mv wvdial.conf /etc/wvdial.conf
sudo wvdialconf /etc/wvdial.conf
echo $SPACING
echo $SPACING

# Changing Serial Port Zero Permissions
echo "Changing Serial Port Zero Permissions"
sudo chmod u+x /dev/ttyS0
