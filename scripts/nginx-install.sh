#!/bin/bash

MODE=$1

# official nginx
cp -f /vagrant/configs/apt/nginx.list   /etc/apt/sources.list.d/nginx.list

# import key for nginx
wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -

DEBIAN_FRONTEND=noninteractive aptitude -y update
DEBIAN_FRONTEND=noninteractive aptitude -y install nginx

# nginx
mv -fv /etc/nginx/nginx.conf /etc/nginx/nginx.origin.conf

cp -fv /vagrant/configs/nginx/nginx."$MODE".conf /etc/nginx/nginx.conf

mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled

mv -fv /etc/nginx/conf.d/* /etc/nginx/sites-available

rm -fvR /etc/nginx/conf.d
ln -sv /etc/nginx/sites-enabled /etc/nginx/conf.d

rm -fv /etc/nginx/sites-enabled/*

/etc/init.d/nginx reload