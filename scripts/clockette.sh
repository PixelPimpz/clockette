#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
dump ">>> scripts/clockette.sh running..."

main()
{
  echo "$$" > "/tmp/clockette.pid"
  while true; do
    tmux set -g @clockette "%l#[blink]:#[noblink]%H%P"
    tmux refresh-client
    sleep 5
  done
}

main
