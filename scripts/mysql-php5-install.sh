#!/bin/bash

MYSQL_ROOT_PASSWORD=$1

cd /home/vagrant/provision/scripts

./mysql-install.sh "$MYSQL_ROOT_PASSWORD"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql > /dev/null

php5enmod mysql
service apache2 restart