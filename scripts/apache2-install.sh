#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/apache2

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install apache2 > /dev/null

rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/conf-available/*.conf
rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/mods-available/*.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/apache2.${MODE}.conf" /etc/apache2/apache2.conf

sed "
    s:\${PORT}:80:g;
    s:\${SSL_PORT}:443:g;
    s:\${HOST}:*:g
" "${SCRIPT_DIR}/configs/apache2/ports.conf"           > /etc/apache2/ports.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/conf/charset.conf"                 /etc/apache2/conf-available/charset.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/conf/other-vhosts-access-log.conf" /etc/apache2/conf-available/other-vhosts-access-log.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/conf/security.${MODE}.conf"        /etc/apache2/conf-available/security.conf

rm -fv /etc/apache2/conf-enabled/*

ln -sv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-enabled/charset.conf
ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ln -sv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-enabled/security.conf

rm -fv /etc/apache2/mods-enabled/*

cp -fv "${SCRIPT_DIR}/configs/apache2/mods/alias.conf"       /etc/apache2/mods-available/alias.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/mods/dir.conf"         /etc/apache2/mods-available/dir.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/mods/mime.conf"        /etc/apache2/mods-available/mime.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/mods/mpm_prefork.conf" /etc/apache2/mods-available/mpm_prefork.conf
cp -fv "${SCRIPT_DIR}/configs/apache2/mods/setenvif.conf"    /etc/apache2/mods-available/setenvif.conf

if [ "${MODE}" == 'debug' ]; then
    COMMAND="a2enmod mpm_prefork access_compat authn_core authz_core alias dir filter mime rewrite setenvif"
elif [ "${MODE}" == 'production' ]; then
    cp -fv "${SCRIPT_DIR}/configs/apache2/mods/deflate.conf"     /etc/apache2/mods-available/deflate.conf
    cp -fv "${SCRIPT_DIR}/configs/apache2/mods/expires.conf"     /etc/apache2/mods-available/expires.conf
    cp -fv "${SCRIPT_DIR}/configs/apache2/mods/headers.conf"     /etc/apache2/mods-available/headers.conf

    COMMAND="a2enmod mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif"
fi
eval "${COMMAND}"

rm -fv  /etc/apache2/sites-enabled/*
[ ! -d /var/www/html ] && rm -fvr /var/www/html

service apache2 restart
