#!/bin/bash

HOST_NAME=$1
PASSWORD=$2

create-web-user "${HOST_NAME}" "${PASSWORD}"

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
        error_page 404 405 502 504 500 = @fpm;
        error_page 418                 = @fpm; return 418;
    }

    location @fpm {
        fastcgi_pass   unix:/var/run/php5-fpm.sock;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        
        include fastcgi_params;
    }
}"

cd /etc
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
