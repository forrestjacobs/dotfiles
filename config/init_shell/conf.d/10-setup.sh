#!/usr/bin/env bash

p_export XDG_CONFIG_HOME "$HOME"/.config
add_path "$HOME"/.local/bin

# Homebrew
for brew_path in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if has "$brew_path"; then
    $brew_path shellenv "${shell:?}"
    eval "$($brew_path shellenv bash)"
    break
  fi
done
