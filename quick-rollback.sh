#!/bin/sh
rollback=%ROLLBACK?%
if [ 1 -eq "$rollback" ]; then
    base="/home/user"
    releases="$base/releases"
    commit="%COMMIT%"
    found=false
    for release in $releases/*; do
        revision=$(cat "$release/.revision")
        if [ "$revision" = "$commit" ]; then
            found=true
            echo "Release found on server, switching symlink."
            rm -f "$releases/current"
            ln -s "$release" "$releases/current"
            mv -f "$releases/current" "$base/"
            echo "Symlink switched."
        fi
    done
    if [ "$found" = true ]; then
        echo "Continuing with full build and deployment."
    else
        echo "Release not found, continuing with build and deployment."
    fi
else
    echo "Deployment is not a rollback, continuing with build and deployment."
fi
