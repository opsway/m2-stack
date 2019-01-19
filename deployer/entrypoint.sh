#!/bin/bash

eval `ssh-agent -s`

for possiblekey in ${HOME}/.ssh/id_*; do
    if grep -q PRIVATE "$possiblekey"; then
        ssh-add "$possiblekey"
    fi
done

exec "$@"
