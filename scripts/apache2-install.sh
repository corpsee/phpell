#!/bin/bash

SCRIPT_DIR=$1
MODE=$2
APACHE_MODS=$3

DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/apache2

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install apache2 > /dev/null

rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/conf-available/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/mods-available/*.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/apache2.${MODE}.conf" /etc/apache2/apache2.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/ports.conf"           /etc/apache2/ports.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/conf/charset.conf"                 /etc/apache2/conf-available/charset.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/conf/other-vhosts-access-log.conf" /etc/apache2/conf-available/other-vhosts-access-log.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/conf/security.${MODE}.conf"        /etc/apache2/conf-available/security.conf

rm -fv /etc/apache2/conf-enabled/*

ln -sv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-enabled/charset.conf
ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ln -sv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-enabled/security.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/mods/"*.conf /etc/apache2/mods-available/
rm -fv /etc/apache2/mods-enabled/*

COMMAND="a2enmod ${APACHE_MODS}"
eval "${COMMAND}"

rm -fv  /etc/apache2/sites-enabled/*
rm -frv /var/www/*

service apache2 restart
