#!/bin/bash

MODE=$1
TIMEZONE=$2
PHP_EXTENSIONS=$3

#TODO: php-fpm + nginx
#TODO: move extension to script params
#TODO: move timezone setting to script params
#TODO: php from dotdeb or other last version
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-common php5-cli > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-dev php-pear libpcre3 libpcre3-dev > /dev/null

COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install ${PHP_EXTENSIONS} > /dev/null"
eval "${COMMAND}"

#pecl install SPL_Types

[ -d /etc/apache2 ] && DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-php5 > /dev/null

cd /usr/bin/
php -r "readfile('https://getcomposer.org/installer');" | php --
ln -sv /usr/bin/composer.phar /usr/bin/composer

[ -d /etc/apache2 ] && mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
mv -fv /etc/php5/cli/php.ini /etc/php5/cli/php.origin.ini

cp -fv /vagrant/configs/php5/php."$MODE".ini /etc/php5/cli/php.ini
[ -d /etc/apache2 ] && cp -fv /vagrant/configs/php5/php."$MODE".ini /etc/php5/apache2/php.ini

[ -f /etc/php5/mods-available/mcrypt.ini ] && php5enmod mcrypt

[ -d /etc/apache2 ] && cp -fv /vagrant/configs/apache2/mods/php5.conf /etc/apache2/mods-available/php5.conf
[ -d /etc/apache2 ] && a2enmod php5
[ -d /etc/apache2 ] && service apache2 restart

