#!/bin/bash

MODE=$1
TIMEZONE=$2

#TODO: PECL/PEAR install: php5-dev php5-pear (libpcre3 libpcre3-dev)...
#TODO: move extension to script params
#TODO: move timezone setting to script params
#TODO: php from dotdeb or other last version
aptitude -y install php5-common php5-cli
aptitude -y install php5-json php5-curl php5-gd php5-imagick php5-xdebug php5-geoip php5-mcrypt php5-sqlite
[ -d /etc/apache2 ] && aptitude -y install libapache2-mod-php5

# install globaly composer.phar as 'composer' command
cd /usr/bin/
php -r "readfile('https://getcomposer.org/installer');" | php -- --filename=composer
#ln -sv /usr/bin/composer.phar /usr/bin/composer

[ -d /etc/apache2 ] && mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
mv -fv /etc/php5/cli/php.ini /etc/php5/cli/php.origin.ini

[ -d /etc/apache2 ] && rm -fvR /etc/php5/apache2/conf.d
rm -fvR /etc/php5/cli/conf.d

cp -fv /vagrant/configs/php5/php."$MODE".ini /etc/php5/php.ini

[ -d /etc/apache2 ] && ln -sv /etc/php5/php.ini /etc/php5/apache2/php.ini
ln -sv /etc/php5/php.ini /etc/php5/cli/php.ini

[ -d /etc/apache2 ] && ln -sv /etc/php5/mods-available /etc/php5/apache2/conf.d
ln -sv /etc/php5/mods-available /etc/php5/cli/conf.d

mv -fv /etc/php5/conf.d/* /etc/php5/mods-available
rm -fvR /etc/php5/conf.d

[ -d /etc/apache2 ] && cp -fv /vagrant/configs/apache2/mods/php5.conf /etc/apache2/mods-available/php5.conf
[ -d /etc/apache2 ] && a2enmod php5
[ -d /etc/apache2 ] && /etc/init.d/apache2 restart