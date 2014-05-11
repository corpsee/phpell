#!/bin/bash

#TODO: added output info
#HOST_IP=$1
#HOST_NAME=$2
MODE=$1
TIMEZONE=$2

WEB_USER="web"
WEB_GROUP="www-data"
WEB_USER_PASSWORD="web"

upgrade_sources () {

	DEBIAN_FRONTEND=noninteractive aptitude -y update
	aptitude -y upgrade
}

main_install () {

	DEBIAN_FRONTEND=noninteractive aptitude -y install mc curl htop git

	# set timezone
	echo "$TIMEZONE" > /etc/timezone
	cp /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

	# set mcedit like default editor
	rm -fv /etc/alternatives/editor
	ln -sv /usr/bin/mcedit /etc/alternatives/editor

	#TODO: mcedit config
	#TODO: .bashrc
}

java_install () {

	DEBIAN_FRONTEND=noninteractive add-app-repository ppa:webupd8team/java
	DEBIAN_FRONTEND=noninteractive aptitude -y update
	DEBIAN_FRONTEND=noninteractive aptitude -y install oracle-java7-installer
}

apache_install () {

	DEBIAN_FRONTEND=noninteractive aptitude -y install apache2-bin apache2-data libapache2-mod-php5 libapache2-mod-rpaf

	# apache2

	rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/*.conf
	rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/conf-available/*.conf
	rename -fv 's/\.conf$/\.origin\.conf/' /etc/apache2/mods-available/*.conf

	cp -fv /vagrant/configs/apache2/apache2."$MODE".conf /etc/apache2/apache2.conf
	cp -fv /vagrant/configs/apache2/ports.conf           /etc/apache2/ports.conf

	cp -fv /vagrant/configs/apache2/conf/charset.conf                 /etc/apache2/conf-available/charset.conf
	cp -fv /vagrant/configs/apache2/conf/other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.conf
	cp -fv /vagrant/configs/apache2/conf/security."$MODE".conf        /etc/apache2/conf-available/security.conf

	cp -fv /vagrant/configs/apache2/mods/*.conf       /etc/apache2/mods-available/

	rm -fv /etc/apache2/conf-enabled/*
	ln -sv /etc/apache2/conf-available/charset.conf                 /etc/apache2/conf-enabled/charset.conf
	ln -sv /etc/apache2/conf-available/other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
	ln -sv /etc/apache2/conf-available/security.conf                /etc/apache2/conf-enabled/security.conf

	rm -fv /etc/apache2/mods-enabled/*

	a2enmod mpm_prefork access_compat authn_core authz_core alias deflate dir expires filter headers mime php5 rewrite setenvif rpaf

	rm -fv /etc/apache2/sites-enabled/*

	/etc/init.d/apache2 reload
}

php_install () {

	#TODO: PECL/PEAR install: php5-dev php5-pear (libpcre3 libpcre3-dev)...
	DEBIAN_FRONTEND=noninteractive aptitude -y install php5-common php5-cli
	DEBIAN_FRONTEND=noninteractive aptitude -y install php5-json php5-curl php5-gd php5-imagick php5-xdebug php5-geoip php5-mcrypt php5-sqlite

	# install globaly composer.phar as 'composer' command
	cd /usr/bin/
	php -r "readfile('https://getcomposer.org/installer');" | php -- --filename=composer
	#ln -sv /usr/bin/composer.phar /usr/bin/composer

	mv -fv /etc/php5/apache2/php.ini /etc/php5/apache2/php.origin.ini
	mv -fv /etc/php5/cli/php.ini     /etc/php5/cli/php.origin.ini

	rm -fvR /etc/php5/apache2/conf.d
	rm -fvR /etc/php5/cli/conf.d

	cp -fv /vagrant/configs/php5/php."$MODE".ini /etc/php5/php.ini

	ln -sv /etc/php5/php.ini        /etc/php5/apache2/php.ini
	ln -sv /etc/php5/php.ini        /etc/php5/cli/php.ini

	ln -sv /etc/php5/mods-available /etc/php5/apache2/conf.d
	ln -sv /etc/php5/mods-available /etc/php5/cli/conf.d

	/etc/init.d/apache2 reload
}

nginx_install () {

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
}

#TODO: config
mariadb_install () {

	# official mariadb repos
		cp -f /vagrant/configs/apt/mariadb.list /etc/apt/sources.list.d/mariadb.list
	# import key for mariadb
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

	DEBIAN_FRONTEND=noninteractive aptitude -y update
	DEBIAN_FRONTEND=noninteractive aptitude -y install mariadb-server mariadb-client
	DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql
}

#TODO: config
postgresql_install () {

	DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql
	DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql
}

#TODO: config
memcached_install () {

	DEBIAN_FRONTEND=noninteractive aptitude -y install memcached
	DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcache php5-memcached
}

#TODO: config
redis_install () {

	DEBIAN_FRONTEND=noninteractive aptitude -y install redis-server
}

#TODO: config
mongodb_install () {

	DEBIAN_FRONTEND=noninteractive aptitude -y install mongodb
	DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mongo
}

util_install () {

	rm -fv /var/www/*

	useradd -g "$WEB_GROUP" -d /home/"$WEB_USER" -m -s /bin/bash "$WEB_USER"
	usermod -a -G sudo
	echo "$WEB_USER:$WEB_USER_PASSWORD" | chpasswd

	chown -R "$WEB_USER:www-data" /var/www
	chmod -R ug=rwX,o=rX  /var/www

	cp -fv /vagrant/scripts/utils/createhost.sh /usr/bin/createhost
	cp -fv /vagrant/scripts/utils/dissite.sh    /usr/bin/dissite
	cp -fv /vagrant/scripts/utils/ensite.sh     /usr/bin/ensite

	chmod 755 /usr/bin/createhost
	chmod 755 /usr/bin/dissite
	chmod 755 /usr/bin/ensite
}

sudo su -

upgrade_sources

main_install
apache_install
php_install
nginx_install
util_install



