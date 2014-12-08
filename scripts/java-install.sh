#!/bin/bash

JAVA_VERSION=$1

# java ppa
cp -fv /vagrant/configs/apt/java.list /etc/apt/sources.list.d/java.list
# import key for java ppa
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com EEA14886

echo oracle-java"$JAVA_VERSION"-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install oracle-java"$JAVA_VERSION"-installer > /dev/null

java -version
javac -version
