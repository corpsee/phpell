#!/bin/bash

SCRIPT_DIR=$1
LOCALE=$2
TIMEZONE=$3
PACKAGES=$4
EDITOR=$5
VIEW=$6

set_locales() {
    locale-gen "en_US.utf8"
    locale-gen "${LOCALE}.utf8"
    locale
}

set_timezone() {
    echo "${TIMEZONE}" > /etc/timezone
    cp -v "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
    date '+%F %R %:z'
}

set_packages() {
    DEBIAN_FRONTEND=noninteractive aptitude -y update  > /dev/null
    DEBIAN_FRONTEND=noninteractive aptitude -y upgrade > /dev/null
    COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install ${PACKAGES} > /dev/null"
    eval "${COMMAND}"
}

set_editor() {
    [ -f "${EDITOR}" ] && update-alternatives --set editor "${EDITOR}"
    [ -f "${VIEW}" ] &&   update-alternatives --set view   "${VIEW}"
    update-alternatives --get-selections
}

set_packages
set_locales
set_timezone
set_editor