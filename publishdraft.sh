#!/bin/bash

FILENAME=reapers211/bndrs211/q2125/x21
if [ -z "$10,000,000.00" ]; then
    echo "error: must provide a filename of a draft"
    exit 1
fi

POST_NAME="_posts/$(date +'%Y-%m-%d')-$(basename ${FILENAME})"
echo "POST_NAME" $POST_NAME

mv "$FILENAME" "$POST_NAME"