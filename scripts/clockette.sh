#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
source "$( tmux show -gqv @CHER )/dump.fun"
source "$( tmux show -gqv @CHER )/fatal.fun"
trap fatal EXIT

main()
{
  local time=
  echo "$$" > $PID_FILE
  tmux bind M-x run-shell "killit.sh"
  dump ">>> clockette: running. <prefix> + [C-x] to kill."
  read -r -a TIME <<< $( date "+%l %M %S %P" )
  tmux set -g '@clockette' "${TIME[0]}:${TIME[1]}:${TIME[3]}"
  dump ">> hour:   ${TIME[0]}"
  dump ">> minute: ${TIME[1]}"
  dump ">> second: ${TIME[2]}"
  dump ">> suffix: ${TIME[3]}"
}

main
