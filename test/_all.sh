#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function all_tests () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?
  local TEST=
  for TEST in [0-9]*.sh; do
    echo "=== test: $(basename -- "$TEST" .sh | tr '_' ' ') ==="
    ./"$TEST" || return $?$(echo "E: $TEST failed, rv=$?" >&2)
    echo
  done
  echo "=== All tests passed. ==="
}


all_tests "$@"; exit $?
