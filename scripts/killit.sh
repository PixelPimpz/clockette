#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
main()
{
  local pidfile="$1"
  dump ">> killing clockette..."
  dump "$( cat $pidfile )"
  kill -s KILL "$( cat $pidfile )"
  rm -f "$pidfile" || fatal "/tmp/clockette.pid not found"
  dump ">> /tmp/clockette.pid deleted."
}

main "$@"
