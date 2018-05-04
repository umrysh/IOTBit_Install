Driver=GobiSerial
DETECT_DRIVER=$(lsmod | grep $Driver)
if [[ $DETECT_DRIVER = "" ]]
then
  echo "ERROR: Driver Installation has failed."
  echo "Please take a look at the README in this folder to help setup the 3G HAT."
  exit 1
fi

#Editing WVDIAL Configuration Files
echo $SPACING
echo $SPACING
echo "Driver has been installed properly! :)"
echo "Proceeding to customize wvidal config files."
echo $SPACING
echo "What APN does your mobile carrier use? (Make sure it is used for data plans.)"
read APN
sudo sed -i .bak "s/YOUR.SIMCARD_APN.HERE/$APN/" *wvdial*
sudo mv /etc/wvdial.conf /etc/wvdial.conf.bak
sudo mv wvdial.conf /etc/wvdial.conf
sudo wvdialconf /etc/wvdial.conf

# Changing permissions for S0 serial port.
sudo usermod -a -G /dev/ttyS0 pi
echo $SPACING
echo $SPACING

# Final message before shutdown
echo "Driver has been installed and the configuration files have been set."
echo "After reboot, please run the DialSetup.sh bash script."
echo "Rebooting in 60 seconds."
sleep 1m
echo "Rebooting"
sleep 5
sudo reboot
