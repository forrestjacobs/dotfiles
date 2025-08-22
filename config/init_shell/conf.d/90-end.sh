#!/usr/bin/env bash

if has starship; then
  starship init "${shell:?}"
  echo
fi

if has zoxide; then
  zoxide init "${shell:?}" --cmd cd
fi
