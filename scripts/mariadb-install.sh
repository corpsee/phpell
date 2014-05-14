#!/bin/bash

MYSQL_ROOT_PASSWORD='root'

# official mariadb repos
cp -f /vagrant/configs/apt/mariadb.list /etc/apt/sources.list.d/mariadb.list
# import key for mariadb
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

DEBIAN_FRONTEND=noninteractive aptitude -y update

sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server mariadb-client
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql

rm -fvR /etc/php5/mods-available/20-*.ini
[ -d /etc/apache2 ] && /etc/init.d/apache2 restart
