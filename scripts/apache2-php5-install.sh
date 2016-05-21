#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/apache2-install.sh"

DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-php5 > /dev/null

mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" "${SCRIPT_DIR}/configs/php5/php.${MODE}.ini" > /etc/php5/apache2/php.ini

mv -fv /etc/apache2/mods-available/php5.conf          /etc/apache2/mods-available/php5.origin.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/mods/php5.conf" /etc/apache2/mods-available/php5.conf

a2enmod php5
service apache2 restart
