# export variables from env file
set -a
. ~/.config/forrest/env.ini
set +a

# Add bin
unalias -a
PATH=$PATH:"$HOME"/.local/bin
