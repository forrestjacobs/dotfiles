# `exec term` if mosh-server is the parent
if type -q term; and test (ps -p (ps -p $fish_pid -o ppid=) -o comm=) = 'mosh-server'
  exec term
end

# export variables from env file
export (grep "^[^#]" "$HOME"/.config/forrest/env.conf | xargs -L 1)

# aliases
source "$HOME"/.config/forrest/alias.conf

# homebrew
if test -x /opt/homebrew/bin/brew
  /opt/homebrew/bin/brew shellenv | source
end

# Add bin
functions -e ll
fish_add_path "$HOME"/.local/bin

# fish
set -xg fish_greeting

# helix
if type -q hx
  set -xg EDITOR hx
end

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
