# XDG
set -xg XDG_CONFIG_HOME "$HOME"/.config
set -xg XDG_DATA_HOME "$HOME"/.local/share
set -xg XDG_CACHE_HOME "$HOME"/.cache

# homebrew
if test -x /opt/homebrew/bin/brew
  /opt/homebrew/bin/brew shellenv | source
end

functions -e ll
fish_add_path "$HOME"/.local/bin

# bat
set -xg BAT_STYLE numbers,changes
set -xg BAT_THEME ansi

# eza
set -xg EZA_ICONS_AUTO
set -xg TIME_STYLE iso

# fish
set -xg fish_greeting

# helix
if type -q hx
  set -xg EDITOR hx
end
abbr --add --global -- se "sudo -e"

# hydro
set -xg hydro_symbol_prompt ""
set -xg hydro_color_pwd      green
set -xg hydro_color_git      cyan
set -xg hydro_color_duration normal
set -xg hydro_color_error    red

# less
set -xg PAGER less
set -xg LESS -iRFXMx4
set -xg LESSHISTFILE "$XDG_CACHE_HOME"/less-hist

# man
set -xg MANOPT --no-justification

# zoxide -- should be toward the end
if type -q zoxide
  zoxide init fish --cmd cd | source
end
