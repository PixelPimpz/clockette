#!/usr/bin/env bash
SHARE=$( tmux show -gqv @CHER )
CLOCK="0xF143F"
source "$SHARE/fun/dump.fun"
source "$SHARE/fun/fatal.fun"
dump ">>> scripts/clockette.sh running..." -a

main()
{
  local SPC=" "
  echo "$$" > "/tmp/clockette.pid"
  while true; do
    read -r -a timedate <<< $( date "+%l %M %S %p %a %m %d %Y" )
    (( timedate[0] <= 9 )) && SPC="" || SPC=" "
    local s2nm=$(( ( 60 - "10#${timedate[2]}" ) % 60 )) 
    local m2nh=$(( 59 - "10#${timedate[1]}" )) 
    local interval=$(( s2nm + m2nh * 60 ))

    local clock_utf8=$( printf '\\U%X' "$(( CLOCK + "${timedate[0]}" - 1 ))" )
    local clock=$( echo -e "$clock_utf8" )
    tmux set -g @clockette "${clock}${SPC}%l#[blink]:#[noblink]%M%P"
    tmux set -g @today "${timedate[4]:0:2} %m/%d/%y"
    tmux refresh-client
    sleep $interval
  done 
}

main
