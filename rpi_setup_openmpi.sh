# OpenMPI
# TODO
# - Firewall rules for Server install

# From version 5 32 bit OS is not supported
# Latest versions
url32=https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz
url64=https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.2.tar.gz
ver32="4.1.6"
ver64="5.0.2"
if [ $osarch = "64" ]
then
	downlink=$url64
 	instver=$ver64
else
	downlink=$url32
	instver=$ver32
fi
show_mpi_menu()
{
	clear
	printf "MPI setup menu \n----------\n"
	printf "select setup option or x to exit \n 1) Build/install - local \n 2) Build/install - server \n 3) Install - client \n"
}

# 1 - Build/install local
install_local()
{
	cd $usrpath
	wget $downlink
	tar -xzf openmpi*.tar.gz
	cd openmpi-$instver
	./configure
	cores=$(nproc)
	if [ $cores -gt 1 ]
	then
		((cores=$cores-1))
	else
		cores=1
	fi
	echo "cores for make: $cores"
	make -j$cores all
	make install	
	ldconfig	
	cd $usrpath
	rm -rf openmpi*
	mpirun --version
	read -p "OpenMPI $instver - Local install finished, press enter to return to menu" input
}

# 2- Build/install on server
install_server()
{
	cd $usrpath
	wget $downlink
	tar -xzf openmpi*.tar.gz
	cd openmpi-$instver
	./configure
	cores=$(nproc)
	if [ $cores -gt 1 ]
	then
		((cores=$cores-1))
	else
		cores=1
	fi
	echo "cores for make: $cores"
	make -j$cores all
	make install
 	if grep -F "/usr/local" "/etc/exports"; then
  		echo "export exists"
  	else
		echo "/usr/local $localnet(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
	fi
 	exportfs -ra
	ldconfig
	cd $usrpath
	rm -rf openmpi*
	mpirun --version
 	ufw allow from $localnet to $localnet
	read -p "OpenMPI $instver - Server install finished, press enter to return to menu" input
}

# 3- Install to run from server
install_client()
{
	read -p "Remote node (integer only): " nfsrem
	read -p "Full path to remote directory (press enter for default = /usr/local): " userdir
	nfsdir=${userdir:="/usr/local"}
	mkdir -p $nfsdir
 	if grep -F $nfsdir "/etc/fstab"; then
  		echo "mount already exists"
    	else
		echo "pinode-$nfsrem.local:$nfsdir $nfsdir    nfs defaults" >> /etc/fstab
  	fi
	mount -a
 	#systemctl daemon-reload
	ldconfig
	mpirun --version
	read -p "OpenMPI $instver - Client install done, press enter to return to menu" input
}

show_mpi_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) install_local;;
	    2) install_server;;
	    3) install_client;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_mpi_menu
	read -p "Select option or x to exit to main menu: " n
done
