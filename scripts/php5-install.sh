#!/bin/bash

MODE=$1
TIMEZONE=$2
PHP_EXTENSIONS=$3
PHP_VERSION=$4

if [ "$PHP_VERSION" == "5.4" ]; then
    add-apt-repository ppa:ondrej/php5-oldstable
elif [ "$PHP_VERSION" == "5.5" ]; then
    add-apt-repository ppa:ondrej/php5
else
    add-apt-repository ppa:ondrej/php5-5.6
fi

#TODO: php-fpm + nginx
#TODO: move timezone setting to script params
#TODO: php from dotdeb or other last version
DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-common php5-cli > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-dev php-pear libpcre3 libpcre3-dev > /dev/null

COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install ${PHP_EXTENSIONS} > /dev/null"
eval "${COMMAND}"

#pecl install SPL_Types

mv -fv /etc/php5/cli/php.ini /etc/php5/cli/php.origin.ini
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" /vagrant/configs/php5/php."$MODE".ini > /etc/php5/cli/php.ini

[ -f /etc/php5/mods-available/mcrypt.ini ] && php5enmod mcrypt