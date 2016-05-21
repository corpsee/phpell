#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

if [ "${NGINX_VERSION}" == "stable" ]; then
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:nginx/stable
else
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:nginx/development
fi

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install nginx > /dev/null

mv -fv /etc/nginx/nginx.conf /etc/nginx/nginx.origin.conf
cp -fv "${SCRIPT_DIR}/configs/nginx/nginx.${MODE}.conf" /etc/nginx/nginx.conf

[ ! -d /etc/nginx/sites-enabled ] && mkdir -p /etc/nginx/sites-enabled
rm -fv /etc/nginx/sites-enabled/*

[ ! -d /var/www/html ] && rm -fvr /var/www/html

service nginx restart
