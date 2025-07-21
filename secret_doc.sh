#!/bin/bash
set -euo pipefail
SECRET_DOC_PATH="$1"
TEMP="$(mktemp)"
age -d < SECRET_DOC_PATH > TEMP
"$EDITOR" "$TEMP"
age -p < TEMP > SECRET_DOC_PATH
rm "$TEMP"
