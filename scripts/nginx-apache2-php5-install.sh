#!/bin/bash

MODE=$1
APACHE_MODS=$2
TIMEZONE=$3
PHP_EXTENSIONS=$4

cd /home/vagrant/provision/scripts

./apache2-php5-install.sh  "$MODE" "$APACHE_MODS" "$TIMEZONE" "$PHP_EXTENSIONS"
./nginx-install.sh         "$MODE"

DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-rpaf > /dev/null

cp -fv /vagrant/configs/apache2-dep/ports.conf           /etc/apache2/ports.conf
cp -fv /vagrant/configs/apache2-dep/apache2."$MODE".conf /etc/apache2/apache2.conf

cp -fv /vagrant/configs/apache2/mods-dep/rpaf.conf /etc/apache2/mods-available/

a2enmod rpaf
service apache2 restart
