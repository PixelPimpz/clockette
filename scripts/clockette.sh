#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
SHARE="$( tmux show -gqv @CHER )"
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
trap fatal EXIT

main()
{
  local time=
  echo "$$" > $PID_FILE
  dump ">>> clockette: running."
  read -r -a TIME <<< $( date "+%l %M %S %P" )
  tmux set -g '@clockette' "${TIME[0]}:${TIME[1]}:${TIME[3]}"
  dump ">> hour:   ${TIME[0]}"
  dump ">> minute: ${TIME[1]}"
  dump ">> second: ${TIME[2]}"
  dump ">> suffix: ${TIME[3]}"
}

main
