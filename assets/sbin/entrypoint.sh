#!/bin/bash
set -e

[[ "$DEBUG" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]] && set -x

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

# run main process
if [ -z "$RUN_AS" ]; then
    exec gosu $SYSTEM_USER "$@"
elif [ -n "$RUN_AS" ]; then
    exec gosu $RUN_AS "$@"
fi
