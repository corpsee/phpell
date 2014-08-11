#!/bin/bash

DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql

mv -fv /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.origin.conf
cp -fv /vagrant/configs/postgres/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

service posgresql restart

#echo "postgres:$POSTGRES_PASSWORD" | chpasswd

rm -fvR /etc/php5/mods-available/20-*.ini
[ -d /etc/apache2 ] && /etc/init.d/apache2 restart

#sudo -u postgres psql
#service posgresql status