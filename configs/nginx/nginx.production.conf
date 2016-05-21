user www-data;
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    server_tokens off;

    error_log  /var/log/nginx/error.log;

    include      /etc/nginx/mime.types;
    default_type application/octet-stream;

    sendfile    on;
    tcp_nopush  on;
    tcp_nodelay on;

    gzip              on;
    gzip_comp_level   5;
    gzip_min_length   100;
    gzip_disable      "msie6";
    gzip_proxied      any;
    gzip_http_version 1.1;
    gzip_types        text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss application/atom+xml text/javascript image/svg+xml text/mathml text/x-component;

    # default virtual host
    server {
        listen *:80;
        server_name nothing;
        deny all;
    }

    include /etc/nginx/sites-enabled/*;
}
