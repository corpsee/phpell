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
DEBIAN_FRONTEND=noninteractive aptitude -y install mc curl php5-common php5-cli apache2 libapache2-mod-php5 libapache2-mod-rpaf nginx

# apache2
mv -fv /etc/apache2/apache2.conf /etc/apache2/apache2.origin.conf
mv -fv /etc/apache2/ports.conf   /etc/apache2/ports.origin.conf

mv -fv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-available/charset.origin.conf
mv -fv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.origin.conf
mv -fv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-available/security.origin.conf

mv -fv /etc/apache2/mods-available/alias.conf       /etc/apache2/mods-available/alias.origin.conf
mv -fv /etc/apache2/mods-available/deflate.conf     /etc/apache2/mods-available/deflate.origin.conf
mv -fv /etc/apache2/mods-available/dir.conf         /etc/apache2/mods-available/dir.origin.conf
mv -fv /etc/apache2/mods-available/mime.conf        /etc/apache2/mods-available/mime.origin.conf
mv -fv /etc/apache2/mods-available/mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.origin.conf
mv -fv /etc/apache2/mods-available/php5.conf        /etc/apache2/mods-available/php5.origin.conf
mv -fv /etc/apache2/mods-available/setenvif.conf    /etc/apache2/mods-available/setenvif.origin.conf
mv -fv /etc/apache2/mods-available/rpaf.conf        /etc/apache2/mods-available/rpaf.origin.conf

cp -fv /vagrant/configs/apache2/apache2."$MODE".conf /etc/apache2/apache2.conf
cp -fv /vagrant/configs/apache2/ports.conf           /etc/apache2/ports.conf

cp -fv /vagrant/configs/apache2/conf/charset.conf                 /etc/apache2/conf-available/charset.conf
cp -fv /vagrant/configs/apache2/conf/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.conf
cp -fv /vagrant/configs/apache2/conf/security."$MODE".conf        /etc/apache2/conf-available/security.conf

cp -fv /vagrant/configs/apache2/mods/alias.conf       /etc/apache2/mods-available/alias.conf
cp -fv /vagrant/configs/apache2/mods/deflate.conf     /etc/apache2/mods-available/deflate.conf
cp -fv /vagrant/configs/apache2/mods/dir.conf         /etc/apache2/mods-available/dir.conf
cp -fv /vagrant/configs/apache2/mods/mime.conf        /etc/apache2/mods-available/mime.conf
cp -fv /vagrant/configs/apache2/mods/mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
cp -fv /vagrant/configs/apache2/mods/php5.conf        /etc/apache2/mods-available/php5.conf
cp -fv /vagrant/configs/apache2/mods/setenvif.conf    /etc/apache2/mods-available/setenvif.conf
cp -fv /vagrant/configs/apache2/mods/rpaf.conf        /etc/apache2/mods-available/rpaf.conf

rm -fv /etc/apache2/conf-enabled/*
ln -sv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-enabled/charset.conf
ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ln -sv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-enabled/security.conf

rm -fv /etc/apache2/mods-enabled/*

a2enmod mpm_prefork access_compat alias deflate dir expires filter headers mime php5 rewrite setenvif rpaf

/etc/init.d/apache2 reload

# nginx
mv -fv /etc/nginx/nginx.conf /etc/nginx/nginx.origin.conf

cp -fv /vagrant/configs/nginx/nginx."$MODE".conf /etc/nginx/nginx.conf

/etc/init.d/nginx reload

# set mcedit like default editor
rm -fv /etc/alternatives/editor
ln -sv /usr/bin/mcedit /etc/alternatives/editor

# install globaly composer.phar as 'composer' command
cd /usr/bin/
curl -sS https://getcomposer.org/installer | php
ln -sv /usr/bin/composer.phar /usr/bin/composer

