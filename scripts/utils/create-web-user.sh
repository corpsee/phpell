#!/bin/bash

WEB_USER=$1
WEB_USER_PASSWORD=$2

useradd -g www-data -d /home/"$WEB_USER" -m -s /bin/bash "$WEB_USER"
echo "$WEB_USER:$WEB_USER_PASSWORD" | chpasswd
