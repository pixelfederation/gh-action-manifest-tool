#!/bin/bash

set -e pipefail

function ensure() {
    if [ -z "${1}" ]; then
        echo >&2 "Unable to find the ${2} variable. Did you set with.${2}?"
        exit 1
    fi
}

MANIFEST_TOOL_BIN=${INPUT_MANIFEST_TOOL_BIN:-/bin/manifest-tool}
PLATFORMS=${INPUT_PLATFORMS}
TEMPLATE=${INPUT_TEMPLATE}
TARGET=${INPUT_TARGET}

ensure "${PLATFORMS}" "platform"
ensure "${TEMPLATE}" "template"
ensure "${TARGET}" "target"

PWDARGS=""
if [ ! -z "${INPUT_USERNAME}" ] && [ ! -z "${INPUT_PASSWORD}" ]; then
    PWDARGS="--username ${INPUT_USERNAME} --password ${INPUT_PASSWORD}"
else
    mkdir -p ~/.docker/
    echo '{"credsStore":"ecr-login"}' > ~/.docker/config.json
fi

$MANIFEST_TOOL_BIN $PWDARGS \
          push from-args --platforms ${PLATFORMS} \
          --template ${TEMPLATE} \
          --target ${TARGET}

echo done
