#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use create-host:"
    echo "Available params:"
    echo "-h|--host     - Host/owner name"
    echo "-p|--password - Owner password"
    echo "Optional params:"
    echo "--public      - Public directory (default value: www)"
    echo
    exit 0
}

if ! [ $(id -u -n) = "root" ]; then
   echo "Please, run script with sudo!"
   exit 1
fi

test $# -gt 0 || _help

while [ 1 ]; do
    if [ "$1" == "-y" ]; then
        pYes=1
    elif processShortParam "-h" "$1" "$2"; then
        pHost="${cRes}"; shift
    elif processLongParam "--host" "$1"; then
        pHost="${cRes}"
    elif processShortParam "-p" "$1" "$2"; then
        pPassword="${cRes}"; shift
    elif processLongParam "--password" "$1"; then
        pPassword="${cRes}"
    elif processLongParam "--public" "$1"; then
        pPublic="${cRes}"
    elif [ -z "$1" ]; then
        break
    else
        _help
    fi

    shift
done

checkParam "${pHost}"     '$pHost'
checkParam "${pPassword}" '$pPassword'

setDefault "${pPublic}" "www"
pPublic="${cRes}"

if [ "${pYes}" != "1" ]; then
    confirmation "Create host '${pHost}' with owner ${pHost}/${pPassword}?" || exit 1
fi

create-web-user --user="${pHost}" --password="${pPassword}" -y

VHOST_APACHE2="<VirtualHost localhost:8080>
    ServerAdmin  admin@${pHost}
    ServerName   ${pHost}
    ServerAlias  www.${pHost}
    DocumentRoot /var/www/${pHost}/${pPublic}

    <Directory /var/www/${pHost}/${pPublic}>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog  /var/www/${pHost}/logs/apache_errors.log
    CustomLog /var/www/${pHost}/logs/apache_access.log combined

    php_admin_value open_basedir      /var/www/${pHost}:/tmp
    php_admin_value session.save_path /var/www/${pHost}/sessions
    php_admin_value error_log         /var/www/${pHost}/logs/php_errors.log
    php_admin_value upload_tmp_dir    /var/www/${pHost}/temp
</VirtualHost>"

VHOST_NGINX="server {
    listen *:80;

    server_name ${pHost} www.${pHost};
    root /var/www/${pHost}/${pPublic};

    access_log /var/www/${pHost}/logs/nginx_access.log;
    error_log  /var/www/${pHost}/logs/nginx_errors.log warn;

    location ~ \.(htm|html|xhtml|jpg|jpeg|gif|png|css|zip|tar|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|wav|bmp|rtf|swf|ico|flv|txt|docx|xlsx)$ {
        error_page 404 405 502 504 500 = @apache;
        expires    30d;
    }

    location / {
        error_page 404 405 502 504 500 = @apache;
        error_page 418                 = @apache; return 418;
    }

    location @apache {
        proxy_pass http://localhost:8080;

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
echo "$VHOST_APACHE2" > ./apache2/sites-available/"${pHost}".conf
echo "$VHOST_NGINX"   > ./nginx/sites-available/"${pHost}".conf

cd /var/www
chown root:www-data /var/www
chmod ug=rwX,o=rX   /var/www

mkdir -p ./"${pHost}"/"${pPublic}"
mkdir -p ./"${pHost}"/sessions
mkdir -p ./"${pHost}"/temp

echo "<?php phpinfo(); " > ./"${pHost}"/"${pPublic}"/index.php

chown -R "${pHost}:www-data" ./"${pHost}"

chmod -R u=rwX,go=rX    ./"${pHost}"
chmod -R ug=rwX,o=rX    ./"${pHost}"/sessions
chmod -R ug=rwX,o=rX    ./"${pHost}"/temp

chown root:www-data /var/backups
chmod ug=rwX,o=rX   /var/backups

mkdir -p /var/backups/"${pHost}"
chown -R "${pHost}:www-data" /var/backups/"${pHost}"
chmod -R u=rwX,go=rX         /var/backups/"${pHost}"

mkdir -p /var/log/"${pHost}"
chown -R "${pHost}:www-data" /var/log/"${pHost}"
chmod -R ug=rwX,o=rX         /var/log/"${pHost}"

ln -sv /var/log/"${pHost}" /var/www/"${pHost}"/logs
