# Setup main menu
# Check/Run other setup scripts
# TODO
# - 

show_main_menu()
{
	clear
	printf "Setup Main menu \n--------------\n"
	printf "select setup option or x to exit \n 1) Hardware \n 2) NFS \n 3) SSH - Shared keys \n 4) OpenMPI \n 5) OpenCV \n 6) OpenCL \n 7) Update setup \n 8) Update system \n"
}

usrname=$(logname)
export usrname

show_main_menu
read -p "Select option or x to exit: " n

while [ $n != "x" ]; do
	case $n in
		1) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_hardware.sh;;
		2) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_nfs.sh;;
		3) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_ssh_keys.sh;;
		4) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_openmpi.sh;;
		5) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_opencv.sh;;
		6) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_opencl.sh;;
  		7) sh /home/$usrname/.pisetup/rpi-home/rpi_setup_git_pull_setup.sh;;
    		8) sh rpi_setup_update_system.sh;;
		*) read -p "invalid option - press enter to return to menu" errkey;;
	esac
	show_main_menu
	read -p "Select option or x to exit: " n
done
