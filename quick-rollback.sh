#!/bin/sh
rollback=%ROLLBACK?%
if [ 1 -eq "$rollback" ]; then
    base="/home/warrprod"
    releases="$base/releases"
    commit="%COMMIT%"
    for release in $releases/*; do
        revision=$(cat "$release/.revision")
        if [ "$revision" = "$commit" ]; then
            rm -f "$releases/current"
            ln -s "$release" "$releases/current"
            mv -f "$releases/current" "$base/"
            echo "Release found on server, switching symlink."
            exit 1
        fi
    done
    echo "Release not found, continuing with deployment."
else
    echo "Deployment is not a rollback, continuing with deployment."
fi
