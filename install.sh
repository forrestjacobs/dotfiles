#!/usr/bin/env bash

if command -v brew &> /dev/null; then
  brew bundle --no-lock
elif command -v apt-get &> /dev/null; then
  sudo apt-get install -y fish stow
fi

stow --no-folding -t "${HOME}/.config" config

if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "Change your shell to fish by running:"
  fish_path=$(which fish)
  if ! grep -q -F "${fish_path}" /etc/shells; then
    echo "  echo \"${fish_path}\" | sudo tee -a /etc/shells"
  fi
  echo "  chsh -s \"${fish_path}\""
fi
