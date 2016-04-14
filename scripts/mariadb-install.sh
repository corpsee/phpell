#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

if [ "${MARIADB_VERSION}" == "5.5" ]; then
    # mariadb-server-5.5 depends of mysql-common-5.5
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mysql-5.5
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mariadb-5.5
else
    # mariadb-server-10.0 depends of mysql-common-5.6
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mysql-5.6
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/mariadb-10.0
fi

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null

sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"

DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server mariadb-client > /dev/null
COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server-${MARIADB_VERSION} mariadb-client-${MARIADB_VERSION} > /dev/null"
eval "${COMMAND}"

mysql -u root -p"${pRoot}" -e "UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';"
mysql -u root -p"${pRoot}" -e "DELETE FROM mysql.user WHERE User = '';"
mysql -u root -p"${pRoot}" -e "DELETE FROM mysql.user WHERE User = 'root' AND Host != 'localhost';"
mysql -u root -p"${pRoot}" -e "DROP DATABASE test;"
mysql -u root -p"${pRoot}" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -u root -p"${pRoot}" -e "FLUSH PRIVILEGES;"

mv -fv /etc/mysql/my.cnf /etc/mysql/my.origin.cnf
cp -fv "${SCRIPT_DIR}/configs/mariadb/my.cnf" /etc/mysql/my.cnf

rm /var/lib/mysql/ib_logfile*

service mysql restart

#mysql -u root -p
service mysql status
