#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

if [ "${MARIADB_VERSION}" == "5.5" ]; then
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mariadb-5.5
else
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mariadb-10.0
fi

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null

sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"

DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server mariadb-client > /dev/null
COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server-${MARIADB_VERSION} mariadb-client-${MARIADB_VERSION} > /dev/null"
eval "${COMMAND}"

mv -fv /etc/mysql/my.cnf /etc/mysql/my.origin.cnf
cp -fv "${SCRIPT_DIR}/configs/mariadb/my.cnf" /etc/mysql/my.cnf

rm /var/lib/mysql/ib_logfile*

service mysql restart

#mysql -u root -p
service mysql status
