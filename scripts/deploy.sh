#!/bin/sh

TAG="v11"

cd /var/www
git clone git@github.com:corpsee/corpsee-com.git dev.corpsee.com

cd ./dev.corpsee.com
git checkout -f "$TAG"

cd ../
git clone git@github.com:corpsee/corpsee-com-private.git private.corpsee.com

cd ./private.corpsee.com
git checkout -f "$TAG"

#dd if=/dev/zero of=/swapfile bs=1M count=1024
#mkswap -f /swapfile
#swapon /swapfile

#cd ./dev.corpsee.com
#curl -sS https://getcomposer.org/installer | php
#php composer.phar self-update
#php -d memory_limit=-1 composer.phar install

#swapoff /swapfile

cd ../

rm -rf ./dev.corpsee.com/.git
rm -rf ./dev.corpsee.com/.gitignore
rm -rf ./private.corpsee.com/.git
rm -rf ./private.corpsee.com/.gitignore

mkdir ./dev.corpsee.com/session
mkdir ./dev.corpsee.com/temp

cp -fr ./private.corpsee.com/* ./dev.corpsee.com
rm -fr ./private.corpsee.com

cd ./dev.corpsee.com/Application/configs
mv -f  ./configuration.production.php ./configuration.php

cd ../../www
rm ./index.debug.php
mv -f  ./index.production.php ./index.php

cd ../../
chown -R web .
chgrp -R www-data .
find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

#a2ensite dev.corpsee.com
#ln -s /etc/nginx/sites-available/dev.corpsee.com /etc/nginx/sites-enabled/dev.corpsee.com

/root/ensite dev.corpsee.com