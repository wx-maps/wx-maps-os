#!/usr/bin/env bash

###
### Script to setup a new raspi.
### This isn't really designed for off the shelf
### use but with a little work it could be useful
### script to setup a new raspi for anyone
###

### !!! Before running !!!
###
### Ensure you have the WIFI_NAME and WIFI_PASS variables
### assigned via CLI or .profile etc.
###

set -euo pipefail

DEVICE=/dev/mmcblk1
IMAGE=${HOME}/Downloads/2020-05-27-raspios-buster-lite-armhf.zip

MOUNT_POINT=/mnt
SSH_PATH=${MOUNT_POINT}/ssh
WPA_SUPPLICANT_PATH=${MOUNT_POINT}/wpa_supplicant.conf

if [[ ! -f $IMAGE ]]; then
  echo "Image $IMAGE not found"
  exit 1
fi
unzip -p $IMAGE | sudo dd of=${DEVICE} bs=4M status=progress conv=fsync

sudo mount ${DEVICE}p1 $MOUNT_POINT
sudo touch ${SSH_PATH}

sudo cat <<-EOF | sudo tee ${WPA_SUPPLICANT_PATH}
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
 ssid="$WIFI_NAME"
 psk="$WIFI_PASS"
}
EOF

sudo umount ${MOUNT_POINT}
