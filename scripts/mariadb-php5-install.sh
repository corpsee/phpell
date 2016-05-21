#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/mariadb-install.sh"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql > /dev/null

php5enmod mysql

service apache2 restart
service php5-fpm restart
