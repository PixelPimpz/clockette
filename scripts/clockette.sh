#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
dump ">>> scripts/clockette.sh running..."


tmux set -g @clockette "time"
tmux source "$TMUX_ROOT/tmux.conf"
tmux refresh-client
