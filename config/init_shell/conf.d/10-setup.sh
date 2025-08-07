#!/usr/bin/env bash

p_export XDG_CONFIG_HOME "$HOME"/.config
add_path "$HOME"/.local/bin

# Homebrew
init_brew "${shell:?}"
eval "$(init_brew bash)"
