#!/bin/bash

WEB_ROOT=$1
WEB_USER=$2
WEB_GROUP=$3
WEB_USER_PASSWORD=$4

rm -fv "$WEB_ROOT"/*

useradd -g "$WEB_GROUP" -d /home/"$WEB_USER" -m -s /bin/bash "$WEB_USER"
usermod -a -G sudo "$WEB_USER"
echo "$WEB_USER:$WEB_USER_PASSWORD" | chpasswd

chown -R "$WEB_USER:$WEB_GROUP" "$WEB_ROOT"
chmod -R ug=rwX,o=rX "$WEB_ROOT"