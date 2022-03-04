#!/bin/sh
set -e pipefail

function ensure() {
    if [ -z "${1}" ]; then
        echo >&2 "Unable to find the ${2} variable. Did you set with.${2}?"
        exit 1
    fi
}

MANIFEST_TOOL_BIN=${INPUT_MANIFEST_TOOL_BIN:-/bin/manifest-tool}
USERNAME=${INPUT_USERNAME:-$GITHUB_ACTOR}
PASSWORD=${INPUT_PASSWORD:-$GITHUB_TOKEN}
PLATFORMS=${INPUT_PLATFORMS}
TEMPLATE=${INPUT_TEMPLATE}
TARGET=${INPUT_TARGET}


ensure "${USERNAME}" "username"
ensure "${PASSWORD}" "password"
ensure "${PLATFORMS}" "platform"
ensure "${TEMPLATE}" "template"
ensure "${TARGET}" "target"


$MANIFEST_TOOL_BIN \
          --username ${USERNAME} \
          --password ${PASSWORD} \
          push from-args --platforms ${PLATFORMS} \
          --template ${TEMPLATE} \
          --target ${TARGET}

echo done
