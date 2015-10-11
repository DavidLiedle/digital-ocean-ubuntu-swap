#!/usr/bin/env bash
################################################################################
# Set up swap on a DigitalOcean Ubuntu droplet
# as described in this tutorial:
# https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04
#

echo
echo "Setting up swap at /swapfile (4GB)"
echo

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

sudo sysctl vm.swappiness=10
sudo echo "vm.swappiness=10" >> /etc/sysctl.conf

sudo sysctl vm.vfs_cache_pressure=50
sudo echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

echo
echo "DONE! You should see swap in use now:"
free -m

echo "Swappiness should now be 10:"
cat /proc/sys/vm/swappiness

echo "Cache pressure should be set to 50:"
cat /proc/sys/vm/vfs_cache_pressure

echo "We've edited /etc/sysctl.conf by adding two lines to the end of the file"
echo "which should cause these new settings to persist across reboots."
echo
echo "All done!"
echo
