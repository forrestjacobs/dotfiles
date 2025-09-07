#!/usr/bin/env bash

if has fzf; then
  fzf "--${shell:?}"
fi

if has starship; then
  starship init "${shell:?}"
  echo
fi

if has zoxide; then
  zoxide init "${shell:?}"
fi
