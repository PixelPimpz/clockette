#!/usr/bin/env bash
PID_FILE=$1
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"

main()
{
  local pid="$( cat $PID_FILE )"
  dump ">> killing clockette..."
  dump "$pid"
  kill -s KILL $pid || fatal "SIGKILL failed"
  rm -f "$PID_FILE" || fatal "/tmp/clockette.pid not found"
  dump ">> /tmp/clockette.pid deleted."
}

main "$@"
