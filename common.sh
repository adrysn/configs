#!/bin/bash

# Colors
RED="\033[0;91m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
LIGHTGREY="\033[0;37m"

# Formats
NC="\033[0m"
BOLD="\033[0;1m" DIM="\033[0;2m"
UNDERLINE="\033[0;4m"

[[ -z "$MODULE_NAME" ]] && MODULE_NAME=""

error() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    if [[ -n $2 ]]; then
	echo "${RED}${DATE} ERROR ${MODULE_NAME} [$$] $2 - $1${NC}" >&2
    else
	echo "${RED}${DATE} ERROR ${MODULE_NAME} [$$] $1${NC}" >&2
    fi
    sleep 0  # without this, error message is not displayed
    exit 1
}

warning() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    if [[ -n $2 ]]; then
	echo "${YELLOW}${DATE} WARNING ${MODULE_NAME} [$$] $2 - $1${NC}" >&2
    else
	echo "${YELLOW}${DATE} WARNING ${MODULE_NAME} [$$] $1${NC}" >&2
    fi
}

info() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    if [[ -n $2  ]]; then
	echo "${LIGHTGREY}${DATE} INFO ${MODULE_NAME} [$$] $2 - $1${NC}"
    else
	echo "${LIGHTGREY}${DATE} INFO ${MODULE_NAME} [$$] $1${NC}"
    fi
}

note() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    if [[ -n $2 ]]; then
	echo "${BLUE}${DATE} NOTE ${MODULE_NAME} [$$] $2 - $1${NC}"
    else
	echo "${BLUE}${DATE} NOTE ${MODULE_NAME} [$$] $1${NC}"
    fi
}

urlencode() {
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
	local c="${1:i:1}"
	case $c in
	    [a-zA-Z0-9.~_-]) printf "$c" ;;
	    *) printf '%%%02X' "'$c" ;;
	esac
    done
    LC_COLLATE=$old_lc_collate
}

urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

# Extract new lines from left file only.
# - $1: left file
# - $2: right file
# - $3: path to write diff result
diff_left_newline() {
    set +e  # diff has non-standard exit-code: 0 (same), 1 (different), 2 (trouble)
    diff --new-line-format="" --unchanged-line-format="" \
	<(sort "$1") <(sort "$2") > "$3"
    set -e
}

# Retry given command (does not seem to be working well with multiline command)
# - $1: command to execute
# - $2: retry count (default 5)
retry() {
    cmd=$1
    retry_count=${2:5}
    cnt=0
    until [[ "$n" -ge $retry_count ]]; do
	$(($cmd)) && exit_code=0 && break
	exit_code=$?
	cnt=$((n+1))
	note "retrying... ($n)"
	sleep 5
    done
    return $exit_code
}
