# Hardware setup
# TODO
# - Check for attached devices and configs for previous devices
# - Enable port on firewall for multiple camera streams
# - Check RPi model for GPS setup
# - Create setup options for GPS using UART/I2C/SPI
# - Use GPIO pins for fan/cooling

# 1 CSI Camera
# 2 USB Camera
# NVMe drive

show_hardware_menu()
{
	clear
	printf "Hardware setup menu \n------------------\n\
1) CSI Camera \n\
2) USB Camera \n\
3) Sense Hat \n\
4) Calibrate Sense Hat \n\
5) Arduino - USB \n\
6) Arduino I2C \n\
7) GPS \n\
8) TFT LCD \n\
9) Calibrate display \n\
10) Bluetooth \n\
11) Robotic arm \n\
12) DVB TV Hat \n\
13) Audio (for Desktop image) \\
14) Arduino Libraries \n\
15) Pressure sensor \n\
16) Setup I2C \n\
17) Setup GPS - PA1010D \n\
18) Setup NVME drive \n"
}

# 1 CSI Camera - Works - requires reboot
setup_cam_csi()
{
 	apt-get -y install python3-picamera2 --no-install-recommends	
	read -p "CSI camera setup done, press enter to return to menu" input	
}

# 18 NVME drive
setup_nvme()
{
	# Identify NVME drive
	nvmedrv=$(parted -l | grep 'Disk.*nvme' | awk '{print $2}' | sed 's/://')
 	# Create GPT partition table
 	parted $nvmedrv mklabel gpt
  	# Create ext4 partition
   	parted $nvmedrv mkpart nvme-part ext4 1 100%
    	# Format partition
	nvmeprt=$(sfdisk -l $nvmedrv | grep 'filesystem' | awk '{print $1}')
 	mkfs.ext4 -L nvme-data $nvmeprt
  	# Create mount point and fstab entry for automount
   	nvmeuid=$(lsblk -o NAME,PARTUUID | grep nvme | awk '{print $2}')
   	mkdir /mnt/nvme
    	echo "PARTUUID=$nvmeuid	/mnt/nvme	ext4	defaults,noatime	0	0" >> /etc/fstab
   	#echo "dtparam=pciex1_gen=3" >> /boot/firmware/config.txt
 	read -p "NVME drive - $nvmedrv setup done, press enter to return to menu" input
}

show_hardware_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
		1) setup_cam_csi;;
		2) setup_cam_usb;;
		3) setup_sense_hat;;
		4) calib_sense_hat;;
		5) setup_arduino_usb;;
		6) setup_arduino_i2c;;
		7) setup_gps;;
		8) setup_tft_lcd;;
		9) calib_display;;
		10) setup_bluetooth;;
		11) setup_robot_arm;;
		12) setup_dvb_tv;;
		13) setup_audio_desktop;;
		14) setup_arduino_libs;;
		15) setup_pressure_sensor;;
  		16) setup_i2c;;
    		17) setup_PA1010D;;
    		18) setup_nvme;;      
		*) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_hardware_menu
	read -p "Select option or x to exit to main menu: " n
done
