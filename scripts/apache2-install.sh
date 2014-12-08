#!/bin/bash

MODE=$1
APACHE_MODS=$2

DEBIAN_FRONTEND=noninteractive aptitude -y install apache2 > /dev/null

[ -d /etc/php5 ]  && DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-php5 > /dev/null
[ -d /etc/nginx ] && DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-rpaf > /dev/null

rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/conf-available/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/mods-available/*.conf

cp -fv /vagrant/configs/apache2/apache2."$MODE".conf /etc/apache2/apache2.conf
cp -fv /vagrant/configs/apache2/ports.conf           /etc/apache2/ports.conf

cp -fv /vagrant/configs/apache2/conf/charset.conf                 /etc/apache2/conf-available/charset.conf
cp -fv /vagrant/configs/apache2/conf/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.conf
cp -fv /vagrant/configs/apache2/conf/security."$MODE".conf        /etc/apache2/conf-available/security.conf

cp -fv /vagrant/configs/apache2/mods/*.conf       /etc/apache2/mods-available/
[ ! -d /etc/php5 ]  && rm -fv /etc/apache2/mods-available/php5.conf
[ ! -d /etc/nginx ] && rm -fv /etc/apache2/mods-available/rpaf.conf

rm -fv /etc/apache2/conf-enabled/*
ln -sv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-enabled/charset.conf
ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ln -sv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-enabled/security.conf

rm -fv /etc/apache2/mods-enabled/*

[ -d /etc/php5 ] && mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
[ -d /etc/php5 ] && rm -fvR /etc/php5/apache2/conf.d
[ -d /etc/php5 ] && ln -sv /etc/php5/php.ini /etc/php5/apache2/php.ini
[ -d /etc/php5 ] && ln -sv /etc/php5/mods-available /etc/php5/apache2/conf.d

a2enmod "$APACHE_MODS"
[ -d /etc/php5 ] && a2enmod php5
[ -d /etc/nginx ] && a2enmod rpaf

rm -fv /etc/apache2/sites-enabled/*

/etc/init.d/apache2 restart
