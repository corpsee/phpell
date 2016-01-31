#!/bin/bash

SCRIPT_DIR=$1
MODE=$2
TIMEZONE=$3
PHP_EXTENSIONS=$4
PHP_VERSION=$5

if [ "${PHP_VERSION}" == "5.4" ]; then
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/php5-oldstable
elif [ "${PHP_VERSION}" == "5.5" ]; then
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/php5
else
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/php5-5.6
fi

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-common php5-cli php5-json > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-dev php-pear libpcre3 libpcre3-dev > /dev/null

COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install ${PHP_EXTENSIONS} > /dev/null"
eval "${COMMAND}"

if [ "${MODE}" = 'debug' ]; then
    DEBIAN_FRONTEND=noninteractive aptitude -y install php5-xdebug > /dev/null
fi

#pecl install SPL_Types

mv -fv /etc/php5/cli/php.ini /etc/php5/cli/php.origin.ini
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" "${SCRIPT_DIR}/configs/php5/php.${MODE}.ini" > /etc/php5/cli/php.ini
