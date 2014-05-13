#!/bin/bash

JAVA_VERSION=$1

# official nginx
cp -fv /vagrant/configs/apt/java.list   /etc/apt/sources.list.d/java.list

# import key for mariadb
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com EEA14886

echo oracle-java"$JAVA_VERSION"-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

#TODO: choose java version (6, 7, 8)
aptitude -y update
aptitude -y install oracle-java"$JAVA_VERSION"-installer

java -version
javac -version
