#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/mysql-install.sh"

DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-mysql" > /dev/null

phpenmod -v "${PHP_VERSION}" mysql

service apache2 restart
service "php${PHP_VERSION}-fpm" restart
