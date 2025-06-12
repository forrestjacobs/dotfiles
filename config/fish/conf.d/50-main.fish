# `exec term` if mosh-server is the parent
if type -q term; and test (ps -p (string trim (ps -p $fish_pid -o ppid=)) -o comm=) = 'mosh-server'
  exec term
end

# homebrew
if test -x /opt/homebrew/bin/brew
  /opt/homebrew/bin/brew shellenv | source
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
  /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

# aliases/abbrs/functions
functions -e ll

abbr se 'sudo -e'

if type -q eza
  alias ls 'eza'
  alias ll 'eza -aagl'
  alias lll 'eza -glT --level=2'
else
  alias ll 'ls -al'
end

if type -q systemctl
  abbr S 'sudo systemctl'
end

# Add bin
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

# less
set -xg PAGER less
set -xg LESS -iRFXMx4
set -xg LESSHISTFILE ~/.cache/less-hist

# man
set -xg MANOPT --no-justification

# hydro
set -xg hydro_symbol_prompt ""
set -xg hydro_color_pwd      green
set -xg hydro_color_git      cyan
set -xg hydro_color_duration normal
set -xg hydro_color_error    red

# zoxide -- should be toward the end
if type -q zoxide
  zoxide init fish --cmd cd | source
end
