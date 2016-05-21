#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/memcached-install.sh"

if [ "${MEMCACHED_MEMCACHE}" == true ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcache > /dev/null
    php5enmod memcache
fi

if [ "${MEMCACHED_MEMCACHED}" == true ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcached > /dev/null
    php5enmod memcached
fi

service apache2 restart
service php5-fpm restart
