# Pull updates and return to working directory
cd /home/$usrname/.pisetup/rpi-home
git pull https://github.com/cms66/rpi-home
cd $OLDPWD
read -p "Finished update, press enter to return to menu" input
