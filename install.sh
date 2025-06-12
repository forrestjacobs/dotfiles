#!/usr/bin/env bash
set -e

mkdir -p ~/.local/bin

if !command -v brew &> /dev/null; then
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]; then
  PATH=/opt/homebrew/bin:$PATH
else
  PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
fi

brew bundle

if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "Change your shell to fish by running:"
  fish_path=$(type -P fish)
  if ! grep -q -F "${fish_path}" /etc/shells; then
    echo "Adding ${fish_path} to /etc/shells"
    echo "${fish_path}" | sudo tee -a /etc/shells
  fi
  echo "Changing shell to ${fish_path}"
  chsh -s "${fish_path}"
fi

inst() {
  find -L "${2}" -type l -delete
  stow --ignore "\.DS_Store" --no-folding -t "${2}" "${1}"
}

inst config "${HOME}/.config"
inst bin "${HOME}/.local/bin"
