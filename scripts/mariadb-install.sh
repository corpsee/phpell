#!/bin/bash

MYSQL_ROOT_PASSWORD=$1

cp -f /vagrant/configs/apt/mariadb.list /etc/apt/sources.list.d/mariadb.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null

sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server mariadb-client > /dev/null

mv -fv /etc/mysql/my.cnf /etc/mysql/my.origin.cnf
cp -fv /vagrant/configs/mariadb/my.cnf /etc/mysql/my.cnf

rm /var/lib/mysql/ib_logfile*

service mysql restart

#mysql -u root -p
service mysql status
