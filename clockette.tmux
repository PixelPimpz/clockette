#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$( tmux show -gqv @CHER )/dump.fun"
tmux bind M-c run-shell "$LOCAL_ROOT/clockette.tmux"
tmux bind M-x run-shell "$LOCAL_ROOT/scripts/killit.sh"
main()
{
  local pid=$( cat "$PID_FILE" ) 2>/dev/null || pid=''
  if [[ -n "$pid" && "$pid" =~ ^[0-9]+$ && kill --signal 0 $pid 2>/dev/null ]]; then 
    dump ">> Clockette is already running. \"Let it be.\" --The Beatles"
    dump ">> pid: $( cat /tmp/clockette.pid )"
  else
    rm -f $PID_FILE
    dump ">>> starting clockette..."
    tmux run-shell -b "$LOCAL_ROOT/scripts/clockette.sh"
  fi
}

main "$@"
