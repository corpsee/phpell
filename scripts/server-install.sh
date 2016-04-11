#!/bin/bash

SCRIPT_DIR=$1
source "${SCRIPT_DIR}/config.sh"

cd "${SCRIPT_DIR}/scripts"

if [ "${INIT_SERVER}" == true ]; then
    source "${SCRIPT_DIR}/scripts/server-init.sh"
fi

if [ "${INSTALL_JAVA}" == true ]; then
    source "${SCRIPT_DIR}/scripts/java-install.sh"
fi

source "${SCRIPT_DIR}/scripts/php5-install.sh"
source "${SCRIPT_DIR}/scripts/composer-install.sh"

if [ "${INSTALL_NGINX_APACHE2}" == true ]; then
    source "${SCRIPT_DIR}/scripts/nginx-apache2-php5-install.sh"
    source "${SCRIPT_DIR}/scripts/utils-install.sh"
elif [ "${INSTALL_APACHE2}" == true ]; then
    source "${SCRIPT_DIR}/scripts/apache2-php5-install.sh"
    source "${SCRIPT_DIR}/scripts/utils-install.sh"
elif [ "${INSTALL_NGINX}" == true ]; then
    source "${SCRIPT_DIR}/scripts/nginx-php5-install.sh"
    source "${SCRIPT_DIR}/scripts/utils-install.sh"
fi

if [ "${INSTALL_MARIADB}" == true ]; then
    source "${SCRIPT_DIR}/scripts/mariadb-php5-install.sh"
    source "${SCRIPT_DIR}/scripts/utils-db-install.sh"
elif [ "${INSTALL_MYSQL}" == true ]; then
    source "${SCRIPT_DIR}/scripts/mysql-php5-install.sh"
    source "${SCRIPT_DIR}/scripts/utils-db-install.sh"
fi

if [ "${INSTALL_POSTGRESQL}" == true ]; then
    source "${SCRIPT_DIR}/scripts/postgres-php5-install.sh"
    source "${SCRIPT_DIR}/scripts/utils-db-install.sh"
fi

if [ "${INSTALL_MEMCACHED}" == true ]; then
    source "${SCRIPT_DIR}/scripts/memcached-php5-install.sh"
fi
