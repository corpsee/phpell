#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/postgres-install.sh"

DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-pgsql" > /dev/null

phpenmod -v "${PHP_VERSION}" pgsql

service apache2 restart
service "php${PHP_VERSION}-fpm" restart
