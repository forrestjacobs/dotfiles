#!/usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

echo 'Linking config files'
./bin/restow config "${HOME}/.config"
./bin/restow bin "${HOME}/.local/bin"

echo
echo 'Initializing shell'
eval "$(shell=bash ./config/init_shell/conf.d/10-setup.sh)"

echo
echo "Calling 'brew bundle'"
if has brew; then
  brew bundle --file ./config/homebrew/Brewfile
else
  echo "homebrew is not installed; skipping"
fi

echo
echo 'Configuring bash'
bashinitline='[ -f ~/.config/bash/bashrc ] && . ~/.config/bash/bashrc'
if ! grep -qxF "$bashinitline" "${HOME}/.bashrc"; then
  echo 'Adding bash config'
  echo "$bashinitline" >> "${HOME}/.bashrc"
fi

echo
echo 'Configuring git'
if [ ! -f "${HOME}/.gitconfig" ]; then
  mkdir -p "${HOME}/.config/git"
  touch "${HOME}/.config/git/config"
fi

git config --global init.defaultBranch main
git config --global pull.ff only

echo
echo 'Done!'

if [ ! -f /etc/sudoers.d/50-nopasswd ]; then
  echo "run 'setup_sudo' to set up passwordless sudo"
fi
if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "run 'chsh_fish' to set up fish"
fi

popd > /dev/null
