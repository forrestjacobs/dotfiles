#!/usr/bin/env bash
set -e

[ -f /etc/os-release ] && . /etc/os-release
if [[ "$ID" == "debian" ]] && (( "$VERSION_ID" >= 12 )); then
  sudo DEBIAN_FRONTEND=noninteractive apt-get update --yes
  sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends patchutils stow
fi

if [[ $(uname) == "Darwin" ]]; then
  brew_path=/opt/homebrew/bin
else
  brew_path=/home/linuxbrew/.linuxbrew/bin
fi

PATH=$brew_path:$PATH
if command -v brew &> /dev/null; then
  brew bundle --file ./config/homebrew/Brewfile
else
  echo "homebrew is not installed; skipping 'brew bundle'"
fi

if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "run 'chsh_fish' to set up fish"
fi

./bin/restow config "${HOME}/.config"
./bin/restow bin "${HOME}/.local/bin"

if [ -f "${HOME}/.bashrc" ]; then
  bashinitline='[ -f ~/.config/bash/bashrc ] && . ~/.config/bash/bashrc'
  grep -qxF "$bashinitline" "${HOME}/.bashrc" || echo "$bashinitline" >> "${HOME}/.bashrc"
fi

if [ ! -f "${HOME}/.gitconfig" ]; then
  mkdir -p "${HOME}/.config/git"
  touch "${HOME}/.config/git/config"
fi

git config --global user.name "Forrest Jacobs"
if ! git config --global user.email &> /dev/null; then
  git config --global user.email forrestjacobs@gmail.com
fi
git config --global init.defaultBranch main
git config --global pull.ff only
