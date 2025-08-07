# `exec term` if mosh-server is the parent
if type -q term; and test (ps -p (string trim (ps -p $fish_pid -o ppid=)) -o comm=) = 'mosh-server'
  exec term
end

# clear distro config
functions -e ll

# shared config
~/.local/bin/init_shell fish | source

# fish
set -xg fish_greeting

# hydro
set -xg hydro_symbol_prompt ""
set -xg hydro_color_pwd      green
set -xg hydro_color_git      cyan
set -xg hydro_color_duration normal
set -xg hydro_color_error    red
