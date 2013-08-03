#!/usr/bin/env bash

dir=$(dirname $0)
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

declare -a schemes
schemes=(dark light)

declare -a profiles
if [ "$newGnome" = "1" ]
  then profiles=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g'))
else
  profiles=($(gconftool-2 -R $gconfdir | grep $gconfdir | cut -d/ -f5 |  \
           cut -d: -f1))
fi

die() {
  echo $1
  exit ${2:-1}
}

in_array() {
  local e
  for e in "${@:2}"; do [[ $e == $1 ]] && return 0; done
  return 1
}

show_help() {
  echo
  echo "Usage"
  echo
  echo "    install.sh [-h|--help] \\"
  echo "               (-s <scheme>|--scheme <scheme>|--scheme=<scheme>) \\"
  echo "               (-p <profile>|--profile <profile>|--profile=<profile>)"
  echo
  echo "Options"
  echo
  echo "    -h, --help"
  echo "        Show this information"
  echo "    -s, --scheme"
  echo "        Color scheme to be used"
  echo "    -p, --profile"
  echo "        Gnome Terminal profile to overwrite"
  echo
}

validate_scheme() {
  local profile=$1
  in_array $scheme "${schemes[@]}" || die "$scheme is not a valid scheme" 2
}

createNewProfile() {
  # b1dcc9dd-5262-4d8d-a863-c897e6d979b9 is totally abitrary, I took my
  # profile id
  profile_id="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
  dconf write $dconfdir/default "'$profile_id'"
  dconf write $dconfdir/list "['$profile_id']"
  profile_dir="$dconfdir/:$profile_id"
  dconf write $profile_dir/visible-name "'Default'"
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
    then profile_name=$(dconf read $dconfdir/$1/visible-name)
  else
    profile_name=$(gconftool-2 -g $gconfdir/$1/visible_name)
  fi
  [[ -z $profile_name ]] && die "$1 is not a valid profile" 3
  echo $profile_name
}

set_profile_colors() {
  local profile=$1
  local scheme=$2

  case $scheme in
    dark  )
      local bg_color_file=$dir/colors/base03
      local fg_color_file=$dir/colors/base0
      local bd_color_file=$dir/colors/base1
    ;;

    light )
      local bg_color_file=$dir/colors/base3
      local fg_color_file=$dir/colors/base00
      local bd_color_file=$dir/colors/base01
    ;;
  esac

  if [ "$newGnome" = "1" ]
    then local profile_path=$dconfdir/$profile

    # set color palette
    dconf write $profile_path/palette "[$(cat $dir/colors/palette-new)]"

    # set foreground, background and highlight color
    dconf write $profile_path/bold-color "'$(cat $bd_color_file)'"
    dconf write $profile_path/background-color "'$(cat $bg_color_file)'"
    dconf write $profile_path/foreground-color "'$(cat $fg_color_file)'"

    # make sure the profile is set to not use theme colors
    dconf write $profile_path/use-theme-colors "false"

    # set highlighted color to be different from foreground color
    dconf write $profile_path/bold-color-same-as-fg "false"

  else
    local profile_path=$gconfdir/$profile

    # set color palette
    gconftool-2 -s -t string $profile_path/palette $(cat $dir/colors/palette)

    # set foreground, background and highlight color
    gconftool-2 -s -t string $profile_path/bold_color       $(cat $bd_color_file)
    gconftool-2 -s -t string $profile_path/background_color $(cat $bg_color_file)
    gconftool-2 -s -t string $profile_path/foreground_color $(cat $fg_color_file)

    # make sure the profile is set to not use theme colors
    gconftool-2 -s -t bool $profile_path/use_theme_colors false

    # set highlighted color to be different from foreground color
    gconftool-2 -s -t bool $profile_path/bold_color_same_as_fg false
  fi
}

interactive_help() {
  echo
  echo "This script will ask you if you want a light or dark color scheme, and"
  echo "which Gnome Terminal profile to overwrite."
  echo
  echo "Please note that there is no uninstall option yet. If you do not wish"
  echo "to overwrite any of your profiles, you should create a new profile"
  echo "before you run this script. However, you can reset your colors to the"
  echo "Gnome default, by running:"
  echo
  echo "    Gnome >= 3.8 dconf reset -f /org/gnome/terminal/legacy/profiles:/"
  echo "    Gnome < 3.8 gconftool-2 --recursive-unset /apps/gnome-terminal"
  echo
  echo "By default, it runs in the interactive mode, but it also can be run"
  echo "non-interactively, just feed it with the necessary options, see"
  echo "'install.sh --help' for details."
  echo
}

interactive_select_scheme() {
  echo "Please select a color scheme:"
  select scheme
  do
    if [[ -z $scheme ]]
    then
      die "ERROR: Invalid selection -- ABORTING!" 2
    fi
    break
  done
  echo
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

check_empty_profile() {
  if [ "$profiles" = "" ]
    then interactive_new_profile
    createNewProfile
    profiles=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g'))
  fi
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

interactive_confirm() {
  local confirmation

  echo    "You have selected:"
  echo
  echo    "  Scheme:  $scheme"
  echo    "  Profile: $(get_profile_name $profile) ($profile)"
  echo
  echo    "Are you sure you want to overwrite the selected profile?"
  echo -n "(YES to continue) "

  read confirmation
  if [[ $(echo $confirmation | tr '[:lower:]' '[:upper:]') != YES ]]
  then
    die "ERROR: Confirmation failed -- ABORTING!"
  fi

  echo    "Confirmation received -- applying settings"
}

while [ $# -gt 0 ]
do
  case $1 in
    -h | --help )
      show_help
      exit 0
    ;;
    --scheme=* )
      scheme=${1#*=}
    ;;
    -s | --scheme )
      scheme=$2
      shift
    ;;
    --profile=* )
      profile=${1#*=}
    ;;
    -p | --profile )
      profile=$2
      shift
    ;;
  esac
  shift
done

if [[ -z $scheme ]] || [[ -z $profile ]]
then
  interactive_help
  interactive_select_scheme "${schemes[@]}"
  if [ "$newGnome" = "1" ]
    then check_empty_profile
  fi
  interactive_select_profile "${profiles[@]}"
  interactive_confirm
fi

if [[ -n $scheme ]] && [[ -n $profile ]]
then
  validate_scheme $scheme
  validate_profile $profile
  set_profile_colors $profile $scheme
fi
