#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

if [ "${MYSQL_VERSION}" == "5.5" ]; then
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mysql-5.5
else
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mysql-5.6
fi

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install mysql-server- mysql-client > /dev/null

COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install mysql-server-${MYSQL_VERSION} mysql-client-${MYSQL_VERSION} > /dev/null"
eval "${COMMAND}"

mysql -u root -p"${pRoot}" -e "UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';"
mysql -u root -p"${pRoot}" -e "DELETE FROM mysql.user WHERE User = '';"
mysql -u root -p"${pRoot}" -e "DELETE FROM mysql.user WHERE User = 'root' AND Host != 'localhost';"
mysql -u root -p"${pRoot}" -e "DROP DATABASE test;"
mysql -u root -p"${pRoot}" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -u root -p"${pRoot}" -e "FLUSH PRIVILEGES;"

mv -fv /etc/mysql/my.cnf /etc/mysql/my.origin.cnf
cp -fv "${SCRIPT_DIR}/configs/mysql/my.cnf" /etc/mysql/my.cnf

rm -fv /var/lib/mysql/ib_logfile*

service mysql restart

#mysql -u root -p
service mysql status
