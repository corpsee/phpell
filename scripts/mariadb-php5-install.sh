#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

./mariadb-install.sh "${SCRIPT_DIR}" "${MYSQL_ROOT_PASSWORD}" "${MARIADB_VERSION}"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql > /dev/null

php5enmod mysql

service apache2 restart
service php5-fpm restart
