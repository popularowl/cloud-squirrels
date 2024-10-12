#!/bin/sh

# setup the new virtual mashine
# for this foundation project we just update packages and install Docker CE
apt update &&

apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt -y install docker-ce &&

echo "All done. Welcome to your new virtual server!"