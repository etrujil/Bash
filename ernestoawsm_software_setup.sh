#!/bin/bash
# Written by Ernesto Trujillo
# Notes on installing GDAL and TauDEM
# following instruction from:
# http://hydrology.usu.edu/taudem/taudem5/downloads.html
# and
# https://gdal.org/download.html#past-releases
# https://github.com/domlysz/BlenderGIS/wiki/How-to-install-GDAL
# ------------------------------------------------------------------------------
# To get the latest GDAL/OGR version, add the PPA to your sources, then install the gdal-bin package (this should automatically grab any necessary dependencies, including at least the relevant libgdal version).
sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
# Once you add the repository, go ahead and update your source packages.
sudo apt-get update
# Now you should be able to install the GDAL/OGR package.
sudo apt-get install gdal-bin
# To verify the installation, you can run ogrinfo --version.
ogrinfo
# ------------------------------------------------------------------------------
# Install GDAL for Python
# Before installing the GDAL Python libraries, you’ll need to install the GDAL development libraries.
sudo apt-get install libgdal-dev
# You’ll also need to export a couple of environment variables for the compiler.
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
# Now you can use pip to install the Python GDAL bindings.
# pip3 install GDAL # This fails for me
# sudo apt-get install -y libblas-dev libatlas-base-dev
# sudo apt-get install -y python3-dev
# sudo apt-get install -y build-essential libssl-dev libffi-dev
# sudo apt-get install -y lib32ncurses5-dev
# All pip install stuff failed
# Install this too
sudo apt update
sudo apt upgrade
sudo apt install build-essential
# ------------------------------------------------------------------------------
# for taudem
sudo apt install libblacs-mpi-dev
mkdir --parents ~/Documents/Installation_files
cd ~/Documents/Installation_files/
git clone https://github.com/dtarb/TauDEM.git
cd ./TauDEM/src
# Now a few tricks
# First, after DESTINATION in ../CMakeList.txt (second to last line)
# modify the destination path to /home/ubuntu/Documents/Models/taudem or
# ~/Documents/Models/taudem
# Also, Create the directory structure using
mkdir --parents /home/ubuntu/Documents/Models/taudem
# This would avoid having the issue with permissions for the /usr/bin folder
# Then you can proceed with the installation using
cmake ..
make && make install
# Not done yet, now add the following lines to ~/.bashrc
echo '# Lines added for GDAL and TauDEM' >> ./.bashrc
echo 'export PATH=/usr/bin:$PATH' >> ./.bashrc
echo'export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH'  >> ./.bashrc
echo 'export GDAL_DATA=/usr/share/gdal'  >> ./.bashrc
echo 'export PATH=$HOME/Documents/Models/taudem:$PATH'  >> ./.bashrc
source ~/.bashrc
# I can't recall where I got that info but that's what I have used in my
# previous Installation
# ------------------------------------------------------------------------------
# Now Docker and docker-compose
# First uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"
# 'bionic' is the distribution in the instance, you can check using
# $ lsb_release -cs
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
docker run -it ubuntu bash
#Check that docker works with the test line above
# Now, docker-compose
pip3 install --user docker-compose
# Note that this system has pip3 intalled, not pip, so always use pip3 unless
# you desire otherwise. In that case, install pip
echo $PATH
# Check that /home/ubuntu/.local/bin is in PATH, otherwise run
# add the path. Option one is by adding the line
# export PATH="$PATH:$HOME/.local/bin"
# to ~/.profile, and then source that file
