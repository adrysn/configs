#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

OS=""  # ubuntu, centos, osx
REV=""


# === Colors
RED="\033[0;91m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
LIGHTGREY="\033[0;37m"


# === Formats
NC="\033[0m"
BOLD="\033[0;1m" DIM="\033[0;2m"
UNDERLINE="\033[0;4m"


# === Loggers
error() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    echo "${RED}${DATE} ERROR [$$] $1${NC}" >&2
    sleep 0  # without this, error message is not displayed
    exit -1
}

warning() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    echo "${YELLOW}${DATE} WARNING [$$] $1${NC}" >&2
}

info() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    echo "${LIGHTGREY}${DATE} INFO [$$] $1${NC}"
}

note() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    echo "${BLUE}${DATE} NOTE [$$] $1${NC}"
}


# === Get OS type and REV.
lowercase() {
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

case "${OSTYPE}" in
    "linux-gnu"*)
        if [[ -f "/etc/debian_version" ]] ; then
            OS=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F= '{ print $2 }'`
            REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F= '{ print $2 }'`
        elif [[ -f "/etc/redhat-release" ]] ; then
            OS=`cat /etc/redhat-release |sed s/\ release.*//`
            REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
        fi
	;;
    "darwin"*) OS="osx" ;;
    *) error "unknown OS" ;;
esac
OS=`lowercase ${OS}`
readonly OS
readonly REV
