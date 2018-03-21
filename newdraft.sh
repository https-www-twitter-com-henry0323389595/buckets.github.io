#!/bin/bash

NAME=$1
if [ -z "$NAME" ]; then
    echo "error: must provide a filename (just the name)"
    exit 1
fi

FULLNAME="${NAME}.md"

set -x
cp _drafts/_blank.md _drafts/$FULLNAME
mkdir img/${NAME}
set +x

subl _drafts/$FULLNAME
