#!/bin/bash
set -e

# run bootstrap script
[ -x /sbin/bootstrap.sh ] && . /sbin/bootstrap.sh "$@"

# run custom scripts
for file in /sbin/init.d/*; do
    case "$file" in
        *.sh)
            echo "$0: Running $file"
            . $file
            ;;
    esac
    echo
done

exec gosu $SYSTEM_USER "$@"
