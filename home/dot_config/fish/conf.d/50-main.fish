# remove distro's ll
functions -e ll

set -gx MISE_FISH_AUTO_ACTIVATE 0

# shared config
~/.local/bin/dot_shell fish | source
