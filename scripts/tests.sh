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

echo 'PHP5 TEST'
echo '========'

if [[ $(php -v | grep -o -m 1 'deb\.sury\.org') != '' ]]; then
    echo "    PHP PPA deb.sury.org: ok"
else
    echo "    PHP PPA deb.sury.org: fail"
fi

if [[ $(php -v | grep -o -m 1 "${PHP_VERSION}\.") != '' ]]; then
    echo "    PHP version (${PHP_VERSION}): ok"
else
    echo "    PHP version (${PHP_VERSION}): fail"
fi

if [[ -e /etc/php5/cli/php.origin.ini ]]; then
    echo "    PHP config (php.origin.ini): ok"
else
    echo "    PHP config (php.origin.ini): fail"
fi

if [[ -e /etc/php5/cli/php.ini ]]; then
    echo "    PHP config (php.ini): ok"
else
    echo "    PHP config (php.ini): fail"
fi

if [[ /etc/php5/cli/php.origin.ini -ot /etc/php5/cli/php.ini ]]; then
    echo "    PHP config (php.origin.ini old than php.ini): ok"
else
    echo "    PHP config (php.origin.ini old than php.ini): fail"
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
