#!/bin/bash

MYSQL_ROOT_PASSWORD=$1
MYSQL_VERSION=$2

if [ "$MYSQL_VERSION" == "5.5" ]; then
    add-apt-repository ppa:ondrej/mysql-5.5
else
    add-apt-repository ppa:ondrej/mysql-5.6
fi

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install mysql-server mysql-client > /dev/null

#TODO: variable for memory setting
mv -fv /etc/mysql/my.cnf /etc/mysql/my.origin.cnf
cp -fv /vagrant/configs/mysql/my.cnf /etc/mysql/my.cnf

rm /var/lib/mysql/ib_logfile*

service mysql restart

#mysql -u root -p
service mysql status