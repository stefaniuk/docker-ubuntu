#!/bin/bash
set -e

[ -x /sbin/bootstrap.sh ] && . /sbin/bootstrap.sh "$@"

exec gosu $SYSTEM_USER "$@"
