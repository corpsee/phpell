#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-fpm" > /dev/null

mv -fv "/etc/php/${PHP_VERSION}/fpm/php.ini" "/etc/php/${PHP_VERSION}/fpm/php.origin.ini"
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g"       "${SCRIPT_DIR}/configs/php/${PHP_VERSION}/php.${MODE}.ini" > "/etc/php/${PHP_VERSION}/fpm/php.ini"
sed -e "s:\${PHP_VERSION}:${PHP_VERSION}:g" "/etc/php/${PHP_VERSION}/fpm/php.ini"                      > "/etc/php/${PHP_VERSION}/fpm/php.ini"

mv -fv "/etc/php/${PHP_VERSION}/fpm/php-fpm.conf"    "/etc/php/${PHP_VERSION}/fpm/php-fpm.origin.conf"
sed -e "s:\${PHP_VERSION}:${PHP_VERSION}:g" "${SCRIPT_DIR}/configs/php/${PHP_VERSION}/php-fpm.${MODE}.conf" > "/etc/php/${PHP_VERSION}/fpm/php-fpm.conf"

mv -fv "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf" "/etc/php/${PHP_VERSION}/fpm/pool.d/www.origin.conf"
sed -e "s:\${PHP_VERSION}:${PHP_VERSION}:g" "${SCRIPT_DIR}/configs/php/${PHP_VERSION}/www.${MODE}.conf"     > "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

service "php${PHP_VERSION}-fpm" restart

source "${SCRIPT_DIR}/scripts/nginx-install.sh"
