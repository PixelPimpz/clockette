#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
CLOCK="0xF143F"
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
dump ">>> scripts/clockette.sh running..."

main()
{
  echo "$$" > "/tmp/clockette.pid"
  icon_base_hex=0xF143F
  while true; do
    read -r -A timedate <<< "$( date +%l %M %S %p %a %m %d %Y )"
    dump ">> timedate.size: ${#timedate[@]}"
    dump ">> timedate.hour: ${timedate[0]}"
    dump ">> icon: $( getIcon ${timedate[0]} )"
    tmux refresh-client
    tmux set -g @clockette "%l#[blink]:#[noblink]%M%P"
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
