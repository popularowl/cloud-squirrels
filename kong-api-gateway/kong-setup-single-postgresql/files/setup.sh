#!/bin/sh

# update & install dependencies
apt-get update
apt-get install -y apt-transport-https curl lsb-core

# linux opend files limit setup
ulimit -n 4096

# setup postgresql database
# create kong db user & kong database
apt-get install -y postgresql postgresql-contrib
su - postgres -c "createuser -s kong"
sudo -u postgres psql -c "ALTER USER kong WITH PASSWORD 'kong';"
su - postgres -c "createdb kong"

# install the Kong api gateway
echo "deb https://kong.bintray.com/kong-deb `lsb_release -sc` main" | sudo tee -a /etc/apt/sources.list
curl -o bintray.key https://bintray.com/user/downloadSubjectPublicKey?username=bintray
apt-key add bintray.key
apt-get update
apt-get install -y kong

# bootstrap & start Kong
cd /etc/kong &&
cp /tmp/kong.conf /etc/kong/kong.conf
kong migrations bootstrap [-c kong.conf]
kong start [-c kong.conf]

# setup debian firewall
# only allow ports 22 & 8000
apt-get -y install ufw
ufw status verbose
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 22
ufw allow 8000
ufw allow 8001
yes | ufw enable
