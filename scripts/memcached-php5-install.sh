#!/bin/bash

SCRIPT_DIR=$1

cd "${SCRIPT_DIR}/scripts"

./memcached-install.sh

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcache php5-memcached > /dev/null

php5enmod memcache
php5enmod memcached

service apache2 restart