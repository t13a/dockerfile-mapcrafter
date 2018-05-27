#!/bin/bash

set -euo pipefail

SOURCE_URL="https://packages.mapcrafter.org/debian"
SOURCE_CODENAME="jessie"
SOURCE_PATH="/etc/apt/sources.list.d/mapcrafter.list"
KEYRING_URL="https://packages.mapcrafter.org/debian/keyring.gpg"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install apt-transport-https imagemagick python sudo wget

echo "deb ${SOURCE_URL} ${SOURCE_CODENAME} main" > "${SOURCE_PATH}"
wget -qO - "${KEYRING_URL}" | apt-key add -

apt-get update
apt-get -y install mapcrafter

apt-get clean
