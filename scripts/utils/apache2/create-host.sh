#!/bin/bash

test $# -eq 1 || exit

VHOST_APACHE2="<VirtualHost *:80>
    ServerAdmin  admin@$1
    ServerName   $1
    ServerAlias  www.$1
    DocumentRoot /var/www/$1/www

    <Directory /var/www/$1/www>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog  /var/www/$1/logs/apache_error.log
    CustomLog /var/www/$1/logs/apache_access.log combined

    php_admin_value open_basedir      /var/www/$1:/tmp
    php_admin_value session.save_path /var/www/$1/sessions
    php_admin_value error_log         /var/www/$1/logs/php_error.log
    php_admin_value upload_tmp_dir    /var/www/$1/temp
</VirtualHost>"

cd /etc
echo "$VHOST_APACHE2" > ./apache2/sites-available/"$1".conf

cd /var/www
mkdir -p ./"$1"/www
mkdir -p ./"$1"/sessions
mkdir -p ./"$1"/temp
mkdir -p ./"$1"/logs