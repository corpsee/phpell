#!/bin/bash

# debug | production
MODE="debug"

INIT_SERVER=true

TIMEZONE="Asia/Novosibirsk"
LOCALE='ru_RU'

EDITOR="/usr/bin/mcedit"
VIEW="/usr/bin/mcview"

# software-properties-common - for PPA support
PACKAGES="mc curl htop git software-properties-common"

INSTALL_JAVA=false
JAVA_VERSION="8" #6 | 7 | 8

PHP_VERSION="5.6" #5.6 | 7.0 | 7.1
PHP_EXTENSIONS=("bcmath" "mbstring" "xml" "zip" "intl" "curl" "gd" "imagick")

INSTALL_NGINX=false
NGINX_VERSION="stable" #stable|development (1.10|1.11)

INSTALL_APACHE2=true

INSTALL_NGINX_APACHE2=false

INSTALL_MARIADB=true
MARIADB_VERSION="10.1" #10.1 | 10.0 | 5.5

INSTALL_MYSQL=false
MYSQL_VERSION="5.6" #5.5 | 5.6
MYSQL_ROOT_PASSWORD="root"

INSTALL_POSTGRESQL=false
POSTGRESQL_VERSION="9.4" #9.3 | 9.4 | 9.5 | 9.6
POSTGRESQL_POSTGRES_PASSWORD="postgres"

INSTALL_MEMCACHED=false
MEMCACHED_MEMCACHE=false
MEMCACHED_MEMCACHED=false
