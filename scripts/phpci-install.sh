#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

PHPCI_HOST="phpci.virtual"
PHPCI_DB_PASSWORD="phpci.virtual"

create-host -y -h "${PHPCI_HOST}" -p "${PHPCI_HOST}" --public=public
rm -fvr "/var/www/${PHPCI_HOST}/public"

composer create-project block8/phpci "/var/www/${PHPCI_HOST}-pure" --keep-vcs --no-dev --prefer-dist

chown "${PHPCI_HOST}:www-data" "/var/www/${PHPCI_HOST}-pure"
chmod ug=rwX,o=rX   "/var/www/${PHPCI_HOST}-pure"

chmod u=rwx,go=rX "/var/www/${PHPCI_HOST}-pure/console"
chmod u=rwx,go=rX "/var/www/${PHPCI_HOST}-pure/daemonise"

shopt -s dotglob
mv -fv "/var/www/${PHPCI_HOST}-pure/*" "/var/www/${PHPCI_HOST}/"
rm -fr "/var/www/${PHPCI_HOST}-pure/"

create-mysql-db -y --database="${PHPCI_HOST}" --user="${PHPCI_HOST}" --password="${PHPCI_DB_PASSWORD}" --root="${MYSQL_ROOT_PASSWORD}"

COMMAND="php /var/www/${PHPCI_HOST}/console phpci:install --url='http://${PHPCI_HOST}' --db-host=localhost --db-name='${PHPCI_HOST}' --db-user='${PHPCI_HOST}' --db-pass='${PHPCI_DB_PASSWORD}' --admin-name=admin --admin-pass=admin --admin-mail='admin@{$PHPCI_HOST}'"
eval "${COMMAND}"

crontab -l -u "${PHPCI_HOST}" | { crontab -l -u "${PHPCI_HOST}"; echo "* * * * * php /var/www/${PHPCI_HOST}/console phpci:run-builds"; } | crontab -

enable-host -y -h "${PHPCI_HOST}"
