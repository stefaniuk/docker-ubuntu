#!/bin/bash
set -e

# debug
[[ "$INIT_DEBUG" =~ ^(true|yes|on|1|TRUE|YES|ON)$ ]] && set -x
# trace
[[ "$INIT_TRACE" =~ ^(true|yes|on|1|TRUE|YES|ON)$ ]] && trace="strace -tt -T -v -s 65536 -f"
# gosu
if [[ "$INIT_GOSU" =~ ^(true|yes|on|1|TRUE|YES|ON)$ ]]; then
    [ -n "$INIT_RUN_AS" ] && gosu="gosu $INIT_RUN_AS" || gosu="gosu $SYSTEM_USER"
fi

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
exec $trace $gosu "$@"
