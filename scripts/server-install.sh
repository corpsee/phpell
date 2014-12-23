#!/bin/bash

SCRIPT_DIR="/home/vagrant/provision"
source "$SCRIPT_DIR/config.sh"

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
    [ -f "$VIEW" ] &&   update-alternatives --set view   "$VIEW"
    update-alternatives --get-selections
}

set_skel() {
    cd /home/vagrant/provision/configs/skel-root

    cp -vf ./.profile     /root
    cp -vf ./.bashrc      /root
    cp -vf ./.bash_logout /root

    cd /home/vagrant/provision/configs/skel

    cp -vf ./.profile     /home/vagrant
    cp -vf ./.bashrc      /home/vagrant
    cp -vf ./.bash_logout /home/vagrant

    chown -R vagrant:vagrant /home/vagrant/*
    chmod -R u=rwX,go=rX     /home/vagrant/*

    cp -vf ./.profile     /etc/skel
    cp -vf ./.bashrc      /etc/skel
    cp -vf ./.bash_logout /etc/skel

    chown -R root:root   /etc/skel
    chmod -R u=rwX,go=rX /etc/skel
}

sudo -i

set_packages
set_locales
set_timezone
set_editor
set_skel

cd /home/vagrant/provision/scripts

./utils-install.sh

./java-install.sh                "$JAVA_VERSION"
./nginx-apache2-php5-install.sh  "$MODE" "$APACHE_MODS" "$TIMEZONE" "$PHP_EXTENSIONS" "$PHP_VERSION"
#./apache2-php5-install.sh  "$MODE" "$APACHE_MODS" "$TIMEZONE" "$PHP_EXTENSIONS" "$PHP_VERSION"

./mariadb-php5-install.sh  "$MYSQL_ROOT_PASSWORD"
#./mysql-php5-install.sh  "$MYSQL_ROOT_PASSWORD" "$MYSQL_VERSION"
./postgres-php5-install.sh "$POSTGRESQL_VERSION"