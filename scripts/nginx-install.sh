#!/bin/bash

MODE=$1
NGINX_VERSION=$2

if [ "$NGINX_VERSION" == "1.6" ]; then
    add-apt-repository ppa:nginx/stable
else
    add-apt-repository ppa:nginx/development
fi

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install nginx > /dev/null

mv -fv /etc/nginx/nginx.conf /etc/nginx/nginx.origin.conf
cp -fv /vagrant/configs/nginx/nginx."$MODE".conf /etc/nginx/nginx.conf

rm -fv /etc/nginx/sites-enabled/*

service nginx restart

