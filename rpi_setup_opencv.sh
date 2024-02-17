# OpenCV 4.9.0 

show_opencv_menu()
{
	clear
	printf "OpenCV setup menu \n----------\n\
	select setup option or x to exit \n\
	1) Install - Python only \n\
	2) Build/install - local \n\
	3) Build/install - server \n\
	4) Install - client \n"
}

install_python()
{
	source $usrpath/.venv/bin/activate
	pip3 install opencv-python opencv-contrib-python
	deactivate
}

install_local()
{
	cd $usrpath
	# Check memory
	memtot=$(grep MemTotal /proc/meminfo | tr -cd '[:digit:].')
 	if [ $memtot -lt 5800000 ]
	then
		sed -i "s/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g" /etc/dphys-swapfile
		/etc/init.d/dphys-swapfile restart
	fi
	apt-get install libjpeg-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev libcanberra-gtk* libgtk-3-dev libgstreamer1.0-dev gstreamer1.0-gtk3 libgstreamer-plugins-base1.0-dev gstreamer1.0-gl libxvidcore-dev libx264-dev python3-numpy python3-pip libtbbmalloc2 libdc1394-dev libv4l-dev v4l-utils libopenblas-dev libatlas-base-dev libblas-dev liblapack-dev gfortran libhdf5-dev libprotobuf-dev libgoogle-glog-dev libgflags-dev protobuf-compiler 
 	git clone https://github.com/opencv/opencv.git
	git clone https://github.com/opencv/opencv_contrib.git
	mkdir opencv/build
	cd opencv/build
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/home/multipi/opencv_contrib/modules -D ENABLE_NEON=ON -D WITH_OPENMP=ON -D WITH_OPENCL=OFF -D BUILD_TIFF=ON -D WITH_FFMPEG=ON -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_GSTREAMER=ON -D BUILD_TESTS=OFF -D WITH_EIGEN=OFF -D WITH_V4L=ON -D WITH_LIBV4L=ON -D WITH_VTK=OFF -D WITH_QT=OFF -D WITH_PROTOBUF=ON -D OPENCV_ENABLE_NONFREE=ON -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages -D OPENCV_GENERATE_PKGCONFIG=ON -D BUILD_EXAMPLES=OFF ..
	cores=$(nproc)
	make -j$cores all
	make install
	ldconfig
	cd $usrpath
	rm -rf opencv*
	if [ $memtot -lt 5800000 ]
	then
		sed -i "s/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=100/g" /etc/dphys-swapfile
		/etc/init.d/dphys-swapfile restart
	fi
	read -p "OpenCV 4.9.0 - Local install finished, press enter to return to menu" input
}

install_server()
{
	install_local
	if grep -F "/usr/local" "/etc/exports"; then
  		echo "export exists"
  	else
		echo "/usr/local $localnet(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
	fi
 	exportfs -ra
	read -p "OpenCV 4.9.0 - Server install finished, press enter to return to menu" input
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
	read -p "OpenCV - Client install done, press enter to return to menu" input
}

show_opencv_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
		1) install_python;;
		2) install_local;;  
		3) install_server;;
		4) install_client;;
		*) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_opencv_menu
	read -p "Select option or x to exit to main menu: " n
done
