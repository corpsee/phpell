#!/bin/bash

# debug|production
MODE="debug"

INIT_SERVER=false

TIMEZONE="Asia/Novosibirsk"
LOCALE='ru_RU'

EDITOR="/usr/bin/mcedit"
VIEW="/usr/bin/mcview"

PACKAGES="mc curl htop git"

INSTALL_JAVA=false
JAVA_VERSION="8" #6|7|8

PHP_VERSION="5.6" #5.6|5.5|5.4
#PHP_EXTENSIONS="php5-curl php5-gd php5-imagick"
PHP_EXTENSIONS=("curl" "gd" "imagick")
#PHP_EXTENSIONS[0]="php5-curl"
#PHP_EXTENSIONS[1]="php5-gd"
#PHP_EXTENSIONS[2]="php5-imagick"

INSTALL_NGINX=false
NGINX_VERSION="development" #stable|development (1.8|1.9)

INSTALL_APACHE2=false

INSTALL_NGINX_APACHE2=false

INSTALL_MARIADB=false
MARIADB_VERSION="10.0" #10.0|5.5

INSTALL_MYSQL=false
MYSQL_VERSION="5.6" #5.5|5.6
MYSQL_ROOT_PASSWORD='root'

INSTALL_POSTGRES=false
POSTGRESQL_VERSION="9.4" #9.3|9.4|9.5

INSTALL_MEMCACHED=false
MEMCACHED_MEMCACHE=false
MEMCACHED_MEMCACHED=false
