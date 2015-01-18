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

set_skel() {
    cd "${SCRIPT_DIR}/configs/skel-root"

    cp -vf ./.profile     /root
    cp -vf ./.bashrc      /root
    cp -vf ./.bash_logout /root

    cd "${SCRIPT_DIR}/configs/skel"

    [ -d /home/vagrant ] && cp -vf ./.profile     /home/vagrant
    [ -d /home/vagrant ] && cp -vf ./.bashrc      /home/vagrant
    [ -d /home/vagrant ] && cp -vf ./.bash_logout /home/vagrant

    [ -d /home/vagrant ] && chown -R vagrant:vagrant /home/vagrant/*
    [ -d /home/vagrant ] && chmod -R u=rwX,go=rX     /home/vagrant/*

    cp -vf ./.profile     /etc/skel
    cp -vf ./.bashrc      /etc/skel
    cp -vf ./.bash_logout /etc/skel

    chown -R root:root   /etc/skel
    chmod -R u=rwX,go=rX /etc/skel
}

set_packages
set_locales
set_timezone
set_editor
set_skel