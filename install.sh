#!/usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

echo 'Linking config files'
./home/.local/bin/dot_clean_links "${HOME}/.config"
./home/.local/bin/dot_clean_links "${HOME}/.local/bin"
./home/.local/bin/dot_clean_links "${HOME}/.local/share"
./home/.local/bin/dot_stow home "${HOME}"

echo
echo 'Initializing shell'
eval "$(shell=bash ./home/.config/dotfiles/shell/10-setup.sh)"

echo
echo 'Done!'

echo
echo "Calling 'dot_doctor'"
dot_doctor

popd > /dev/null
