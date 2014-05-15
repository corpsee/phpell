#!/bin/bash

#TODO: config
POSTGRES_PASSWORD=$1

DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql

#echo "postgres:$POSTGRES_PASSWORD" | chpasswd

rm -fvR /etc/php5/mods-available/20-*.ini
[ -d /etc/apache2 ] && /etc/init.d/apache2 restart

#sudo -u postgres psql
#service posgresql status