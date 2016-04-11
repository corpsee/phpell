#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

UBUNTU=$(lsb_release -c | awk '{ print $2 }')

cp -fv "${SCRIPT_DIR}/configs/apt/postgres.${UBUNTU}.list" /etc/apt/sources.list.d/postgres.list
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql-${POSTGRESQL_VERSION} > /dev/null"
eval "${COMMAND}"

mv -fv "/etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf" "/etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.origin.conf"
sed -e "s:\${POSTGRESQL_VERSION}:${POSTGRESQL_VERSION}:g" "${SCRIPT_DIR}/configs/postgres/postgresql.conf" > "/etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf"

echo "postgres:${POSTGRESQL_POSTGRES_PASSWORD}" | chpasswd
sudo -u postgres psql -c "ALTER USER \"postgres\" WITH PASSWORD '${POSTGRESQL_POSTGRES_PASSWORD}';"

service postgresql restart

#sudo -u postgres psql
service postgresql status
