#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
dump ">>> scripts/clockette.sh running..."

main()
{
  echo "$$" > "/tmp/clockette.pid"
  tmux set -g @clockette "%l#[blink]:#[noblink]%H%P"
  tmux source "$TMUX_ROOT/tmux.conf"tmux refresh-client
}
