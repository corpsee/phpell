#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/apache2-install.sh"

DEBIAN_FRONTEND=noninteractive aptitude -y install "libapache2-mod-php${PHP_VERSION}" > /dev/null

mv -fv "/etc/php/${PHP_VERSION}/apache2/php.ini"         "/etc/php/${PHP_VERSION}/apache2/php.origin.ini"
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g"       "${SCRIPT_DIR}/configs/php/${PHP_VERSION}/php.${MODE}.ini" > "/etc/php/${PHP_VERSION}/apache2/php.ini"
sed -e "s:\${PHP_VERSION}:${PHP_VERSION}:g" "/etc/php/${PHP_VERSION}/apache2/php.ini"                  > "/etc/php/${PHP_VERSION}/apache2/php.ini"

mv -fv "/etc/apache2/mods-available/php${PHP_VERSION}.conf"        "/etc/apache2/mods-available/php${PHP_VERSION}.origin.conf"
cp -fv "${SCRIPT_DIR}/configs/apache2/mods/php${PHP_VERSION}.conf" "/etc/apache2/mods-available/php${PHP_VERSION}.conf"

a2enmod "php${PHP_VERSION}"
service apache2 restart
