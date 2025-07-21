#!/bin/bash
set -euo pipefail
secret_doc_path="$1"
temp="$(mktemp)"
trap 'rm -f "$temp"' SIGTERM SIGINT EXIT
passphrase=""
until gpg --pinentry-mode loopback --passphrase="$passphrase" --output $file_to_edit $ecrypted_file; do
    read -r password;
done

if [ -f "$secret_doc_path" ]; then
    gpg --quiet --batch --yes --passphrase "$passphrase" --output "$temp" "$secret_doc_path"
fi
"$editor" "$temp"
gpg --quiet --batch --yes --passphrase "$PASSPHRASE" --output "$secret_doc_path" "$temp"
age -p < "$temp" > "$secret_doc_path"
rm "$temp"
