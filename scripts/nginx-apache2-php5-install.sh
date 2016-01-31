#!/bin/bash

SCRIPT_DIR=$1
MODE=$2
APACHE_MODS=$3
TIMEZONE=$4
PHP_EXTENSIONS=$5
PHP_VERSION=$6
NGINX_VERSION=$7

cd "${SCRIPT_DIR}/scripts"

./apache2-php5-install.sh "${SCRIPT_DIR}" "${MODE}" "${APACHE_MODS}" "${TIMEZONE}" "${PHP_EXTENSIONS}" "${PHP_VERSION}"

DEBIAN_FRONTEND=noninteractive aptitude -y install libapache2-mod-rpaf > /dev/null

sed "s:\${PORT}:8080:g" "${SCRIPT_DIR}/configs/apache2/apache2.${MODE}.conf"          > /etc/apache2/apache2.conf
sed "s:\${PORT}:8080:g;s:\${PORT}:8443:g;" "${SCRIPT_DIR}/configs/apache2/ports.conf" > /etc/apache2/ports.conf

cp -fv "${SCRIPT_DIR}/configs/apache2/mods-dep/rpaf.conf" /etc/apache2/mods-available/

a2enmod rpaf
service apache2 restart

./nginx-install.sh "${SCRIPT_DIR}" "${MODE}" "${NGINX_VERSION}"
