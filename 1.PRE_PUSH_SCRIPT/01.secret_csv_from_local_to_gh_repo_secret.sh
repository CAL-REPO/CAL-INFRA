#!/bin/bash
GIT_OWNER=$GIT_OWNER
GIT_REPO=$GIT_REPO
SECRET_CSV_DIR=$SECRET_CSV_DIR

SCRIPT_DIR="$(dirname "$0")"
SECRET_CSV_DIR="$SCRIPT_DIR/$SECRET_CSV_DIR"

for SECRET_CSV_FILE in "$SECRET_CSV_DIR"/*
do
    if echo "$SECRET_CSV_FILE" | grep -E '^([A-Za-z0-9+/=]|[\t\n\f\r ])*$' >/dev/null; then
        SECRET_CSV_FILE_ENCODED=$(cat "$SECRET_CSV_FILE")
        echo "The data is base64 (encoded) data."
    else
        SECRET_CSV_FILE_ENCODED=$(cat "$SECRET_CSV_FILE" | base64 -w 0)
        echo "The data is encoded from csv data to base64 encoded data."
    fi

    SECRET_CSV_FILE_NAME="$(basename $SECRET_CSV_FILE)"
    SECRET_CSV_FILE_PURE_NAME="${SECRET_CSV_FILE_NAME%.*}"
    
    gh secret set "$SECRET_CSV_FILE_PURE_NAME"_ENCODED --repo "$GIT_OWNER/$GIT_REPO" --body "$SECRET_CSV_FILE_ENCODED"
done