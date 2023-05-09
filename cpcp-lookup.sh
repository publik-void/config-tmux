#!/bin/sh

# A script to look for `cpcp.sh` in multiple locations and then run it with any
# provided arguments.

locations="\
  $HOME/.config/cross-platform-copy-paste/cpcp.sh \
  cpcp \
  cpcp.sh"

#[ "$CPCP_LOCATION" ] && locations="$CPCP_LOCATION $locations"

get_cpcp_command() (
  [ $# = 0 ] && return 1
  type "$1" 1> /dev/null 2> /dev/null && { printf "%s" "$1"; return 0; }
  shift 1; get_cpcp_command $@
)

cpcp=$(get_cpcp_command $locations)
if [ $? = 0 ]; then
  eval "$cpcp" $@
else
  printf "%s\n" "$0: CPCP could not be located." >&2; exit 1
fi

