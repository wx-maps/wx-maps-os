#!/usr/bin/env bash

REPO=https://github.com/ajfisher/node-pixel
ARDUINO_MODEL=nano

INTERCHANGE=$(which interchange)

###
### Script to help flash the wxmaps arduino
###

set -euo pipefail

if [[ -z $INTERCHANGE ]]; then
  echo 'nodebots interchange not found'
  echo 'install with "node install -G nodebots-interchange"'
  exit 1
fi

$INTERCHANGE install git+${REPO} -a $ARDUINO_MODEL --firmata

