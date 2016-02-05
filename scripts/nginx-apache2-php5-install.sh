#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

./apache2-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"

DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-rpaf > /dev/null

sed "
    s:\${PORT}:8080:g;
    s:\${HOST}:localhost:g;
" "${SCRIPT_DIR}/configs/apache2/apache2.${MODE}.conf" > /etc/apache2/apache2.conf
sed "
    s:\${PORT}:8080:g;
    s:\${PORT}:8443:g;
    s:\${HOST}:localhost:g;
" "${SCRIPT_DIR}/configs/apache2/ports.conf"           > /etc/apache2/ports.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/mods/rpaf.conf" /etc/apache2/mods-available/rpaf.conf

a2enmod rpaf
service apache2 restart

./nginx-install.sh "${SCRIPT_DIR}" "${MODE}" "${NGINX_VERSION}"
