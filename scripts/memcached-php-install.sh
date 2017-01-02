#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/memcached-install.sh"

if [ "${MEMCACHED_MEMCACHE}" == true ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-memcache" > /dev/null
    phpenmod -v "${PHP_VERSION}" memcache
fi

if [ "${MEMCACHED_MEMCACHED}" == true ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-memcached" > /dev/null
    phpenmod -v "${PHP_VERSION}" memcached
fi

service apache2 restart
service "php${PHP_VERSION}-fpm" restart
