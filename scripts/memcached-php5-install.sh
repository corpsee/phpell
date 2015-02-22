#!/bin/bash

SCRIPT_DIR=$1
MEMCACHED_MEMCACHE=$2
MEMCACHED_MEMCACHED=$3

cd "${SCRIPT_DIR}/scripts"

./memcached-install.sh

if [ "${MEMCACHED_MEMCACHE}" = true ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcache > /dev/null
    php5enmod memcache
fi

if [ "${MEMCACHED_MEMCACHED}" = true ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcached > /dev/null
    php5enmod memcached
fi

service apache2 restart