#!/bin/bash

echo 'PHP TEST'
echo '========='

if [[ $(php -v | grep -o -m 1 'deb\.sury\.org') != '' ]]; then
    echo "    PHP PPA deb.sury.org: ok"
else
    echo "    PHP PPA deb.sury.org: fail"
fi

if [[ $(php -v | grep -o -m 1 "${PHP_VERSION}\.") != '' ]]; then
    echo "    PHP version (${PHP_VERSION}): ok"
else
    echo "    PHP version (${PHP_VERSION}): fail"
fi
echo ""

if [[ -e /etc/php5/cli/php.origin.ini ]]; then
    echo "    PHP config (php.origin.ini): ok"
else
    echo "    PHP config (php.origin.ini): fail"
fi

if [[ -e /etc/php5/cli/php.ini ]]; then
    echo "    PHP config (php.ini): ok"
else
    echo "    PHP config (php.ini): fail"
fi

if [[ /etc/php5/cli/php.origin.ini -ot /etc/php5/cli/php.ini ]]; then
    echo "    PHP config (php.origin.ini old than php.ini): ok"
else
    echo "    PHP config (php.origin.ini old than php.ini): fail"
fi
echo ""

if [[ -e /etc/php5/mods-available/opcache.ini ]]; then
    echo "    PHP opcache config (opcache.ini): ok"
else
    echo "    PHP opcache config (opcache.ini): fail"
fi

if [[ "${MODE}" == 'production' ]]; then
    if [[ -L /etc/php5/cli/conf.d/05-opcache.ini ]]; then
        echo "    PHP opcache cli config (05-opcache.ini): ok"
    else
        echo "    PHP opcache cli config (05-opcache.ini): fail"
    fi
    echo ""
else
    if [[ -L /etc/php5/cli/conf.d/05-opcache.ini ]]; then
        echo "    PHP opcache cli config (05-opcache.ini): fail"
    else
        echo "    PHP opcache cli config (05-opcache.ini): ok"
    fi
    echo ""
fi

if [[ -e /etc/php5/mods-available/pdo.ini ]]; then
    echo "    PHP pdo config (pdo.ini): ok"
else
    echo "    PHP pdo config (pdo.ini): fail"
fi

if [[ -L /etc/php5/cli/conf.d/10-pdo.ini ]]; then
    echo "    PHP pdo cli config (10-pdo.ini): ok"
else
    echo "    PHP pdo cli config (10-pdo.ini): fail"
fi
echo ""

if [[ -e /etc/php5/mods-available/json.ini ]]; then
    echo "    PHP json config (json.ini): ok"
else
    echo "    PHP json config (json.ini): fail"
fi

if [[ -L /etc/php5/cli/conf.d/20-json.ini ]]; then
    echo "    PHP json cli config (20-json.ini): ok"
else
    echo "    PHP json cli config (20-json.ini): fail"
fi
echo ""

if [[ "${MODE}" == 'debug' ]]; then
    if [[ -e /etc/php5/mods-available/xdebug.ini ]]; then
        echo "    PHP xdebug config (xdebug.ini): ok"
    else
        echo "    PHP xdebug config (xdebug.ini): fail"
    fi

    if [[ -L /etc/php5/cli/conf.d/20-xdebug.ini ]]; then
        echo "    PHP xdebug cli config (20-xdebug.ini): ok"
    else
        echo "    PHP xdebug cli config (20-xdebug.ini): fail"
    fi
    echo ""
fi

for EXT in "${PHP_EXTENSIONS[@]}"; do
    if [[ -e "/etc/php5/mods-available/${EXT}.ini" ]]; then
        echo "    PHP ${EXT} config (${EXT}.ini): ok"
    else
        echo "    PHP ${EXT} config (${EXT}.ini): fail"
    fi

    if [[ -L "/etc/php5/cli/conf.d/20-${EXT}.ini" ]]; then
        echo "    PHP ${EXT} cli config (20-${EXT}.ini): ok"
    else
        echo "    PHP ${EXT} cli config (20-${EXT}.ini): fail"
    fi
    echo ""
done

if [[ -d /var/log/php5 ]]; then
    echo "    PHP log dir (/var/log/php5): ok"
else
    echo "    PHP log dir (/var/log/php5): fail"
fi

PHP5_LOG_RIGHTS=$(ls -alF /var/log | awk '/php5/ { print $1 " " $3 " " $4 }')
if [[ "${PHP5_LOG_RIGHTS}" == 'drwxrwxr-x www-data www-data' ]]; then
    echo "    PHP log dir rights (775 www-data): ok"
else
    echo "    PHP log dir rights (775 www-data): fail"
fi
echo ""