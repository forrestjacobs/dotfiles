#!/usr/bin/env bash
set -e

echo 'Linking config files'
"$(dirname "${BASH_SOURCE:0}")/home/.local/bin/dot_relink"

echo 'Initializing shell'
eval "$(shell=bash "${HOME}/.config/dotfiles/shell/10-setup.sh")"

echo "Calling 'dot_setup'"
dot_setup
