#!/bin/bash

NAME=$1
if [ -z "$NAME" ]; then
    echo "error: must provide a filename (just the name)"
    exit 1
fi

FULLNAME="$(date +%Y-%m-%d)-${NAME}.md"

cp _posts/_blank.md _posts/$FULLNAME

subl _posts/$FULLNAME
