#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
source "$( tmux show -gqv @CHER )/dump.fun"
source "$( tmux show -gqv @CHER )/fatal.fun"
trap fatal EXIT

main()
{
  local time=
  echo "$$" > $PID_FILE
  tmux bind M-x run-shell "killit" 
  dump ">>> clockette: running. <prefix> + [C-x] to kill."
  read -r -a time <<< $( date "+%l %M %P" )
  dump ">> hour: ${time[1]}"
}

killit()
{
  dump ">> killing clockette..."
  kill -s KILL "$( cat $PID_FILE )"
  [[ -f "$PID_FILE" ]] && rm -f "$PID_FILE" || fatal "/tmp/clockette.pid not found"
  dump ">> /tmp/clockette.pid deleted."
}

main
