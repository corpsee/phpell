#!/bin/bash

HOST_NAME=$1
PASSWORD=$2

create-web-user "${HOST_NAME}" "${PASSWORD}"

VHOST_APACHE2="<VirtualHost 127.0.0.1:8080>
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

VHOST_NGINX="server {
    listen *:80;

    server_name ${HOST_NAME} www.${HOST_NAME};
    root /var/www/${HOST_NAME}/www;

    #access_log /var/www/${HOST_NAME}/logs/nginx_access.log;
    error_log  /var/www/${HOST_NAME}/logs/nginx_errors.log warn;

    location ~* \.(htm|html|xhtml|jpg|jpeg|gif|png|css|zip|tar|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|wav|bmp|rtf|swf|ico|flv|txt|docx|xlsx)$ {
        error_page 404 405 502 504 500 = @apache;
        expires    30d;
    }

    location / {
        error_page 404 405 502 504 500 = @apache;
        error_page 418                 = @apache; return 418;
    }

    location @apache {
        proxy_pass http://127.0.0.1:8080;

        proxy_set_header X-Real-IP       \$remote_addr;
        proxy_set_header X-Forwarded-for \$remote_addr;
        proxy_set_header Host            \$host;
        proxy_set_header Connection      close;

        proxy_pass_header Content-Type;
        proxy_pass_header Content-Disposition;
        proxy_pass_header Content-Length;
    }
}"

cd /etc
echo "$VHOST_APACHE2" > ./apache2/sites-available/"${HOST_NAME}".conf
echo "$VHOST_NGINX"   > ./nginx/sites-available/"${HOST_NAME}".conf

cd /var/www
chown root:www-data /var/www
chmod ug=rwX,o=rX   /var/www

mkdir -p ./"${HOST_NAME}"/www
mkdir -p ./"${HOST_NAME}"/sessions
mkdir -p ./"${HOST_NAME}"/temp

echo "<?php phpinfo(); " > ./"${HOST_NAME}"/www/index.php

chown -R "${HOST_NAME}:www-data" ./"${HOST_NAME}"

chmod -R u=rwX,go=rX    ./"${HOST_NAME}"
chmod -R ug=rwX,o=rX    ./"${HOST_NAME}"/sessions
chmod -R ug=rwX,o=rX    ./"${HOST_NAME}"/temp

chown root:www-data /var/backups
chmod ug=rwX,o=rX   /var/backups

mkdir -p /var/backups/"${HOST_NAME}"
chown -R "${HOST_NAME}:www-data" /var/backups/"${HOST_NAME}"
chmod -R u=rwX,go=rX             /var/backups/"${HOST_NAME}"

mkdir -p /var/log/"${HOST_NAME}"
chown -R "${HOST_NAME}:www-data" /var/log/"${HOST_NAME}"
chmod -R u=rwX,go=rX             /var/log/"${HOST_NAME}"

ln -sv /var/log/"${HOST_NAME}" /var/www/"${HOST_NAME}"/logs
