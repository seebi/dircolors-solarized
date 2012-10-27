#!/usr/bin/env bash

dir=$(dirname $0)

gconfdir=/apps/gnome-terminal/profiles

declare -a profiles
profiles=($(gconftool-2 -R $gconfdir | grep $gconfdir | cut -d/ -f5 |  cut -d: -f1))

declare -a visnames
for index in  ${!profiles[@]}
do
    visnames[$index]=$(gconftool-2 -g $gconfdir/${profiles[$index]}/visible_name)
done

echo "This script will ask you if you want a light or dark color scheme, and"
echo "which Gnome Terminal profile to overwrite."
echo
echo "Please note that there is no uninstall option yet. If you do not wish"
echo "to overwrite any of your profiles, you should create a new profile"
echo "before you run this script. However, you can reset your colors to the"
echo "Gnome default, by running:"
echo "gconftool-2 --recursive-unset /apps/gnome-terminal"
echo

###############################
### Select the color scheme ###
###############################

echo "Please select a color scheme:"
select scheme in light dark
do
  if [[ -z $scheme ]]
  then
    echo "ERROR: Invalid selection -- ABORTING!"
    exit 2
  fi

  case $scheme in
    light ) bg_color_file=$dir/colors/base3
            fg_color_file=$dir/colors/base00
            bd_color_file=$dir/colors/base01
            ;;

    dark  ) bg_color_file=$dir/colors/base03
            fg_color_file=$dir/colors/base0
            bd_color_file=$dir/colors/base1
            ;;
  esac
  break
done
echo

########################
### Select a profile ###
########################

echo "Please select a Gnome Terminal profile:"
select profile_name in "${visnames[@]}"
do
  if [[ -z $profile_name ]]
  then
    echo "ERROR: Invalid selection -- ABORTING!"
    exit 1
  fi
  profile_key=$(expr ${REPLY} - 1)
  break
done
echo

profile=${profiles[$profile_key]}

#########################################################
### Show the choices made and prompt for confirmation ###
#########################################################

echo    "You have selected:"
echo
echo    "  Scheme:  $scheme"
echo    "  Profile: $profile_name (gconf key: $profile)"
echo
echo    "Are you sure you want to overwrite the selected profile?"
echo -n "(YES to continue) "

read confirmation
confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation != YES ]]
then
  echo "ERROR: Confirmation failed -- ABORTING!"
  exit 3
fi

echo    "Confirmation received -- applying settings"

########################
### Finally... do it ###
########################

profile_path=$gconfdir/$profile

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
