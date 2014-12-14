#!/bin/bash

cp -fv /vagrant/configs/apt/postgres.list   /etc/apt/sources.list.d/postgres.list
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql > /dev/null

mv -fv /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.origin.conf
cp -fv /vagrant/configs/postgres/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

ln -sv /var/lib/postgresql/9.3 /var/lib/postgresql/9.1

service postgresql restart

#sudo -u postgres psql
service postgresql status