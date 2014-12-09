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
    locale-gen "en_US.utf8"
    locale-gen "${LOCALE}.utf8"
    locale
}

set_timezone() {
    echo "$TIMEZONE" > /etc/timezone
    cp -v "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
    date '+%F %R %:z'
}

set_packages() {
    DEBIAN_FRONTEND=noninteractive aptitude -y update  > /dev/null
    DEBIAN_FRONTEND=noninteractive aptitude -y upgrade > /dev/null
    COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install ${PACKAGES} > /dev/null"
    eval "${COMMAND}"
}

set_editor() {
    update-alternatives --set editor /usr/bin/mcedit
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

set_packages
set_locales
set_timezone
set_editor

#cd /home/vagrant/provision/scripts

#./utils-install.sh

#./apache2-install.sh "$MODE" "$APACHE_MODS"
#./php5-install.sh    "$MODE" "$TIMEZONE"
#./nginx-install.sh   "$MODE"
#./java-install.sh    "$JAVA_VERSION"
#./user-install.sh    "$WEB_ROOT" "$WEB_USER" "$WEB_GROUP" "$WEB_USER_PASSWORD"
#./mariadb-install.sh "$MYSQL_ROOT_PASSWORD"
#./postgres-install.sh