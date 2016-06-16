#!/bin/bash

set -o errexit

Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1

chmod -R 777 /output
chown -R testing:testing /output

COMMAND="/home/testing/docker-entrypoint.sh"

for a in "$@"
do
    NEWV=$(echo $a | sed 's/|/\\|/g')
    COMMAND="$COMMAND \"$a\""
done

su testing -c "$COMMAND"

