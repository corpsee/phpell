#!/bin/bash

SERVER_TYPE=$1

cp -v /home/vagrant/provision/scripts/utils/"$SERVER_TYPE"/create-host.sh  /usr/bin/create-host
cp -v /home/vagrant/provision/scripts/utils/"$SERVER_TYPE"/disable-host.sh /usr/bin/disable-host
cp -v /home/vagrant/provision/scripts/utils/"$SERVER_TYPE"/enable-host.sh  /usr/bin/enable-host

chmod 755 /usr/bin/create-host
chmod 755 /usr/bin/disable-host
chmod 755 /usr/bin/enable-host

cp -v /home/vagrant/provision/scripts/utils/extract.sh /usr/bin/extract
chmod 755 /usr/bin/extract