#!/usr/bin/env bash
set -e

mkdir -p ~/.local/bin

if command -v brew &> /dev/null; then
  brew bundle --no-lock

  # We're only setting up fish from homebrew because other package managers's
  # fishes could be too old.
  if [[ $(basename "$SHELL") != "fish" ]]; then
    echo "Change your shell to fish by running:"
    fish_path=$(which fish)
    if ! grep -q -F "${fish_path}" /etc/shells; then
      echo "  echo \"${fish_path}\" | sudo tee -a /etc/shells"
    fi
    echo "  chsh -s \"${fish_path}\""
  fi
fi

inst() {
  if command -v stow &> /dev/null; then
    stow --ignore "\.DS_Store" --no-folding -t "${2}" "{$1}"
  elif command -v rsync &> /dev/null; then
    rsync -a "${1}/" "${2}"
  else
    echo "Could not install dotfiles. Install stow or rsync, then try again."
    exit 1
  fi
}

inst config "${HOME}/.config"
inst bin "${HOME}/.local/bin"
