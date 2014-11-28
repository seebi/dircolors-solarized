#!/usr/bin/env bash

gnomeVersion="$(expr "$(gnome-terminal --version)" : '.* \(.*[.].*[.].*\)$')"
dircolors_checked=false


declare -a profiles
if [ "$newGnome" = "1" ]
  then profiles=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g'))
else
  profiles=($(gconftool-2 -R $gconfdir | grep $gconfdir | cut -d/ -f5 |  \
           cut -d: -f1))
fi


create_new_profile() {
  profile_id="$(uuidgen)"
  dconf write $dconfdir/default "'$profile_id'"
  dconf write $dconfdir/list "['$profile_id']"
  profile_dir="$dconfdir/:$profile_id"
  dconf write $profile_dir/visible-name "'Default'"
}

get_uuid() {
  # Print the UUID linked to the profile name sent in parameter
  local profile_name=$1
  for i in ${!profiles[*]}
    do
      if [[ "$(dconf read $dconfdir/${profiles[i]}/visible-name)" == \
          "'$profile_name'" ]]
        then echo "${profiles[i]}"
        return 0
      fi
    done
  echo "$profile_name"
}

validate_profile() {
  local profile=$1
  in_array $profile "${profiles[@]}" || die "$profile is not a valid profile" 3
}

get_profile_name() {
  local profile_name

  # dconf still return "" when the key does not exist, gconftool-2 return 0,
  # but it does priint error message to STDERR, and command substitution
  # only gets STDOUT which means nothing at this point.
  if [ "$newGnome" = "1" ]
    then profile_name="$(dconf read $dconfdir/$1/visible-name | sed s/^\'// | \
        sed s/\'$//)"
  else
    profile_name=$(gconftool-2 -g $gconfdir/$1/visible_name)
  fi
  [[ -z $profile_name ]] && die "$1 (No name)" 3
  echo $profile_name
}

interactive_new_profile() {
  local confirmation

  echo    "No profile found"
  echo    "You need to create a new default profile to continue. Continue ?"
  echo -n "(YES to continue) "

  read confirmation
  if [[ $(echo $confirmation | tr '[:lower:]' '[:upper:]') != YES ]]
  then
    die "ERROR: Confirmation failed -- ABORTING!"
  fi

  echo -e "Profile \"Default\" created\n"
}

interactive_select_profile() {
  local profile_key
  local profile_name
  local profile_names
  local profile_count=$#

  declare -a profile_names
  while [ $# -gt 0 ]
  do
    profile_names[$(($profile_count - $#))]=$(get_profile_name $1)
    shift
  done

  set -- "${profile_names[@]}"

  echo "Please select a Gnome Terminal profile:"
  select profile_name
  do
    if [[ -z $profile_name ]]
    then
      die "ERROR: Invalid selection -- ABORTING!" 3
    fi
    profile_key=$(expr ${REPLY} - 1)
    break
  done
  echo

  profile=${profiles[$profile_key]}
}


check_empty_profile() {
  if [ "$profiles" = "" ]
    then interactive_new_profile
    create_new_profile
    profiles=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g'))
  fi
}
