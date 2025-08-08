#!/usr/bin/env bash

if has zoxide; then
  zoxide init "${shell:?}" --cmd cd
fi
