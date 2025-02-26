#!/usr/bin/env bash

mkdir -p ~/.local/bin

if command -v brew &> /dev/null; then
  brew bundle --no-lock

  stow --no-folding -t "${HOME}/.config" config
  stow --no-folding -t "${HOME}/.local/bin" bin

  if [[ $(basename "$SHELL") != "fish" ]]; then
    echo "Change your shell to fish by running:"
    fish_path=$(which fish)
    if ! grep -q -F "${fish_path}" /etc/shells; then
      echo "  echo \"${fish_path}\" | sudo tee -a /etc/shells"
    fi
    echo "  chsh -s \"${fish_path}\""
  fi
else
  rsync -a "config/" "${HOME}/.config"
  rsync -a "bin/" "${HOME}/.local/bin"
fi
