#!/usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

echo 'Linking config files'
./bin/dot_stow config "${HOME}/.config"
./bin/dot_stow bin "${HOME}/.local/bin"

echo
echo 'Initializing shell'
eval "$(shell=bash ./config/dotfiles/shell/10-setup.sh)"

echo
echo "Calling 'brew bundle'"
if ! brew bundle --file ./config/homebrew/Brewfile; then
  echo "homebrew failed; skipping"
fi

echo
echo 'Configuring shells'
add_line() {
  if ! grep -qxF "$2" "${HOME}/$1"; then
    echo "Updating $1"
    echo "$2" >> "${HOME}/$1"
  fi
}
# shellcheck disable=SC2016
add_line .bashrc 'eval "$(~/.local/bin/dot_shell bash)"'
# shellcheck disable=SC2016
add_line .zshrc 'eval "$(~/.local/bin/dot_shell zsh)"'

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
