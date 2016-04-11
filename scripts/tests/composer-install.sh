#!/bin/bash

echo 'COMPOSER TEST'
echo '============='

if [[ $(composer --version | grep -o -m 1 'Composer version 1\.0') != '' ]]; then
    echo "    Composer version: ok"
else
    echo "    Composer version: fail"
fi

if [[ $(sudo crontab -l | grep -o -m 1 '0 0 \* \* 0 composer selfupdate') != '' ]]; then
    echo "    Composer crontab: ok"
else
    echo "    Composer crontab: fail"
fi
echo ""

if [[ -e /usr/bin/composer.phar ]]; then
    echo "    Composer file (/usr/bin/composer.phar): ok"
else
    echo "    Composer file (/usr/bin/composer.phar): fail"
fi

if [[ -L /usr/bin/composer ]]; then
    echo "    Composer file (/usr/bin/composer): ok"
else
    echo "    Composer file (/usr/bin/composer): fail"
fi
echo ""

COMPOSER_RIGHTS=$(ls -alF /usr/bin/composer.phar | awk '{ print $1 " " $3 " " $4 }')
if [[ "${COMPOSER_RIGHTS}" == '-rwxr-xr-x root root' ]]; then
    echo "    Composer rights (755 root): ok"
else
    echo "    Composer rights (755 root): fail"
fi

COMPOSER_RIGHTS=$(ls -alF /usr/bin/composer | awk '{ print $1 " " $3 " " $4 }')
if [[ "${COMPOSER_RIGHTS}" == 'lrwxrwxrwx root root' ]]; then
    echo "    Composer link rights (777 root): ok"
else
    echo "    Composer link rights (777 root): fail"
fi
echo ""
