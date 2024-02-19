# Security menu
# - SSH
# - VNC

show_security_menu()
{
	clear
	printf "Security setup menu \n----------\n\
 1) Setup SSH keys \n\
 2) Setup VNC \n"
}

show_security_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) sh $usrpath/.pisetup/rpi-home/rpi_setup_ssh_keys.sh;;
	    2) sh $usrpath/.pisetup/rpi-home/rpi_setup_vnc.sh;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_nfs_menu
	read -p "Select option or x to exit to main menu: " n
done
read -p "System security updated, press enter to return to menu" input
