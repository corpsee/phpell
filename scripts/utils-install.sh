#!/bin/bash

cp -v /home/vagrant/provision/scripts/utils/create-host.sh  /usr/bin/create-host
cp -v /home/vagrant/provision/scripts/utils/disable-host.sh /usr/bin/disable-host
cp -v /home/vagrant/provision/scripts/utils/enable-host.sh  /usr/bin/enable-host

chmod 755 /usr/bin/create-host
chmod 755 /usr/bin/disable-host
chmod 755 /usr/bin/enable-host