#!/bin/bash

HOST_NAME=$1
PASSWORD=$2

create-web-user "${HOST_NAME}" "${PASSWORD}"

VHOST_APACHE2="<VirtualHost *:80>
    ServerAdmin  admin@${HOST_NAME}
    ServerName   ${HOST_NAME}
    ServerAlias  www.${HOST_NAME}
    DocumentRoot /var/www/${HOST_NAME}/www

    <Directory /var/www/${HOST_NAME}/www>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog  /var/www/${HOST_NAME}/logs/apache_errors.log
    CustomLog /var/www/${HOST_NAME}/logs/apache_access.log combined

    php_admin_value open_basedir      /var/www/${HOST_NAME}:/tmp
    php_admin_value session.save_path /var/www/${HOST_NAME}/sessions
    php_admin_value error_log         /var/www/${HOST_NAME}/logs/php_errors.log
    php_admin_value upload_tmp_dir    /var/www/${HOST_NAME}/temp
</VirtualHost>"

cd /etc
echo "${VHOST_APACHE2}" > ./apache2/sites-available/"${HOST_NAME}".conf

cd /var/www
mkdir -p ./"${HOST_NAME}"/www
mkdir -p ./"${HOST_NAME}"/sessions
mkdir -p ./"${HOST_NAME}"/temp

echo "<?php phpinfo(); " > ./"${HOST_NAME}"/www/index.php

chown -R "${HOST_NAME}:www-data" ./"${HOST_NAME}"

chmod -R u=rwX,go=rX    ./"${HOST_NAME}"
chmod -R ug=rwX,o=rX    ./"${HOST_NAME}"/sessions
chmod -R ug=rwX,o=rX    ./"${HOST_NAME}"/temp

mkdir -p /var/backups/"${HOST_NAME}"
chown -R "${HOST_NAME}:www-data" /var/backups/"${HOST_NAME}"
chmod -R u=rwX,go=rX             /var/backups/"${HOST_NAME}"

mkdir -p /var/log/"${HOST_NAME}"
chown -R "${HOST_NAME}:www-data" /var/log/"${HOST_NAME}"
chmod -R u=rwX,go=rX             /var/log/"${HOST_NAME}"

ln -sv /var/www/"${HOST_NAME}"/logs /var/log/"${HOST_NAME}"
