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
    read -r -a timedate <<< $( date "+%l %M %S %p %a %m %d %Y" )
    local H="${timedate[0]}"
    local clock_utf8=$( printf '\\U%X' "$(( CLOCK + H - 1 ))" )
    local clock_icon=$( echo -e "$clock_utf8" )
    dump ">> clock_utf8 $clock_utf8"
    dump ">> clock_icon $clock_icon"
    dump ">> timedate.size: ${#timedate[@]}"
    dump ">> timedate.hour: ${timedate[0]}"
    tmux set -g @clockette "${clock_icon} %l#[blink]:#[noblink]%M%P"
    tmux refresh-client
    sleep 5
  done 
}

main
