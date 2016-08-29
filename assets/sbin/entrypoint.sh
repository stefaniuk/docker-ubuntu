#!/bin/bash
set -e

exec gosu $SYSTEM_USER "$@"
