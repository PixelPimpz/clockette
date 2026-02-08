#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$( tmux show -gqv @CHER )/dump.fun"
touch $PID_FILE
tmux bind M-c run-shell "$LOCAL_ROOT/scripts/clockette.sh $LOCAL_ROOT"
if [[ ! -f $PID_FILE  || -z $PID_FILE ]]; then
  rm -f $PID_FILE
  tmux run-shell -b "$LOCAL_ROOT/scripts/clockette.sh $LOCAL_ROOT"
else
  dump ">> Clockette is already running. \"Let it be.\" --The Beatles"
  dump ">> pid: $( cat /tmp/clockette.pid )"
  exit 0
fi
