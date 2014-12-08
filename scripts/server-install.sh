#!/bin/bash

#TODO: added output info
#TODO: set hosts, hostname
HOST_IP=$1
HOST_NAME=$2
MODE=$3
TIMEZONE=$4

WEB_ROOT="/var/www"
WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

JAVA_VERSION="8"

MYSQL_ROOT_PASSWORD='root'

APACHE_MODS="mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif rpaf"

main_install ()
{
    locale-gen ru_RU.utf8
    dpkg-reconfigure locales

    #TODO: locales
	DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null && aptitude -y upgrade > /dev/null
	DEBIAN_FRONTEND=noninteractive aptitude -y install mc curl htop git tar bzip2 unrar gzip unzip p7zip > /dev/null

	# set timezone
	echo "$TIMEZONE" > /etc/timezone
	cp -v /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

	# set mcedit like default editor
	rm -fv /etc/alternatives/editor
	ln -sv /usr/bin/mcedit /etc/alternatives/editor
}

util_install ()
{
    cp -v /home/vagrant/provision/scripts/utils/create-host.sh  /usr/bin/create-host
	cp -v /home/vagrant/provision/scripts/utils/disable-host.sh /usr/bin/disable-host
	cp -v /home/vagrant/provision/scripts/utils/enable-host.sh  /usr/bin/enable-host

	chmod 755 /usr/bin/create-host
	chmod 755 /usr/bin/disable-host
	chmod 755 /usr/bin/enable-host
}

sudo -i

main_install
util_install

cd /home/vagrant/provision/scripts

./apache2-install.sh "$MODE" "$APACHE_MODS"
./php5-install.sh    "$MODE" "$TIMEZONE"
./nginx-install.sh   "$MODE"
./java-install.sh    "$JAVA_VERSION"
./user-install.sh    "$WEB_ROOT" "$WEB_USER" "$WEB_GROUP" "$WEB_USER_PASSWORD"
./mariadb-install.sh "$MYSQL_ROOT_PASSWORD"
./postgres-install.sh