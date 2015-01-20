#!/bin/bash

set -e

SCRIPT_DIR=$1 #/home/vagrant

sudo aptitude -y update
sudo aptitude -y install unzip

cd "${SCRIPT_DIR}"

wget -O phpell.zip https://github.com/corpsee/phpell/archive/master.zip
unzip ./phpell.zip -d ./phpell_temp

mv -fv  ./phpell_temp/phpell-master ./phpell
rm -fv  ./phpell.zip
rm -frv ./phpell_temp

sudo ./phpell/scripts/server-install.sh "${SCRIPT_DIR}/phpell"