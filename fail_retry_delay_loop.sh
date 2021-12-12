#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function fail_retry_delay_loop () {
  # check env var import first, before any "local" declarations,
  # in order to not hide env vars with the same name.
  case "$1" in
    env:* ) eval 'local RETRY_DELAY=$'"${1#*:}";;
    - ) local RETRY_DELAY=;;
    * ) local RETRY_DELAY="$1";;
  esac; shift

  local PROG="$1"; shift
  local PRE_PROG=()
  if [ ! -x "$PROG" ]; then
    case "$PROG" in
      *.js )
        PRE_PROG=( "$(which node{js,} 2>/dev/null | grep -m 1 -Pe '^/')" );;
      *.mjs ) PRE_PROG=( nodemjs );;
      *.pl ) PRE_PROG=( perl );;
      *.py ) PRE_PROG=( python );;
    esac
  fi

  local RV= DELAY=
  while true; do
    case "$PROG" in
      *.* | */* ) # assume local file
        [ -f "$PROG" ] || return 4$(echo "E: $FUNCNAME: $PROG vanished" >&2)
        ;;
    esac
    "${PRE_PROG[@]}" "$PROG" "$@" && return 0
    RV=$?
    [ -n "$RETRY_DELAY" ] || return "$RV"
    sleep "$RETRY_DELAY" &
    echo "D: $PROG exited with rv=$RV @ $(date +'%F %T'
      ). Will restart in $RETRY_DELAY or when you kill my sleep" \
      "(pid $! @ $HOSTNAME)."
    wait
  done
}










[ "$1" == --lib ] && return 0; fail_retry_delay_loop "$@"; exit $?
