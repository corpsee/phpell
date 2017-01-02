#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use create-host:"
    echo "Available params:"
    echo "-h|--host     - Host/owner name"
    echo "-p|--password - Owner password"
    echo "-v|--version  - PHP version"
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
    elif processShortParam "-v" "$1" "$2"; then
        pVersion="${cRes}"; shift
    elif processLongParam "--version" "$1"; then
        pVersion="${cRes}"
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
checkParam "${pVersion}"  '$pVersion'

setDefault "${pPublic}" "www"
pPublic="${cRes}"

if [ "${pYes}" != "1" ]; then
    confirmation "Create host '${pHost}' with owner ${pHost}/${pPassword} (PHP ${pVersion})?" || exit 1
fi

create-web-user --user="${pHost}" --password="${pPassword}" -y

VHOST_NGINX="server {
    listen *:80;

    server_name ${pHost} www.${pHost};
    root /var/www/${pHost}/${pPublic};

    access_log /var/www/${pHost}/logs/nginx_access.log;
    error_log  /var/www/${pHost}/logs/nginx_errors.log warn;

    location ~* \.(htm|html|xhtml|jpg|jpeg|gif|png|css|zip|tar|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|wav|bmp|rtf|swf|ico|flv|txt|docx|xlsx)$ {
        error_page 404 405 502 504 500 = @fpm;
        expires    30d;
    }

    location / {
        try_files \$uri @fpm;
    }

    location @fpm {
        fastcgi_pass  unix:/var/run/php/php${pVersion}-fpm.sock;

        include fastcgi_params;

        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root/index.php;
        fastcgi_param SCRIPT_NAME index.php;
    }
}"

cd /etc
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
