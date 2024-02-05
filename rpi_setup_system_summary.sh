clear
printf "System summary \n--------------\n"
printf "Arch = $osarch\n"
printf "Firewall: "
ufw status
read -p "Press enter to return to menu" input
