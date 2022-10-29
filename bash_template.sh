#!/usr/bin/env bash
# Shellcheck online : https://www.shellcheck.net

set -o errexit
set -o nounset
set -o pipefail
[[ "${TRACE-0}" == "1" ]] && set -o xtrace

cd "$(dirname "$0")"

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
readonly script_dir
readonly script_name="${0##*/}"
readonly error_parsing_options=100

usage() {
    cat <<USAGE_TEXT
Usage: ${script_name} [-h | --help] [-param <ARG>] [-f | --flag]

DESCRIPTION
    Your description here.

OPTIONS:
-h, --help
    Print this help and exit.
-f, --flag
    Description for flag option.
--param
    Description for param option.
USAGE_TEXT
}

trap cleanup SIGINT SIGTERM ERR EXIT
cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
    # script cleanup here
}

die() {
    local -r message="${1}"
    local -r code="${2:-1}"
    echo "${message}" >&2
    exit "${code}"
}

# --- Loggers.
setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;91m' GREEN='\033[0;32m' ORANGE='\033[0;33m'
    BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
    LIGHTGREY='\033[0;37m'
    BOLD='\033[0;1m' DIM='\033[0;2m' UNDERLINE='\033[0;4m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
    LIGHTGREY=''
    BOLD='' DIM='' UNDERLINE=''
  fi
}

log() {
    DATE=$(TZ=UTC date '+%Y-%m-%d %H:%M:%S%z')
    echo >&2 -e "${DATE} ${1-}"
}

log_error() {
    log "${RED}ERROR [$$] $1${NOFORMAT}"
    sleep 0  # without this, error message is not displayed
}

log_warn() {
    log "${YELLOW}WARNING [$$] $1${NOFORMAT}"
}

log_info() {
    log "${LIGHTGREY}INFO [$$] $1${NOFORMAT}"
}

log_note() {
    log "${BLUE}NOTE [$$] $1${NOFORMAT}"
}

# --- Parameter parsing.
parse_params() {
  # default values of variables set from params
  flag=0
  param=''
  args=()
  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    --no-color) NO_COLOR=1 ;;
    -f | --flag) flag=1 ;; # example flag
    -p | --param) # example named parameter
      param="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" "${error_parsing_options}" ;;
    *) break ;;
    esac
    shift
  done
  args=("$@")

  # Ensure required params and arguments.
  # [[ -z "${param-}" ]] && die "Missing required parameter: param"
  # [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

main() {
    echo "main script login here"
    exit 0
}

setup_colors
parse_params "$@"
main "$@"
