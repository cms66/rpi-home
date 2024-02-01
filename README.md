# rpi-home
## The rpi-home project
More detailed instructions and information about the project are available [here](../../wiki/).
## Quick instructions
These instructions assume:
 - OS version is bookworm.
 - Headless build (i.e no monitor/keyboard/mouse connected) so setup via ssh. 
 - Windows computer used for preparation and connection to RPi.
 - Raspberry Pi Imager used for SD card imaging (https://downloads.raspberrypi.org/imager/imager_latest.exe).

### Prepare SD card
#### Raspberry Pi Imager
 - Set Hostname
 - Set Username/password
 - Set WiFi only if it will be needed (use 2.4 GHz)
 - Enable ssh
#### Modification
 - Download (right click and select "Save link as") [rpi_setup_base.sh](https://github.com/cms66/rpi-home/raw/main/rpi_setup_base.sh) and copy to SD card drive labelled "bootfs".
 - (optional) right click on SD card drive labelled "bootfs" and rename to hostname of RPi.
 
### First boot
- Login via ssh as the user created during imaging and run initial setup
<pre><code>sudo sh /boot/firmware/rpi_setup_base.sh</code></pre>
  - Select option to apply changes
      - Poweroff (recommended for multiple RPi scenario) to setup a static/reserved IP address on router (using MAC address noted earlier) or
      - Reboot (simple setup for a single RPi)
