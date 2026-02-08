#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$( tmux show -gqv @CHER )/dump.fun"
dump "hello"
touch $PID_FILE
tmux bind M-c run-shell "$LOCAL_ROOT/clockette.tmux"
#tmux bind M-x run-shell "$LOCAL_ROOT/scripts/killit.sh
if [[ -s $PID_FILE ]]; then #if file exists and size > 0
  dump ">> Clockette is already running. \"Let it be.\" --The Beatles"
  dump ">> pid: $( cat /tmp/clockette.pid )"
  exit 0
fi
dump ">>> starting clockette..."
tmux run-shell "$LOCAL_ROOT/scripts/clockette.sh"
