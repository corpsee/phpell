#!/bin/bash

HOST_IP=$1
HOST_NAME=$2

MODE="production"
TIMEZONE="Asia/Novosibirsk"
LOCALE='ru_RU'

WEB_ROOT="/var/www"
WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

JAVA_VERSION="8"

MYSQL_ROOT_PASSWORD='root'

PACKAGES="mc curl htop git tar bzip2 unrar gzip unzip p7zip"
APACHE_MODS="mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif rpaf"
EDITOR="/usr/bin/mcedit"

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
    [ -f "$EDITOR" ] && update-alternatives --set editor "$EDITOR"
}

set_skel() {
    cd /home/vagrant/provision/configs/skel-root
    cp -vRf . /root

    cd /home/vagrant/provision/configs/skel
    cp -vRf . /home/vagrant
    chown -R vagrant:vagrant /home/vagrant/*
    chmod -R u=rwX,go=rX     /home/vagrant/*

    cp -vRf . /etc

    chown -R root:root   /etc/skel
    chmod -R u=rwX,go=rX /etc/skel
}

sudo -i

set_packages
set_locales
set_timezone
set_editor
set_skel

#cd /home/vagrant/provision/scripts

#./utils-install.sh

#./apache2-install.sh "$MODE" "$APACHE_MODS"
#./php5-install.sh    "$MODE" "$TIMEZONE"
#./nginx-install.sh   "$MODE"
#./java-install.sh    "$JAVA_VERSION"
#./user-install.sh    "$WEB_ROOT" "$WEB_USER" "$WEB_GROUP" "$WEB_USER_PASSWORD"
#./mariadb-install.sh "$MYSQL_ROOT_PASSWORD"
#./postgres-install.sh