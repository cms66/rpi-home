# First boot - Base setup
# Assumes
# - rpi imager used to configure user/hostname
# Sudo run this script as created user
# TODO
# - Rebuild local.tgz with more generic structure

usrname=$(logname)
# Install/update software
apt-get -y update
apt-get -y upgrade
apt-get -y install python3-dev gcc g++ gfortran libraspberrypi-dev libomp-dev git-core build-essential cmake pkg-config make screen htop stress zip nfs-common

# Git setup
mkdir /home/$usrname/.pisetup
cd /home/$usrname/.pisetup
git clone https://github.com/cms66/rpi-home.git

# Add bash alias for setup and test menu
#echo "alias mysetup=\"sudo sh ~/.pisetup/rpi_setup_menu.sh\"" >> /home/$usrname/.bashrc
#echo "alias mytest=\"sudo sh ~/.pisetup/rpi_test_menu.sh\"" >> /home/$usrname/.bashrc

# - Create python Virtual Environment (with access to system level packages) and bash alias for activation
#python -m venv --system-site-packages /home/$usrname/.venv
#echo "alias myvp=\"source ~/.venv/bin/activate\"" >> /home/$usrname/.bashrc
#chown -R $usrname:$usrname /home/$usrname/.venv
