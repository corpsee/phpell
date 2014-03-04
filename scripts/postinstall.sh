#!/bin/sh

HOST_IP=$1
HOST_NAME=$2
MODE=$3

sudo su -

# backup sources.list
mv -f /etc/apt/sources.list /etc/apt/sources.origin.list

# move to testing release and add official nginx and mariadb repos
cp -f /vagrant/configs/apt/sources.list /etc/apt/sources.list
cp -f /vagrant/configs/apt/nginx.list   /etc/apt/sources.list.d/nginx.list
cp -f /vagrant/configs/apt/mariadb.list /etc/apt/sources.list.d/mariadb.list

# import key for nginx
wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -
# import key for mariadb
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

DEBIAN_FRONTEND=noninteractive aptitude -y update
#DEBIAN_FRONTEND=noninteractive aptitude -y upgrade
DEBIAN_FRONTEND=noninteractive aptitude -y install mc curl php5-common php5-cli apache2 libapache2-mod-php5

# apache2
mv -fv /etc/apache2/apache2.conf                                /etc/apache2/apache2.origin.conf
mv -fv /etc/apache2/ports.conf                                  /etc/apache2/ports.origin.conf
mv -fv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-available/charset.origin.conf
mv -fv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.origin.conf
mv -fv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-available/security.origin.conf

cp -fv /vagrant/configs/apache2/apache2."$MODE".conf /etc/apache2/apache2.conf
cp -fv /vagrant/configs/apache2/ports.conf /etc/apache2/ports.conf
cp -fv /vagrant/configs/apache2/conf/charset.conf /etc/apache2/conf-available/charset.conf
cp -fv /vagrant/configs/apache2/conf/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.conf
cp -fv /vagrant/configs/apache2/conf/security."$MODE".conf /etc/apache2/conf-available/security.conf

rm -fv /etc/apache2/conf-enabled/*
ln -sv /etc/apache2/conf-available/charset.conf /etc/apache2/conf-enabled/charset.conf
ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ln -sv /etc/apache2/conf-available/security.conf /etc/apache2/conf-enabled/security.conf

# set mcedit like default editor
rm -fv /etc/alternatives/editor
ln -sv /usr/bin/mcedit /etc/alternatives/editor

# install globaly composer.phar as 'composer' command

cd /usr/bin/
curl -sS https://getcomposer.org/installer | php
ln -sv /usr/bin/composer.phar /usr/bin/composer

