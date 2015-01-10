#!/bin/bash

MYSQL_ROOT_PASSWORD=$1
MARIADB_VERSION=$2

cd /home/vagrant/provision/scripts

./mariadb-install.sh "$MYSQL_ROOT_PASSWORD" "$MARIADB_VERSION"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql > /dev/null

php5enmod mysql
service apache2 restart