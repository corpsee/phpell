#!/bin/bash

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

set_sshd() {
    DEBIAN_FRONTEND=noninteractive aptitude -y install openssh-server > /dev/null

    mv -fv /etc/ssh/sshd_config /etc/sshd/sshd_config.origin
    cp -fv "${SCRIPT_DIR}/configs/ssh/sshd_config" /etc/ssh/sshd_config

    service ssh restart
}

set_sendmail() {
    DEBIAN_FRONTEND=noninteractive aptitude -y install sendmail > /dev/null
    #(echo "Subject:Test"; echo "Test mail";) | sendmail -f mail@example.com example@gmail.com
    #php -r "mail('example@gmail.com', 'Test', 'Test mail', 'From: mail@example.com');"
}

set_packages
set_locales
set_timezone
set_editor
set_sshd
set_sendmail
