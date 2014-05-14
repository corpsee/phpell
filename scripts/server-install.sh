#!/bin/bash

#TODO: added output info
#TODO: set hosts, hostname
#TODO: move vars to script params
HOST_IP=$1
HOST_NAME=$2
MODE=$3
TIMEZONE=$4

WEB_ROOT="/var/www"
WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

JAVA_VERSION="8"

main_install ()
{
	aptitude -y update && aptitude -y upgrade
	aptitude -y install mc curl htop git

	# set timezone
	echo "$TIMEZONE" > /etc/timezone
	cp /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

	# set mcedit like default editor
	rm -fv /etc/alternatives/editor
	ln -sv /usr/bin/mcedit /etc/alternatives/editor
}

util_install ()
{
	cp -fv /vagrant/scripts/utils/create-host.sh  /usr/bin/create-host
	cp -fv /vagrant/scripts/utils/disable-host.sh /usr/bin/disable-host
	cp -fv /vagrant/scripts/utils/enable-host.sh  /usr/bin/enable-host

	chmod 755 /usr/bin/create-host
	chmod 755 /usr/bin/disable-host
	chmod 755 /usr/bin/enable-host

	mv -fv /vagrant/scripts/*  /home/vagrant
	chmod 755 /home/vagrant/*
}

sudo su -

main_install
util_install

cd /home/vagrant
./apache2-install.sh "$MODE"
./php5-install.sh    "$MODE" "$TIMEZONE"
./nginx-install.sh   "$MODE"
./java-install.sh    "$JAVA_VERSION"
./user-install.sh    "$WEB_ROOT" "$WEB_USER" "$WEB_GROUP" "$WEB_USER_PASSWORD"





