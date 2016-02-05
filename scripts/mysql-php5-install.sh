#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

./mysql-install.sh "${SCRIPT_DIR}" "${MYSQL_ROOT_PASSWORD}" "${MYSQL_VERSION}"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql > /dev/null

php5enmod mysql

service apache2 restart
service php5-fpm restart
