#!/bin/bash

#TODO: added output info
HOST_IP=$1
HOST_NAME=$2
MODE=$3
TIMEZONE=$4

main_install ()
{
	DEBIAN_FRONTEND=noninteractive aptitude -y update
	aptitude -y upgrade

	DEBIAN_FRONTEND=noninteractive aptitude -y install mc curl htop git

	# set timezone
	echo "$TIMEZONE" > /etc/timezone
	cp /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

	# set mcedit like default editor
	rm -fv /etc/alternatives/editor
	ln -sv /usr/bin/mcedit /etc/alternatives/editor
}

util_install ()
{
	cp -fv /vagrant/scripts/utils/create-host.sh /usr/bin/create-host
	cp -fv /vagrant/scripts/utils/disable-host.sh    /usr/bin/disable-host
	cp -fv /vagrant/scripts/utils/enable-host.sh     /usr/bin/enable-host

	chmod 755 /usr/bin/create-host
	chmod 755 /usr/bin/disable-host
	chmod 755 /usr/bin/enable-host
}

sudo su -

main_install
util_install



