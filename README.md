# rpi-home

## Quick instructions
These instructions assume:
 - OS version is bookworm.
 - Windows computer used for preparation and connection to RPi.
 - Headless build (i.e no monitor/keyboard connected) so setup via ssh.
 - Raspberry Pi Imager used for SD card imaging (https://downloads.raspberrypi.org/imager/imager_latest.exe).

### Prepare SD card
 - Set Hostname
 - Set Username/password
 - Set WiFi only if it will be needed
 - Set ssh
 - (optional) right click on SD card drive labelled "bootfs" and rename to hostname of RPi.
 - Download "rpi_setup_base.sh" and copy to SD card drive (after imaging is complete).
 
### First boot
