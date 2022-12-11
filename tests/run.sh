#!/bin/bash

set -e # exit when any command fails

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

printf "Test GD library\n"

php -f "${SCRIPT_DIR}/images/index.php"

# at this point script finished successfully
printf "\n"
printf "SUCCESS"
printf "\n"
