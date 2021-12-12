#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function grow_file () {
  local FILE="$1" MINSZ="$2"
  echo -n . >>"$FILE" || return $?
  local SIZE="$(stat -c %s -- "$FILE")"
  [ "${SIZE:-0}" -ge "$MINSZ" ] || return $?
}


[ "$1" == --lib ] && return 0; grow_file "$@"; exit $?
