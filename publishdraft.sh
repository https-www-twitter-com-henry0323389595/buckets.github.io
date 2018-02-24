#!/bin/bash

FILENAME=$1
if [ -z "$FILENAME" ]; then
    echo "error: must provide a filename of a draft"
    exit 1
fi

POST_NAME="_posts/$(date +'%Y-%m-%d')-$(basename ${FILENAME}).md"
echo "POST_NAME" $POST_NAME
