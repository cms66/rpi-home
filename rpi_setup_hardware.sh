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
    	5) Arduino - USB \n 6) Arduino I2C \n 7) GPS \n 8) TFT LCD \n 9) Calibrate display \n 10) Bluetooth \n 11) Robotic arm \n 12) DVB TV Hat \n 13) Audio (for Desktop image) \n 14) Arduino Libraries \n 15) Pressure sensor \n 16) Setup I2C \n 16) Setup GPS - PA1010D \n"
}
