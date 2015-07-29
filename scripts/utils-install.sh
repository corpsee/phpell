#!/bin/bash

SCRIPT_DIR=$1
SERVER_TYPE=$2

cp -v "${SCRIPT_DIR}/scripts/utils/functions.sh" /usr/bin/functions
chmod 644 /usr/bin/functions

DEBIAN_FRONTEND=noninteractive aptitude -y install tar bzip2 unrar gzip unzip p7zip > /dev/null

cp -v "${SCRIPT_DIR}/scripts/utils/extract.sh" /usr/bin/extract
chmod 755 /usr/bin/extract

cp -v "${SCRIPT_DIR}/scripts/utils/${SERVER_TYPE}/create-host.sh" /usr/bin/create-host
chmod 755 /usr/bin/create-host

cp -v "${SCRIPT_DIR}/scripts/utils/${SERVER_TYPE}/disable-host.sh" /usr/bin/disable-host
chmod 755 /usr/bin/disable-host

cp -v "${SCRIPT_DIR}/scripts/utils/${SERVER_TYPE}/enable-host.sh" /usr/bin/enable-host
chmod 755 /usr/bin/enable-host

cp -v "${SCRIPT_DIR}/scripts/utils/create-web-user.sh" /usr/bin/create-web-user
chmod 755 /usr/bin/create-web-user

cp -v "${SCRIPT_DIR}/scripts/utils/delete-host.sh" /usr/bin/delete-host
chmod 755 /usr/bin/delete-host
