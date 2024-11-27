#!/bin/sh

# steps to setup a new VM
echo "Hello from DB VM! Starting setup..."

apt-get update
apt-get install -y postgresql postgresql-client
