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
    local s2nm=(( 60 - ${timedate[2]} ))
    local m2nh=(( 60 - ${timedate[1]} ))
    local interval=$(( s2nm + m2nh ))
    dump ">> interval: $interval"
    local clock_utf8=$( printf '\\U%X' "$(( CLOCK + "${timedate[0]}" - 1 ))" )
    local clock_icon=$( echo -e "$clock_utf8" )
    tmux set -g @clockette "${clock_icon} %l#[blink]:#[noblink]%M%P"
    tmux refresh-client
    sleep 5
  done 
}

main
