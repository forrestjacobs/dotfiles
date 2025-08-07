#!/usr/bin/env bash

# EDITOR
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  p_export EDITOR code_wait
elif command -v hx &> /dev/null; then
  p_export EDITOR "$(which hx)"
fi

# bat
p_export BAT_STYLE numbers,changes
p_export BAT_THEME ansi

# eza
p_export EZA_ICONS_AUTO
p_export TIME_STYLE iso
if command -v eza &> /dev/null; then
  p_alias ls 'eza'
  p_alias ll 'eza -aagl'
  p_alias lll 'eza -glT --level=2'
else
  p_alias ll 'ls -al'
fi

# less
p_export PAGER less
p_export LESS -iRFXMx4
p_export LESSHISTFILE ~/.cache/less-hist

# man
p_export MANOPT --no-justification

# sudo
p_abbr se 'sudo -e'

# systemctl
if command -v systemctl &> /dev/null; then
  p_abbr S 'sudo systemctl'
fi
