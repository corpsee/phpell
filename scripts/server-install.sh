#!/bin/bash

SCRIPT_DIR=$1
source "${SCRIPT_DIR}/config.sh"

cd "${SCRIPT_DIR}/scripts"

if [ "${INIT_SERVER}" == true ]; then
    source server-init.sh
fi

if [ "${INSTALL_JAVA}" == true ]; then
    source java-install.sh
fi

source php5-install.sh
source composer-install.sh

if [ "${INSTALL_NGINX_APACHE2}" == true ]; then
    source nginx-apache2-php5-install.sh
    source utils-install.sh
elif [ "${INSTALL_APACHE2}" == true ]; then
    source apache2-php5-install.sh
    source utils-install.sh
elif [ "${INSTALL_NGINX}" == true ]; then
    source nginx-php5-install.sh
    source utils-install.sh
fi

if [ "${INSTALL_MARIADB}" == true ]; then
    source mariadb-php5-install.sh
    source utils-db-install.sh
elif [ "${INSTALL_MYSQL}" == true ]; then
    source mysql-php5-install.sh
    source utils-db-install.sh
fi

if [ "${INSTALL_POSTGRES}" == true ]; then
    source postgres-php5-install.sh
    source utils-db-install.sh
fi

if [ "${INSTALL_MEMCACHED}" == true ]; then
    source memcached-php5-install.sh
fi
