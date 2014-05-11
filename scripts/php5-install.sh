#!/bin/bash

MODE=$1

#TODO: PECL/PEAR install: php5-dev php5-pear (libpcre3 libpcre3-dev)...
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-common php5-cli
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-json php5-curl php5-gd php5-imagick php5-xdebug php5-geoip php5-mcrypt php5-sqlite

# install globaly composer.phar as 'composer' command
cd /usr/bin/
php -r "readfile('https://getcomposer.org/installer');" | php -- --filename=composer
#ln -sv /usr/bin/composer.phar /usr/bin/composer

mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
mv -fv /etc/php5/cli/php.ini     /etc/php5/cli/php.origin.ini

rm -fvR /etc/php5/apache2/conf.d
rm -fvR /etc/php5/cli/conf.d

cp -fv /vagrant/configs/php5/php."$MODE".ini /etc/php5/php.ini

ln -sv /etc/php5/php.ini        /etc/php5/apache2/php.ini
ln -sv /etc/php5/php.ini        /etc/php5/cli/php.ini

ln -sv /etc/php5/mods-available /etc/php5/apache2/conf.d
ln -sv /etc/php5/mods-available /etc/php5/cli/conf.d

/etc/init.d/apache2 reload