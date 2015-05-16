#!/bin/bash

# debug|production
MODE="debug"

INIT_SERVER=true

TIMEZONE="Asia/Novosibirsk"
LOCALE='ru_RU'

EDITOR="/usr/bin/mcedit"
VIEW="/usr/bin/mcview"

PACKAGES="mc curl htop git"

INSTALL_JAVA=false
JAVA_VERSION="8" #6|7|8

PHP_VERSION="5.6" #5.6|5.5|5.4
PHP_EXTENSIONS="php5-json php5-curl php5-gd php5-imagick php5-xdebug php5-geoip php5-mcrypt php5-sqlite"

INSTALL_NGINX=true
NGINX_VERSION="1.7" #1.6|1.7

INSTALL_APACHE2=false
APACHE_MODS="mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif"

INSTALL_NGINX_APACHE2=false

INSTALL_MARIADB=false
MARIADB_VERSION="10.0" #10.0|5.5

INSTALL_MYSQL=false
MYSQL_VERSION="5.6" #5.5|5.6
MYSQL_ROOT_PASSWORD='root'

INSTALL_POSTGRES=false
POSTGRESQL_VERSION="9.4" #9.3|9.4

INSTALL_MEMCACHED=false
MEMCACHED_MEMCACHE=false
MEMCACHED_MEMCACHED=false
