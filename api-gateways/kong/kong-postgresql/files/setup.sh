#!/bin/sh

# update & install 
# required dependencies curl, netstat, etc.
apt-get update
apt-get install -y apt-transport-https curl net-tools

# install & configure postgresql database
# create kong db user & kong database
apt-get install -y postgresql postgresql-contrib

# change to neutral directory
cd /tmp

# kong db user with credentials
su - postgres -c "createuser -s kong"
su - postgres -c "createdb kong"
sudo -u postgres psql -c "ALTER USER kong WITH PASSWORD 'kong';"

# install the Kong API gateway (3.8.0)
# guidelines from: https://docs.konghq.com/gateway/3.8.x/install/linux/debian/?install=oss
curl -Lo kong-3.8.0.deb "https://packages.konghq.com/public/gateway-38/deb/debian/pool/bullseye/main/k/ko/kong_3.8.0/kong_3.8.0_$(dpkg --print-architecture).deb"
sudo apt install -y ./kong-3.8.0.deb

# linux opend files limit setup
# recomended setting for kong
ulimit -n 4096

# bootstrap & start Kong
cd /etc/kong &&
cp /tmp/kong.conf /etc/kong/kong.conf
kong migrations bootstrap -c /etc/kong/kong.conf --v
kong start -c /etc/kong/kong.conf --v

# setup debian firewall
# only allow ports for
# ssh (22)
# kong apis (8000) - as demo setup
apt-get -y install ufw
ufw status verbose
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 22
ufw allow 8000
yes | ufw enable
