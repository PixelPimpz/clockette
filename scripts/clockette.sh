#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
CLOCK="0xF143F"
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
dump ">>> scripts/clockette.sh running..."

main()
{
  echo "$$" > "/tmp/clockette.pid"
  while true; do
    read -r -A timedate <<< "$( date +%l %M %S %p %a %m %d %Y )"
    local H="${timedate[0]}"
    local clock_hex="(( CLOCK + H ))"
    local clock_utf8="${clock_hex/0x/\\U}"
    tmux set -g @clock_utf8 "(( clock_hex + H - 1 ))"
    dump ">> timedate.size: ${#timedate[@]}"
    dump ">> timedate.hour: ${timedate[0]}"
    tmux set -g @clockette "%l#[blink]:#[noblink]%M%P"
    tmux refresh-client
    sleep 5
  done 
}

getIcon()
{
  local hour="$1" || local hour = 0
  clock_hex=(( 0xF143F + $hour ))
  clock_utf8= "${clock_hex/0x/\\U}"
  dump ">> clock_utf8: $clock_utf8"
  echo "$clock_utf8"
}

main
