#!/bin/bash

SCRIPT_DIR=$1
source "${SCRIPT_DIR}/config.sh"

cd "${SCRIPT_DIR}/scripts"

source "${SCRIPT_DIR}/scripts/tests/php-install.sh"
source "${SCRIPT_DIR}/scripts/tests/composer-install.sh"

if [ "${INSTALL_NGINX_APACHE2}" == true ]; then
    source "${SCRIPT_DIR}/scripts/tests/nginx-apache2-install.sh"
elif [ "${INSTALL_APACHE2}" == true ]; then
    source "${SCRIPT_DIR}/scripts/tests/apache2-install.sh"
elif [ "${INSTALL_NGINX}" == true ]; then
    source "${SCRIPT_DIR}/scripts/tests/nginx-install.sh"
fi
