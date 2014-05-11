#!/bin/bash

MODE=$1

DEBIAN_FRONTEND=noninteractive aptitude -y install apache2-bin apache2-data libapache2-mod-php5 libapache2-mod-rpaf

# apache2

rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/conf-available/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/mods-available/*.conf

cp -fv /vagrant/configs/apache2/apache2."$MODE".conf /etc/apache2/apache2.conf
cp -fv /vagrant/configs/apache2/ports.conf           /etc/apache2/ports.conf

cp -fv /vagrant/configs/apache2/conf/charset.conf                 /etc/apache2/conf-available/charset.conf
cp -fv /vagrant/configs/apache2/conf/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.conf
cp -fv /vagrant/configs/apache2/conf/security."$MODE".conf        /etc/apache2/conf-available/security.conf

cp -fv /vagrant/configs/apache2/mods/*.conf       /etc/apache2/mods-available/

rm -fv /etc/apache2/conf-enabled/*
ln -sv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-enabled/charset.conf
ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ln -sv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-enabled/security.conf

rm -fv /etc/apache2/mods-enabled/*

a2enmod mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime php5 rewrite setenvif rpaf

rm -fv /etc/apache2/sites-enabled/*

/etc/init.d/apache2 reload