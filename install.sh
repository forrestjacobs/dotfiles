#!/usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

echo 'Linking config files'
./home/.local/bin/dot_clean_links "${HOME}/.config"
./home/.local/bin/dot_clean_links "${HOME}/.local"
./home/.local/bin/dot_stow home "${HOME}"

echo
echo 'Initializing shell'
eval "$(shell=bash ./home/.config/dotfiles/shell/10-setup.sh)"

echo
echo "Calling 'brew bundle'"
if ! brew bundle --file ./home/.config/homebrew/Brewfile; then
  echo "homebrew failed; skipping"
fi

echo
echo 'Configuring git'
git_config() {
  if [[ "$(git config --global "$1")" != "$2" ]]; then
    git config --global "$1" "$2"
  fi
}
if [ ! -f "${HOME}/.gitconfig" ] && [ ! -f "${HOME}/.config/git/config" ]; then
  mkdir -p "${HOME}/.config/git"
  touch "${HOME}/.config/git/config"
  git_config user.name "Forrest Jacobs"
  git_config user.email forrestjacobs@gmail.com
fi
git_config init.defaultBranch main
git_config pull.ff only

echo
echo 'Done!'

echo
echo "Calling 'dot_doctor'"
dot_doctor

popd > /dev/null
