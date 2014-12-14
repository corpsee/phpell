#!/bin/bash

MODE=$1
TIMEZONE=$2
PHP_EXTENSIONS=$3

#TODO: php-fpm + nginx
#TODO: move timezone setting to script params
#TODO: php from dotdeb or other last version
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-common php5-cli > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-dev php-pear libpcre3 libpcre3-dev > /dev/null

COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install ${PHP_EXTENSIONS} > /dev/null"
eval "${COMMAND}"

#pecl install SPL_Types

mv -fv /etc/php5/cli/php.ini /etc/php5/cli/php.origin.ini
cp -fv /vagrant/configs/php5/php."$MODE".ini /etc/php5/cli/php.ini

[ -f /etc/php5/mods-available/mcrypt.ini ] && php5enmod mcrypt