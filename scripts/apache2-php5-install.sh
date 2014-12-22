#!/bin/bash

MODE=$1
APACHE_MODS=$2
TIMEZONE=$3
PHP_EXTENSIONS=$4
PHP_VERSION=$5

cd /home/vagrant/provision/scripts

./apache2-install.sh  "$MODE" "$APACHE_MODS"
./php5-install.sh     "$MODE" "$TIMEZONE" "$PHP_EXTENSIONS" "$PHP_VERSION"
./composer-install.sh

DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-php5 > /dev/null

mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" /vagrant/configs/php5/php."$MODE".ini > /etc/php5/apache2/php.ini

cp -fv /vagrant/configs/apache2/mods-dep/php5.conf /etc/apache2/mods-available/

[ -f /etc/php5/mods-available/mcrypt.ini ] && php5enmod mcrypt

a2enmod php5
service apache2 restart
