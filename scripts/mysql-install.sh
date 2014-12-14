#!/bin/bash

MYSQL_ROOT_PASSWORD=$1

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

DEBIAN_FRONTEND=noninteractive aptitude -y install mysql-server mysql-client > /dev/null

mv -fv /etc/mysql/my.cnf /etc/mysql/my.origin.cnf
cp -fv /vagrant/configs/mysql/my.cnf /etc/mysql/my.cnf

service mysql restart

#mysql -u root -p
service mysql status