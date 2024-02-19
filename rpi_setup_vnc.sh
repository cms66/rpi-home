show_vnc_menu()
{
	clear
	printf "VNC setup menu \n----------\n\
 1) Setup Server \n\
 2) Setup Client \n"
}

show_vnc_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) setup_server;;
	    2) setup_client;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_vnc_menu
	read -p "Select option or x to exit to main menu: " n
done
read -p "VNC setup done, press enter to return to menu" input
