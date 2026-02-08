#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"

dump ">> killing clockette..."
kill -s KILL "$( cat $PID_FILE )"
[[ -f "$PID_FILE" ]] && rm -f "$PID_FILE" || fatal "/tmp/clockette.pid not found"
dump ">> /tmp/clockette.pid deleted."
