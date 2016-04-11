#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

DEBIAN_FRONTEND=noninteractive aptitude -y install memcached > /dev/null

service memcached status
