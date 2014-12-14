#!/bin/bash

MODE=$1

cp -fv /vagrant/configs/apt/nginx.list   /etc/apt/sources.list.d/nginx.list
wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
DEBIAN_FRONTEND=noninteractive aptitude -y install nginx > /dev/null

mv -fv /etc/nginx/nginx.conf /etc/nginx/nginx.origin.conf
cp -fv /vagrant/configs/nginx/nginx."$MODE".conf /etc/nginx/nginx.conf

mkdir -p /etc/nginx/sites-available

mv -fv /etc/nginx/conf.d/* /etc/nginx/sites-available

/etc/init.d/nginx restart

