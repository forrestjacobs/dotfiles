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
add_line .bashrc 'eval "$(~/.local/bin/init_shell bash)"'
# shellcheck disable=SC2016
add_line .zshrc 'eval "$(~/.local/bin/init_shell zsh)"'

echo
echo 'Configuring git'
if [ ! -f "${HOME}/.gitconfig" ]; then
  mkdir -p "${HOME}/.config/git"
  touch "${HOME}/.config/git/config"
fi

git_config() {
  if [[ "$(git config --global "$1")" != "$2" ]]; then
    git config --global "$1" "$2"
  fi
}
git_config init.defaultBranch main
git_config pull.ff only

echo
echo 'Done!'

echo
dot_doctor

popd > /dev/null
