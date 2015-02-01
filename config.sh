#!/bin/bash

MODE="debug"
TIMEZONE="Asia/Novosibirsk"
LOCALE='ru_RU'

INSTALL_JAVA=false
INSTALL_NGINX_APACHE2=true
INSTALL_APACHE2=false
INSTALL_MARIADB=true
INSTALL_MYSQL=false
INSTALL_POSTGRES=true
INSTALL_MEMCACHED=true

JAVA_VERSION="8" #6|7|8

MYSQL_VERSION="5.6" #5.5|5.6
MYSQL_ROOT_PASSWORD='root'

MARIADB_VERSION="10.0" #10.0|5.5

POSTGRESQL_VERSION="9.4" #9.3|9.4

PACKAGES="mc curl htop git tar bzip2 unrar gzip unzip p7zip"
APACHE_MODS="mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif"

PHP_EXTENSIONS="php5-json php5-curl php5-gd php5-imagick php5-xdebug php5-geoip php5-mcrypt php5-sqlite"
PHP_VERSION="5.6" #5.6|5.5|5.4

NGINX_VERSION="1.7" #1.6|1.7

EDITOR="/usr/bin/mcedit"
VIEW="/usr/bin/mcview"