#!/bin/bash

SCRIPT_DIR=$1
source "${SCRIPT_DIR}/config.sh"

cd "${SCRIPT_DIR}/scripts"

#if [ "${INIT_SERVER}" = true ]; then
#    sudo ./server-init.sh "${SCRIPT_DIR}" "${LOCALE}" "${TIMEZONE}" "${PACKAGES}" "${EDITOR}" "${VIEW}"
#fi
#
#if [ "${INSTALL_JAVA}" = true ]; then
#    sudo ./java-install.sh "${JAVA_VERSION}"
#fi

if [[ $(php -v | grep -o -m 1 'deb\.sury\.org') != '' ]]; then
    echo 'ok';
fi

#./php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"
#./composer-install.sh

#if [ "${INSTALL_NGINX_APACHE2}" = true ]; then
#    sudo ./nginx-apache2-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}" "${NGINX_VERSION}"
#    sudo ./utils-install.sh "${SCRIPT_DIR}" nginx_apache2
#elif [ "${INSTALL_APACHE2}" = true ]; then
#    sudo ./apache2-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"
#    sudo ./utils-install.sh "${SCRIPT_DIR}" apache2
#elif [ "${INSTALL_NGINX}" = true ]; then
#    sudo ./nginx-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${NGINX_VERSION}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"
#    sudo ./utils-install.sh "${SCRIPT_DIR}" nginx
#fi
#
#if [ "${INSTALL_MARIADB}" = true ]; then
#    sudo ./mariadb-php5-install.sh "${SCRIPT_DIR}" "${MYSQL_ROOT_PASSWORD}" "${MARIADB_VERSION}"
#    sudo ./utils-db-install.sh "${SCRIPT_DIR}" mysql
#elif [ "${INSTALL_MYSQL}" = true ]; then
#    sudo ./mysql-php5-install.sh "${SCRIPT_DIR}" "${MYSQL_ROOT_PASSWORD}" "${MYSQL_VERSION}"
#    sudo ./utils-db-install.sh "${SCRIPT_DIR}" mysql
#fi
#
#if [ "${INSTALL_POSTGRES}" = true ]; then
#    sudo ./postgres-php5-install.sh "${SCRIPT_DIR}" "${POSTGRESQL_VERSION}"
#    sudo ./utils-db-install.sh "${SCRIPT_DIR}" postgres
#fi
#
#if [ "${INSTALL_MEMCACHED}" = true ]; then
#    sudo ./memcached-php5-install.sh "${SCRIPT_DIR}" "${MEMCACHED_MEMCACHE}" "${MEMCACHED_MEMCACHED}"
#fi
