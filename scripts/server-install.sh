#!/bin/bash

SCRIPT_DIR=$1
source "${SCRIPT_DIR}/config.sh"

set_locales() {
    locale-gen "en_US.utf8"
    locale-gen "${LOCALE}.utf8"
    locale
}

set_timezone() {
    echo "${TIMEZONE}" > /etc/timezone
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
    [ -f "${EDITOR}" ] && update-alternatives --set editor "${EDITOR}"
    [ -f "${VIEW}" ] &&   update-alternatives --set view   "${VIEW}"
    update-alternatives --get-selections
}

set_skel() {
    cd "${SCRIPT_DIR}/configs/skel-root"

    cp -vf ./.profile     /root
    cp -vf ./.bashrc      /root
    cp -vf ./.bash_logout /root

    cd "${SCRIPT_DIR}/configs/skel"

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

sudo set_packages
sudo set_locales
sudo set_timezone
sudo set_editor
sudo set_skel

cd "${SCRIPT_DIR}/scripts"

if [ "${INSTALL_JAVA}" = true ]; then
    sudo ./java-install.sh "$JAVA_VERSION"
fi

if [ "${INSTALL_NGINX_APACHE2}" = true ]; then
    sudo ./nginx-apache2-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${APACHE_MODS}" "{$TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}" "${NGINX_VERSION}"
    sudo ./utils-install.sh "${SCRIPT_DIR}" nginx_apache2
elif [ "${INSTALL_APACHE2}" = true ]; then
    sudo ./apache2-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${APACHE_MODS}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"
    sudo ./utils-install.sh "${SCRIPT_DIR}" apache2
fi

if [ "${INSTALL_MARIADB}" = true ]; then
    sudo ./mariadb-php5-install.sh "${SCRIPT_DIR}" "${MYSQL_ROOT_PASSWORD}" "${MARIADB_VERSION}"
elif [ "${INSTALL_MYSQL}" = true ]; then
    sudo ./mysql-php5-install.sh "${SCRIPT_DIR}" "${MYSQL_ROOT_PASSWORD}" "${MYSQL_VERSION}"
fi

if [ "${INSTALL_POSTGRES}" = true ]; then
    sudo ./postgres-php5-install.sh "${SCRIPT_DIR}" "${POSTGRESQL_VERSION}"
fi