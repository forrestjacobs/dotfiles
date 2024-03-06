#!/usr/bin/env bash

if command -v brew &> /dev/null; then
  brew bundle --no-lock
elif command -v apt-get &> /dev/null; then
  sudo apt-get update
  xargs -a packages.txt sudo apt-get install -y
fi

mkdir -p "${HOME}/.config/git";
touch "${HOME}/.config/git/config";

git config --global user.name "Forrest Jacobs"
if ! git config --global "user.email" > /dev/null; then
  git config --global user.email "forrestjacobs@gmail.com"
fi

git config --global pull.ff "only"
git config --global init.defaultBranch "main"

stow --no-folding -t "${HOME}/.config" config

if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "Change shell to fish"
  fish_path=$(which fish)
  echo "${fish_path}" | sudo tee -a /etc/shells > /dev/null
  chsh -s "${fish_path}"
fi
