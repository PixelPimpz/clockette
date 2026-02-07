#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$( tmux show -gqv @CHER )/dump.fun"
touch $PID_FILE
if [[ ! -f $PID_FILE ]]; then
  tmux run-shell -b "$LOCAL_ROOT/scripts/clockette.sh"
else
  dump ">> Clockette is already running. \"Let it be.\" --The Beatles"
  exit 0
fi
