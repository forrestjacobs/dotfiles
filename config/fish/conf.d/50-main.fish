# shared config
~/.local/bin/dot_shell fish | source

# `exec term` if mosh-server is the parent
if type -q term; and type -q tmux; and test (ps -p (string trim (ps -p "$fish_pid" -o ppid=)) -o comm=) = 'mosh-server'
  exec term
end
