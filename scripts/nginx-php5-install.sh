#!/bin/bash

SCRIPT_DIR=$1
MODE=$2
NGINX_VERSION=$3
TIMEZONE=$4
PHP_EXTENSIONS=$5
PHP_VERSION=$6

cd "${SCRIPT_DIR}/scripts"

./php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"
./composer-install.sh

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-fpm > /dev/null

mv -fv /etc/php5/fpm/php.ini         /etc/php5/fpm/php.origin.ini
mv -fv /etc/php5/fpm/php-fpm.conf    /etc/php5/fpm/php-fpm.origin.conf
mv -fv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.origin.conf
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" "${SCRIPT_DIR}/configs/php5/php.${MODE}.ini" > /etc/php5/fpm/php.ini
cp -fv "${SCRIPT_DIR}/configs/php5/php-fpm.conf" /etc/php5/fpm/php-fpm.conf
cp -fv "${SCRIPT_DIR}/configs/php5/www.conf" /etc/php5/fpm/pool.d/www.conf

[ -f /etc/php5/mods-available/mcrypt.ini ] && php5enmod mcrypt

service php5-fpm restart

./nginx-install.sh "${SCRIPT_DIR}" "${MODE}" "${NGINX_VERSION}"
