#!/bin/bash

WEB_ROOT="/var/www"
WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

rm -fv "$WEB_ROOT"/*

useradd -g "$WEB_GROUP" -d /home/"$WEB_USER" -m -s /bin/bash "$WEB_USER"
usermod -a -G sudo
echo "$WEB_USER:$WEB_USER_PASSWORD" | chpasswd

chown -R "$WEB_USER:$WEB_GROUP" "$WEB_ROOT"
chmod -R ug=rwX,o=rX "$WEB_ROOT"