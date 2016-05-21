#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-fpm > /dev/null

mv -fv /etc/php5/fpm/php.ini         /etc/php5/fpm/php.origin.ini
mv -fv /etc/php5/fpm/php-fpm.conf    /etc/php5/fpm/php-fpm.origin.conf
mv -fv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.origin.conf
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" "${SCRIPT_DIR}/configs/php5/php.${MODE}.ini" > /etc/php5/fpm/php.ini
cp -fv "${SCRIPT_DIR}/configs/php5/php-fpm.conf" /etc/php5/fpm/php-fpm.conf
cp -fv "${SCRIPT_DIR}/configs/php5/www.conf" /etc/php5/fpm/pool.d/www.conf

service php5-fpm restart

source "${SCRIPT_DIR}/scripts/nginx-install.sh"
