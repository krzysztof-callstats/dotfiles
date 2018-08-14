#!/bin/bash
# usage: source cd_extentions.sh
# for best results add the above command to your .bashrc file

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CD_HISTORY_FILE="${SCRIPT_DIR}/.cd_history"
if [[ ! -e "$CD_HISTORY_FILE" ]] ; then
  touch "$CD_HISTORY_FILE"
fi

CD_FAV_FILE="${SCRIPT_DIR}/.cd_favorite"
if [[ ! -e "$CD_FAV_FILE" ]] ; then
  touch "$CD_FAV_FILE"
fi

function c () {
  LAST_HISTORY_ENTRY=`awk '/./{line=$0} END{print line}' "$CD_HISTORY_FILE"`
  if [[ $PWD != $LAST_HISTORY_ENTRY ]] ; then
    echo $PWD >> $CD_HISTORY_FILE
  fi
  builtin cd "$@"
}

function cd {
  c "$@"
}

function cb () {
  if ! [[ -z "`cat $CD_HISTORY_FILE`" ]]
    then
      PREV_DIR=`cat $CD_HISTORY_FILE | tail -1`;
      c "$PREV_DIR";
    else
      echo "History is empty"
    fi
}

function cbb () {
  if ! [[ -z "`cat $CD_HISTORY_FILE`" ]]
    then
      tac $CD_HISTORY_FILE | tail -10 | awk '{printf("%d %s\n", NR, $0)}';
      echo "Which one?";
      read -p "> " INDEX;
      DIR=`tac $CD_HISTORY_FILE | tail -10 | sed -n ${INDEX}p`;
      c "$DIR";
  else
    echo "History is empty"
  fi
}

function cf () {
  if [[ $# -eq 0 ]]
    then
      if ! [[ -z "`cat $CD_FAV_FILE`" ]]
        then
          FAV_DIR=`cat $CD_FAV_FILE`;
          c "$FAV_DIR"
      else
        echo "No favorite directory set. To set it up use:"
        echo "cf /your/favorite/dir"
      fi
  else
    echo "$(readlink -f $@)" > $CD_FAV_FILE;
    echo "Your favorite directory is now:" $(readlink -f $@)
    echo "To cd to your favorite directory, use: cf"
    echo "To change saved favorite directory, use: cf /your/new/favorite/dir"
  fi
}
