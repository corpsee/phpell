#!/bin/sh

sudo su -

mv -f /etc/apt/sources.list /etc/apt/sources.origin.list

cp -f /vagrant/configs/apt/sources.list /etc/apt/sources.list
cp -f /vagrant/configs/apt/nginx.list   /etc/apt/sources.list.d/nginx.list
cp -f /vagrant/configs/apt/mariadb.list /etc/apt/sources.list.d/mariadb.list

wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

# install mc, curl, sysv-rc (service), php5-cli
DEBIAN_FRONTEND=noninteractive aptitude -y update
DEBIAN_FRONTEND=noninteractive aptitude -y install mc curl php5-common php5-cli apache2 libapache2-mod-php5

# set mcedit like default editor
rm -f /etc/alternatives/editor
ln -s /usr/bin/mcedit /etc/alternatives/editor

# install composer.phar globaly as 'composer' command
cd /usr/bin/
curl -sS https://getcomposer.org/installer | php
ln -s /usr/bin/composer.phar /usr/bin/composer
