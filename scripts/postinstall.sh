#!/bin/sh

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

# set mcedit like default editor
rm -f /etc/alternatives/editor
ln -s /usr/bin/mcedit /etc/alternatives/editor

# install globaly composer.phar as 'composer' command

cd /usr/bin/
curl -sS https://getcomposer.org/installer | php
ln -s /usr/bin/composer.phar /usr/bin/composer

