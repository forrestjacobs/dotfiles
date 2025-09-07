#!/usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

symlink="${HOME}/.local/dotfiles"
target="$(pwd)"
if [ ! -L "$symlink" ]; then
  mkdir -p "$(dirname "$symlink")"
  ln -s "$target" "$symlink"
elif [ "$(readlink -f "$symlink")" != "$target" ]; then
  echo "$symlink already exists and is pointing to something else; exiting"
  exit 1
fi

./bin/dot_install

popd > /dev/null
