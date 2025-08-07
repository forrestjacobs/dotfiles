#!/usr/bin/env bash

if command -v zoxide &> /dev/null; then
  zoxide init "${shell:?}" --cmd cd
fi
