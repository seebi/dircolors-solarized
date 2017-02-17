#!/usr/bin/env bash

dir=`dirname $0`
source $dir/src/tools.sh

get_default_profile() {
  if [ "$newGnome" = "1" ]
    then profile_id="$(dconf read $dconfdir/default | \
        sed s/^\'// | sed s/\'$//)"
    profile_name="$(dconf read $dconfdir/":"$profile_id/visible-name | \
        sed s/^\'// | sed s/\'$//)"
  else
    profile_name="$(gconftool-2 -g \
        /apps/gnome-terminal/global/default_profile)"
  fi
  echo $profile_name
}

SCHEME=$1
PROFILE=${2:-"$(get_default_profile)"}
shift; shift
$dir/install.sh -s "$SCHEME" -p "$PROFILE" $*
