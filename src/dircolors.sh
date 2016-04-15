#!/usr/bin/env bash

dircolors_checked=false
DIRCOLORS_DIR="$(echo ~/.dir_colors)"
DIRCOLORS_SOLARIZED="$(pwd)"
DIRCOLORS_REPO_ADRESS="https://github.com/seebi/dircolors-solarized"
DIRCOLORS_DL_ADRESS="https://raw.github.com/seebi/dircolors-solarized/master/"

dl_dircolors() {
  echo
  eval "wget -O "$DIRCOLORS_SOLARIZED/dircolors" \
      "$DIRCOLORS_DL_ADRESS/dircolors.ansi-$scheme""
  valid=$?
  if [ ! "$valid" == "0" -o ! -e "$DIRCOLORS_SOLARIZED/dircolors" ]
    then echo -e "Download failed, dircolors will not be copied but you "
    echo -en "can install it from the official repository : "
    echo "$DIRCOLORS_REPO_ADRESS"
    return 1
  fi
  return 0
}

copy_dicolors() {
  if [ "$1" != 1 ]
    then return
  elif [ -f "$DIRCOLORS_DIR/dircolors" ]
    eval dl_dircolors
    dl_ok=$?
    then if [ $dl_ok ]
      then mv "$DIRCOLORS_DIR/dircolors" "$DIRCOLORS_DIR/dircolors.old"
      echo -e "$DIRCOLORS_DIR/dircolors already exists, renaming it to"
      echo "dircolors.old"
    fi
  fi
  cp "$DIRCOLORS_SOLARIZED/dircolors" "$DIRCOLORS_DIR/dircolors"
  echo
  echo "The new dircolors have been installed to $DIRCOLORS_DIR/dircolors."
  echo
  echo "Add \"eval \`dircolors /path/to/dircolorsdb\`\" in your shell "
  echo "configuration file (.bashrc, .zshrc, etc...) to use new dircolors."
  echo
  echo -en "Do not forget to remove old dircolors from your shell "
  echo -en "configuration file if they were named differently than "
  echo -en "\"dircolors\".\n"
  echo
}

interactive_dircolors() {
  noselect=true
  while $noselect
  do
    echo
    echo -en "A dircolors already exists, but can be incompatible with the "
    echo -en "solarized color scheme causing some colors problems when doing "
    echo -en "a \"ls\".\n"
    echo
    echo -en "1) Replace the actual dircolors by seebi' "
    echo -en "dircolors-solarized: "
    echo -en "https://github.com/seebi/dircolors-solarized (the actual "
    echo -en "dircolors will be keeped as backup).\n"
    echo
    echo -en "2) [DEFAULT] I am awared about this potentiall problem and will "
    echo -en "check my dircolors (default path: ~/.dir_colors/dircolors) "
    echo -en "in case of conflict.\n"
    echo
    read -p "Enter your choice : [2] " selection
    selection=${selection:-2}

    if [ "$selection" -gt 2 -o "$selection" -lt 1 ]
      then echo "$selection is not a valid entry. Please Restart"
      echo
      noselect=true
    else
      noselect=false
    fi
  done
  copy_dicolors $selection
}

check_dircolors() {
  nonempty=false
  if [ -d "$DIRCOLORS_DIR" ]
    then  [ "$(ls -A $DIRCOLORS_DIR)" ] && nonempty=true || nonempty=false
  fi
  if [ $nonempty = true ]
    then interactive_dircolors
  fi
  return $(! $nonempty)
}

warning_message_dircolors() {
  echo -en "If there is any problem with the colors when doing a \"ls\", "
  echo -en "please check your dircolors.\n"
}

