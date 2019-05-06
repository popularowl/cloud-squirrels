#!/bin/sh

# setup the new virtual mashine
# for this foundation project we just update packages and install Docker CE
apt update &&

apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt-cache policy docker-ce
apt -y install docker-ce &&

# start the wiremock-slim container
run -d --name just-mock -p 80:8080 popularowl/wiremock-slim:2.23.2

# provision the mock mappings
#provisionMocks.py

echo "All done. Welcome to your new virtual server!"