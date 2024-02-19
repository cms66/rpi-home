# Setup SSH Private/Public keys (required for MPI)
#
show_ssh_key_menu()
{
	clear
	printf "SSH Private/Public key setup menu \n----------------\n"
	printf "select setup option or x to exit \n 1) Remove keys on server \n 2) Create keys on server \n 3) Add host to hosts file on server  \n 4) Add server to hosts file on host \n 5) Add server to host (share user pub key) \n 6) Remove known host \n"
}

# 1- Remove keys on server
remove_server_keys()
{
	rm -f /etc/ssh/ssh_host_*
	echo "Default server keys removed from /etc/ssh \n"
	read -p "Server keys removed, press enter to return to menu" input
}

# 2 - Generate keys on MPI server - run once
# - TODO
# -- Modify /etc/ssh/sshd_config to use new keys **
# -- Check for existing keys
# -- Read hostname
# -- Give options for rsa/dsa/ecdsa
create_server_keys()
{
	# Create keys for user
	mkdir -p $usrpath/.ssh
	su -c "ssh-keygen -t ecdsa -f $usrpath/.ssh/id_ecdsa -P \"\"" multipi
	chown -R $usrname:$usrname $usrpath/.ssh
	#sed -i "s/root@/$usrname@/g" $usrpath/.ssh/id_ecdsa.pub
	# Modify SSHD config to use created keys
	echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
	echo "HostKey $usrpath/.ssh/id_ecdsa" >> /etc/ssh/sshd_config
	service sshd restart
	read -p "Server keys generated for $usrname, press enter to return to menu" input
}

# 3 - Add host to server hosts file
add_host_to_server()
{
	# Add host to server hosts file
	read -p "Which node in Pi cluster do you want to add? - integer only: " clientnum
	read -p "IP address: " clientip
	echo "$clientip  pinode-$clientnum.local pinode-$clientnum" >> /etc/hosts
}

# 4 - Add server to hosts file on host
add_server_to_host()
{
	# Add server to hosts file on host
	read -p "What node is the server? - integer only: " servernum
	read -p "IP address: " serverip
	echo "$serverip  pinode-$servernum.local pinode-$servernum" >> /etc/hosts
}

# 5 - Share server pub key with host
add_server_key_to_host()
{
	# Setup SSH/ECDSA keys on client
	read -p "Which node in Pi cluster do you want to share pub key with? - integer only: " clientnum	
	ssh-copy-id -i $usrpath/.ssh/id_ecdsa.pub $usrname@pinode-$clientnum
	ssh $usrname@pinode-$clientnum
	read -p "$usrname@pinode-$clientnum ($clientip) setup done, press any key to continue" input
}

# 6 - Remove old root known)hosts for host
remove_known_host()
{
	read -p "Which node in Pi cluster do you want to remove from known_hosts? - integer only: " clientnum
	ssh-keygen -f "/root/.ssh/known_hosts" -R "pinode-$clientnum"
}

show_ssh_key_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) remove_server_keys;;
	    2) create_server_keys;;
	    3) add_host_to_server;;
	    4) add_server_to_host;;
	    5) add_server_key_to_host;;
	    6) remove_known_host;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_ssh_key_menu
	read -p "Select option or x to exit to main menu: " n
done
