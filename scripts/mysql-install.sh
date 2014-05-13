#!/bin/bash

MYSQL_ROOT_PASSWORD='root'

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

DEBIAN_FRONTEND=noninteractive aptitude -y update
DEBIAN_FRONTEND=noninteractive aptitude -y install mysql-server mysql-client
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql
