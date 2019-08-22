#!/bin/bash
# Written by Ernesto Trujillo
# following instruction from:
# https://medium.com/@sh.tsang/partitioning-formatting-and-mounting-a-hard-drive-in-linux-ubuntu-18-04-324b7634d1e0
# and
# https://help.ubuntu.com/community/InstallingANewHardDrive
# ------------------------------------------------------------------------------
# Examine drive properties and check what the mounting name/dir is by using:
# $ sudo fdisk -l
# The name for the volume in openstach for this specific code is:
# /dev/vdb
# VOLUME_NAME = "/dev/vdb"
sudo fdisk /dev/vdb
# Then enter 'n', then 'p' for primary, then '1' for 1 partition, then enter and center
# Then Enter 'w' to write the partition table to disk

# Then Format the newly partitioned harddisk
# sudo mkfs.ext4 /dev/vdb
sudo mkfs -t ext4 /dev/vdb1

# Mount drive
# First, create directory to mount to
sudo mkdir -pv /data
# the options -p, --parents and -v, --verbose are not really necessary
# now, add this line to the etc/fstab file (type 'man fstab' for info)
# /dev/vdb1 /data ext4 defaults 0 0
echo "/dev/vdb1 /data ext4 defaults 1 2" >> /etc/fstab
# Last line follows what the guys at ARS have in their template, with 1 2 at the end
sudo mount /data
chown -R ubuntu:ubuntu /data
