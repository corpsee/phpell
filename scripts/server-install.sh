#!/bin/bash

#TODO: added output info
#TODO: set hosts, hostname
HOST_IP=$1
HOST_NAME=$2
MODE=$3
TIMEZONE=$4

LOCALE='ru_RU'

WEB_ROOT="/var/www"
WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

JAVA_VERSION="8"

MYSQL_ROOT_PASSWORD='root'

PACKAGES="mc curl htop git tar bzip2 unrar gzip unzip p7zip"
APACHE_MODS="mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif rpaf"

set_locales() {
    locale-gen "$LOCALE".utf8
    #dpkg-reconfigure locales
}

set_timezone() {
    echo "$TIMEZONE" > /etc/timezone
    ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
    #TODO: output to log: date
}

set_packages() {
    DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null & aptitude -y upgrade > /dev/null
    DEBIAN_FRONTEND=noninteractive aptitude -y install $PACKAGES > /dev/null
}

set_editor() {
    update-alternatives --set editor /usr/bin/mcedit
    #TODO: output to log: update-alternatives --query editor
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

set_locales
set_timezone
set_packages
set_editor

util_install

cd /home/vagrant/provision/scripts

./apache2-install.sh "$MODE" "$APACHE_MODS"
./php5-install.sh    "$MODE" "$TIMEZONE"
./nginx-install.sh   "$MODE"
./java-install.sh    "$JAVA_VERSION"
./user-install.sh    "$WEB_ROOT" "$WEB_USER" "$WEB_GROUP" "$WEB_USER_PASSWORD"
./mariadb-install.sh "$MYSQL_ROOT_PASSWORD"
./postgres-install.sh