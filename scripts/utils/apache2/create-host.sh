#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use create-host:"
    echo "Available params:"
    echo "-h|--host     - Host/owner name"
    echo "-p|--password - Owner password"
    echo
    exit 0
}

test $# -gt 0 || _help

if ! [ $(id -u -n) = "root" ]; then
   echo "Please, run script with sudo!"
   exit 1
fi

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
    elif [ -z "$1" ]; then
        break
    else
        _help
    fi

    shift
done

checkParam "${pHost}"     '$pHost'
checkParam "${pPassword}" '$pPassword'

if [ "${pYes}" != "1" ]; then
    confirmation "Create host '${pHost}' with owner ${pHost}/${pPassword}?" || exit 1
fi

create-web-user --user="${pHost}" --password="${pPassword}" -y

VHOST_APACHE2="<VirtualHost *:80>
    ServerAdmin  admin@${pHost}
    ServerName   ${pHost}
    ServerAlias  www.${pHost}
    DocumentRoot /var/www/${pHost}/www

    <Directory /var/www/${pHost}/www>
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

cd /etc
echo "${VHOST_APACHE2}" > ./apache2/sites-available/"${pHost}".conf

cd /var/www
chown root:www-data /var/www
chmod ug=rwX,o=rX   /var/www

mkdir -p ./"${pHost}"/www
mkdir -p ./"${pHost}"/sessions
mkdir -p ./"${pHost}"/temp

echo "<?php phpinfo(); " > ./"${pHost}"/www/index.php

chown -R "${pHost}:www-data" ./"${pHost}"

chmod -R u=rwX,go=rX    ./"${pHost}"
chmod -R ug=rwX,o=rX    ./"${pHost}"/sessions
chmod -R ug=rwX,o=rX    ./"${pHost}"/temp

chown root:www-data /var/backups
chmod ug=rwX,o=rX   /var/backups

mkdir -p /var/backups/"${pHost}"
chown -R "${pHost}:www-data" /var/backups/"${pHost}"
chmod -R u=rwX,go=rX             /var/backups/"${pHost}"

mkdir -p /var/log/"${pHost}"
chown -R "${pHost}:www-data" /var/log/"${pHost}"
chmod -R u=rwX,go=rX             /var/log/"${pHost}"

ln -sv /var/log/"${pHost}" /var/www/"${pHost}"/logs
