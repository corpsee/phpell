#!/bin/bash

MODE="debug"
TIMEZONE="Asia/Novosibirsk"
LOCALE='ru_RU'

WEB_ROOT="/var/www"
WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

JAVA_VERSION="8" #6|7|8

MYSQL_VERSION="5.5" #5.5|5.6
MYSQL_ROOT_PASSWORD='root'

POSTGRESQL_VERSION="9.4" #9.3|9.4

PACKAGES="mc curl htop git tar bzip2 unrar gzip unzip p7zip"
APACHE_MODS="mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime rewrite setenvif"

PHP_EXTENSIONS="php5-json php5-curl php5-gd php5-imagick php5-xdebug php5-geoip php5-mcrypt php5-sqlite"
PHP_VERSION="5.5" #5.6|5.5|5.4

EDITOR="/usr/bin/mcedit"
VIEW="/usr/bin/mcview"