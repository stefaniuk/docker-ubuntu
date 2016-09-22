#!/bin/bash
set -e

# run bootstrap script
[ -x /sbin/bootstrap.sh ] && . /sbin/bootstrap.sh "$@"

# run custom scripts
for file in /sbin/init.d/*; do
    case "$file" in
        *.sh)
            echo "$0: running $file"
            . $file
            ;;
        *)
            echo "$0: ignoring $file"
            ;;
    esac
    echo
done

exec gosu $SYSTEM_USER "$@"
