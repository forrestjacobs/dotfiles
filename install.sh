#!/usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

echo 'Linking config files'
./home/.local/bin/dot_relink

echo 'Initializing shell'
eval "$(shell=bash ./home/.config/dotfiles/shell/10-setup.sh)"

echo "Calling 'dot_doctor'"
dot_doctor

popd > /dev/null
