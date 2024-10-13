#!/bin/sh

# setup the new virtual mashine
# for this foundation project we just update packages and install Docker CE
apt update &&

apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt -y install docker-ce &&

# build jenkins container image with default admin user
cd /tmp && docker build -t popularowl/jenkins .

# run newly built jenkins container on port 8080
docker run -d --name jenkins-server -p 8080:8080 popularowl/jenkins

# install remaining dependencies
apt -y install nginx
apt -y install ufw

# setup debian firewall
ufw status verbose
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 22
ufw allow 80
yes | ufw enable

# update nginx configuration
rm -f /etc/nginx/sites-enabled/default
cp -f /tmp/jenkins-proxy /etc/nginx/sites-enabled
service nginx restart
