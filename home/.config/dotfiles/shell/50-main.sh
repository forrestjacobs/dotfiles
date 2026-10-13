#!/usr/bin/env sh

: "${shell:?}"

# bat
p_export BAT_STYLE numbers,changes
p_export BAT_THEME ansi

# EDITOR
p_export EDITOR e

# eza
p_export EZA_ICONS_AUTO
p_export TIME_STYLE iso

# fish
p_export fish_greeting
# less
p_export PAGER less
p_export LESS -iRFXMx4
p_export LESSHISTFILE \$HOME/.cache/less-hist

# man
p_export MANOPT --no-justification

# mise
add_path \$HOME/.local/share/mise/shims
p_source mise activate --shims "${shell}"
p_abbr mr 'mise run'

# starship
p_export STARSHIP_LOG error

# sudo
p_abbr E 'sudo -e'

# systemctl
p_abbr s systemctl
p_abbr S 'sudo systemctl'
