#!/bin/bash

NAME=$1
if [ -z "$NAME" ]; then
    echo "error: must provide a filename (just the name)"
    exit 1
fi

FULLNAME="${NAME}.md"

cp _drafts/_blank.md _drafts/$FULLNAME

subl _drafts/$FULLNAME
