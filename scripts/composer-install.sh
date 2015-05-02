#!/bin/bash

cd /usr/bin/
php -r "readfile('https://getcomposer.org/installer');" | php --
ln -sv /usr/bin/composer.phar /usr/bin/composer

crontab -l | { crontab -l; echo "0 0 * * 0 composer selfupdate"; } | crontab -
