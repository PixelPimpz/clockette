#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"

main()
{
  dump ">> killing clockette..."
  dump ">> $( cat /tmp/clockette.pid )" 
  dump ">> $( $PID_FILE )" 
  kill -s TERM $pid || fatal "SIGKILL failed"
  rm -f "$PID_FILE" || fatal "/tmp/clockette.pid not found"
  dump ">> /tmp/clockette.pid deleted."
}

main "$@"
