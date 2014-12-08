#!/bin/bash

# official postgres
cp -fv /vagrant/configs/apt/postgres.list   /etc/apt/sources.list.d/postgres.list
# import key for postgres
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql > /dev/null

[ -d /etc/php5 ] && DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql > /dev/null

mv -fv /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.origin.conf
cp -fv /vagrant/configs/postgres/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

ln -sv /var/lib/postgresql/9.3 /var/lib/postgresql/9.1

service postgresql restart

rm -fvR /etc/php5/mods-available/20-*.ini
[ -d /etc/apache2 ] && /etc/init.d/apache2 restart

#sudo -u postgres psql
#service postgresql status