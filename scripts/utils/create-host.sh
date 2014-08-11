#!/bin/bash

#TODO: added output info

test $# -eq 1 || exit

#TODO: move to templates
VHOST_APACHE2="<VirtualHost 127.0.0.1:8080>
	ServerAdmin  poisoncorpsee@gmail.com
	ServerName   $1
	ServerAlias  www.$1
	DocumentRoot /var/www/$1/www

	<Directory /var/www/$1/www>
		AllowOverride All
		Require all granted
	</Directory>

	ErrorLog  /var/www/$1/logs/apache_error.log
	CustomLog /var/www/$1/logs/apache_access.log combined

	php_admin_value open_basedir      /var/www/$1:/tmp
	php_admin_value session.save_path /var/www/$1/sessions
	php_admin_value error_log         /var/www/$1/logs/php_error.log
	php_admin_value upload_tmp_dir    /var/www/$1/temp
</VirtualHost>"

VHOST_NGINX="server {
	listen *:80;

	server_name $1 www.$1;
	root /var/www/$1/www;

	#access_log /var/www/$1/logs/nginx_access.log;
	error_log  /var/www/$1/logs/nginx_error.log warn;

	location ~* \.(htm|html|xhtml|jpg|jpeg|gif|png|css|zip|tar|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|wav|bmp|rtf|swf|ico|flv|txt|docx|xlsx)$ {
		error_page 404 405 502 504 500 = @apache;
		expires    30d;
	}

	location / {
		error_page 404 405 502 504 500 = @apache;
		error_page 418                 = @apache; return 418;
	}

	location @apache {
		proxy_pass http://127.0.0.1:8080;

		proxy_set_header X-Real-IP       \$remote_addr;
		proxy_set_header X-Forwarded-for \$remote_addr;
		proxy_set_header Host            \$host;
		proxy_set_header Connection      close;

		proxy_pass_header Content-Type;
		proxy_pass_header Content-Disposition;
		proxy_pass_header Content-Length;
	}
}"

cd /etc
echo "$VHOST_APACHE2" > ./apache2/sites-available/"$1".conf
echo "$VHOST_NGINX"   > ./nginx/sites-available/"$1".conf

cd /var/www
mkdir -p ./"$1"/www
mkdir -p ./"$1"/sessions
mkdir -p ./"$1"/temp
mkdir -p ./"$1"/logs