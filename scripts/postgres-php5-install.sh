#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

./postgres-install.sh "${SCRIPT_DIR}" "${POSTGRESQL_VERSION}"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql > /dev/null

php5enmod pgsql

service apache2 restart
service php5-fpm restart
