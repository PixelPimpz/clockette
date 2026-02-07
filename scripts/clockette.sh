#!/usr/bin/env bash
PID_FILE="/tmp/clockette.pid"
source "$( tmux show -gqv @CHER )/dump.fun"
source "$( tmux show -gqv @CHER )/fatal.fun"
trap fatal EXIT

main()
{
  echo "$$" > $PID_FILE
  dump ">>> clockette: running. <prefix> + [C-x] to kill."
  tmux bind M-x tmux run-shell "kill -s KILL $(cat $PID_FILE ) \; dump \">> Stopping clockette.\"" 
}

main
