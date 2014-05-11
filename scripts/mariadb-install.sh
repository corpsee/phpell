#!/bin/bash

# official mariadb repos
cp -f /vagrant/configs/apt/mariadb.list /etc/apt/sources.list.d/mariadb.list

# import key for mariadb
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

DEBIAN_FRONTEND=noninteractive aptitude -y update
DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server mariadb-client
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql