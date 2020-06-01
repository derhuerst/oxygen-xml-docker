#!/bin/bash
set -e

if [[ -z "${AGREE_EULA}" ]]; then
	>&2 echo "You didn't not agree to the EULA."
	exit 2
fi

$@
