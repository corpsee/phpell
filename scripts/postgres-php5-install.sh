#!/bin/bash

POSTGRESQL_VERSION=$1

cd /home/vagrant/provision/scripts

./postgres-install.sh "$POSTGRESQL_VERSION"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql > /dev/null

php5enmod pgsql
service apache2 restart