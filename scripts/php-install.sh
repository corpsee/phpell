#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/php

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-cli" > /dev/null

if [ "${MODE}" == 'debug' ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-xdebug" > /dev/null
    phpdismod -v "${PHP_VERSION}" opcache
fi

for EXT in "${PHP_EXTENSIONS[@]}"; do
    DEBIAN_FRONTEND=noninteractive aptitude -y install "php${PHP_VERSION}-${EXT}" > /dev/null
done

mv -fv "/etc/php/${PHP_VERSION}/cli/php.ini" "/etc/php/${PHP_VERSION}/cli/php.origin.ini"

sed -e "s:\${TIMEZONE}:${TIMEZONE}:g"       "${SCRIPT_DIR}/configs/php/${PHP_VERSION}/php.${MODE}.ini" > "/etc/php/${PHP_VERSION}/cli/php.ini"
sed -e "s:\${PHP_VERSION}:${PHP_VERSION}:g" "/etc/php/${PHP_VERSION}/cli/php.ini"                      > "/etc/php/${PHP_VERSION}/cli/php.ini"

mkdir -p                "/var/log/php/${PHP_VERSION}"
chown www-data:www-data "/var/log/php/${PHP_VERSION}"
chmod 644               "/var/log/php/${PHP_VERSION}"
