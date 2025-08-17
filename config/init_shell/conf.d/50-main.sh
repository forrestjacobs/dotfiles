#!/usr/bin/env bash

# `exec term` if mosh-server is the parent
# TODO: Do directly in this script
if [[ "${shell:?}" = "fish" ]]; then
  echo "if type -q term; and test (ps -p (string trim (ps -p \$fish_pid -o ppid=)) -o comm=) = 'mosh-server'"
  echo "  exec term"
  echo "end"
fi

# EDITOR
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  p_export EDITOR code_wait
elif has hx; then
  p_export EDITOR "$(which hx)"
fi

# bat
p_export BAT_STYLE numbers,changes
p_export BAT_THEME ansi

# eza
p_export EZA_ICONS_AUTO
p_export TIME_STYLE iso
if [[ "${shell:?}" = "fish" ]]; then
  # remove distro's ll
  echo "functions -e ll"
fi
if has eza; then
  p_alias ls 'eza'
  p_alias ll 'eza -aagl'
  p_alias lll 'eza -glT --level=2'
else
  p_alias ll 'ls -al'
fi

# fish
p_export fish_greeting

# hydro
p_export hydro_symbol_prompt ""
p_export hydro_color_pwd      green
p_export hydro_color_git      cyan
p_export hydro_color_duration normal
p_export hydro_color_error    red

# less
p_export PAGER less
p_export LESS -iRFXMx4
p_export LESSHISTFILE ~/.cache/less-hist

# man
p_export MANOPT --no-justification

# mise
p_export MISE_FISH_AUTO_ACTIVATE 0
if has mise; then
  if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    mise activate "$shell" --shims
  else
    mise activate "$shell"
  fi
fi

# sudo
p_abbr se 'sudo -e'

# systemctl
if has systemctl; then
  p_abbr S 'sudo systemctl'
fi
