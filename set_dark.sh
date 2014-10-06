#!/usr/bin/env bash

dir=`dirname $0`
gnomeVersion="$(expr "$(gnome-terminal --version)" : '.* \(.*[.].*[.].*\)$')"

# newGnome=1 if the gnome-terminal version >= 3.8
if [[ ("$(echo "$gnomeVersion" | cut -d"." -f1)" = "3" && \
       "$(echo "$gnomeVersion" | cut -d"." -f2)" -ge 8) || \
       "$(echo "$gnomeVersion" | cut -d"." -f1)" -ge 4 ]]
  then newGnome="1"
  dconfdir=/org/gnome/terminal/legacy/profiles:
else
  newGnome=0
  gconfdir=/apps/gnome-terminal/profiles
fi

get_default_profile() {
  if [ "$newGnome" = "1" ]
    then profile_id="$(dconf read $dconfdir/default | \
        sed s/^\'// | sed s/\'$//)"
    profile_name="$(dconf read $dconfdir/":"$profile_id/visible-name | \
        sed s/^\'// | sed s/\'$//)"
  else
    profile_id="$(gconftool-2 -g \
        /apps/gnome-terminal/global/default_profile)"
    profile_name=$(gconftool-2 -g $gconfdir/$profile_id/visible_name)
  fi
  echo $profile_name
}

PROFILE=${1:-$(get_default_profile)}

$dir/install.sh -s dark -p "$PROFILE"
