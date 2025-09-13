#!/usr/bin/env bash

# EDITOR
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  p_export EDITOR code_wait
else
  for editor in hx nano; do
    if has "$editor"; then
      p_export EDITOR "$editor"
      break
    fi
  done
fi

if [[ -n "$EDITOR" ]]; then
  p_abbr e "$EDITOR"
fi
if has sudo; then
  p_abbr E 'sudo -e'
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
  p_alias ll 'eza -aagl --smart-group'
  p_alias lll 'eza -lT --level=2'
else
  p_alias ll 'ls -al'
  if has tree; then
    p_alias lll 'tree --metafirst -puhDL 2'
  fi
fi

# fish
p_export fish_greeting

# less
p_export PAGER less
p_export LESS -iRFXMx4
p_export LESSHISTFILE ~/.cache/less-hist

# man
p_export MANOPT --no-justification

# mise
p_export MISE_FISH_AUTO_ACTIVATE 0
if has mise; then
  add_path "$HOME"/.local/share/mise/shims
fi

# starship
p_export STARSHIP_LOG error

# systemctl
if has systemctl; then
  p_abbr S 'sudo systemctl'
fi
