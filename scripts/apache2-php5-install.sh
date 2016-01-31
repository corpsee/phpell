#!/bin/bash

SCRIPT_DIR=$1
MODE=$2
APACHE_MODS=$3
TIMEZONE=$4

cd "${SCRIPT_DIR}/scripts"

./apache2-install.sh  "${SCRIPT_DIR}" "${MODE}" "${APACHE_MODS}"

DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-php5 > /dev/null

mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" "${SCRIPT_DIR}/configs/php5/php.${MODE}.ini" > /etc/php5/apache2/php.ini

cp -fv "${SCRIPT_DIR}/configs/apache2/mods-dep/php5.conf" /etc/apache2/mods-available/

a2enmod php5
service apache2 restart
