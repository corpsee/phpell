#!/bin/bash

JAVA_VERSION=$1

add-apt-repository ppa:webupd8team/java

echo oracle-java"$JAVA_VERSION"-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install oracle-java"$JAVA_VERSION"-installer > /dev/null

java -version
javac -version
