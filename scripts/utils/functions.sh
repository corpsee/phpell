#!/bin/bash

confirmation() {
    local CONFIRM
    if [ -n "$1" ]; then
       read -n 1 -p "$1 (y/[a]): " CONFIRM
    else
       read -n 1 CONFIRM
    fi
    echo "" 1>&2
    if [ "$CONFIRM" = "y" ]; then
       return 0
    else
       return 1
    fi
}

checkParam() {
    if [ -z "$1" ]; then
        echo "Failed! Don\`t pass param $2." 1>&2
        exit 1
    fi
}

# -param
processParamSimple() {
    if [ "$1" = "$2" ]; then
        return 0
    fi

    return 1
}

# -param value
processShortParam() {
    [ -z "$2" ] && return 1

    if [ "$1" = "$2" ]; then
        cRes="$3"

        return 0
    fi

    return 1
}

# --param=value
processLongParam() {
    [ -z "$1" ] && return 1

    if [ "${2#$1=}" != "$2" ]; then
        cRes="${2#$1=}"

        return 0
    fi

    return 1
}
