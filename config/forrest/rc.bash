# export variables from env file
set -a
. ~/.config/forrest/env.conf
set +a

# Aliases
unalias -a
. ~/.config/forrest/alias.conf

# Add bin
PATH=$PATH:"$HOME"/.local/bin
