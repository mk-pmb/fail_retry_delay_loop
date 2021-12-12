#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function test_grow_file () {
  local CNT="tmp.counter.$$"
  >"$CNT" || return $?
  SECONDS=0
  RETRY_DELAY=2s fail_retry_delay_loop env:RETRY_DELAY \
    ./grow_file.sh "$CNT" 4 || return $?
  local DURA="$SECONDS"
  [ "$(cat -- "$CNT")" == .... ] || return 2$(echo "E: bad data" >&2)
  rm -- "$CNT"
  [ "$DURA" -ge 6 ] || return 2$(echo "E: finished too early" >&2)
  [ "$DURA" -le 8 ] || return 2$(echo "E: finished too late" >&2)
}


test_grow_file "$@"; exit $?
