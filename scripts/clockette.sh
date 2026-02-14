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
    local s2nm=$(( ( 60 - "10#${timedate[2]}" ) % 60 )) 
    local m2nh=$(( 59 - "10#${timedate[1]}" )) 
    local interval=$(( s2nm + m2nh * 60 ))

    dump ">> interval: $interval"
    #local clock_utf8=$( printf -e '\\U%X' "$(( CLOCK + "${timedate[0]}" - 1 ))" )
    local clock=$( printf -b '\\U%X' "$(( CLOCK + "${timedate[0]}" - 1 ))" )
    i#local clock_icon=$( echo -e "$clock_utf8" )
    tmux set -g @clockette "${clock} %l#[blink]:#[noblink]%M%P"
    tmux refresh-client
    sleep 5
  done 
}

main
