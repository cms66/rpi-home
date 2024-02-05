clear
printf "System summary \n--------------\n"
if [ $osarch = "64" ]
then
	echo "64 bit"
else
	echo "32 bit"
fi
printf "Firewall: "
ufw status
read -p "Press enter to return to menu" input
