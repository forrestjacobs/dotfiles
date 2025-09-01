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
if ! has brew; then
  echo "Follow instructions at https://brew.sh/ to install homebrew, then rerun install.sh to get additional packages."
fi
if [ -f "${HOME}/.gitconfig" ]; then
  echo "Run 'mv ~/.gitconfig ~/.config/git' to move gitconfig to the XDG directory."
fi
if [[ "$(git config --global credential.https://github.com.helper)" != *"gh auth git-credential"* ]]; then
  echo "Install and set up the GitHub CLI:"
  echo "  brew install gh"
  echo "  gh auth login"
  echo "  gh auth setup-git"
fi
if [ ! -f /etc/sudoers.d/50-nopasswd ] && [ ! -f /etc/pam.d/sudo_local ]; then
  echo "Run 'setup_sudo' to set up Touch ID or passwordless sudo."
fi
if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "Run 'chsh_fish' to set up fish."
fi

popd > /dev/null
