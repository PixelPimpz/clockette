#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
main()
{
  dump ">> killing clockette..."
  local pid=$( cat "/tmp/clockette.pid" ) || pid=''
  if [[ -n "$pid" && $pid =~ ^[0-9]+$ ]] && kill -0 $pid 2>/dev/null; then
    kill -s TERM $pid && dump "clockette terminated"
  else
    dump "SIGTERM failed. Clockette was probably not running"
  fi
  rm -f "$PID_FILE" 2>/dev/null && dump ">> /tmp/clockette.pid deleted." 
}

main
