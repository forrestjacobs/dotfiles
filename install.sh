#!/usr/bin/env bash
set -e

if [[ $(uname) == "Darwin" ]]; then
  brew_path=/opt/homebrew/bin
elif [[ $(lsb_release -sd) == "Debian GNU/Linux 12 (bookworm)" ]]; then
  brew_path=/home/linuxbrew/.linuxbrew/bin
  sudo DEBIAN_FRONTEND=noninteractive apt-get update --yes
  sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes fish
fi

if ! command -v brew &> /dev/null; then
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "eval \"\$($brew_path/brew shellenv)\"" >> $HOME/.bashrc
fi

PATH=$brew_path:$PATH
brew bundle --file ./config/homebrew/Brewfile

if [[ $(basename "$SHELL") != "fish" ]]; then
  fish_path=$(type -P fish)
  if ! grep -q -F "${fish_path}" /etc/shells; then
    echo "Adding ${fish_path} to /etc/shells"
    echo "${fish_path}" | sudo tee -a /etc/shells
  fi
  echo "Changing shell to ${fish_path}"
  sudo chsh -s "${fish_path}" $USER
fi

inst() {
  # Removes broken links
  find "${2}" -type l -exec sh -c 'for x; do [ -e "$x" ] || rm "$x"; done' _ {} +
  stow --ignore "\.DS_Store" --no-folding -t "${2}" "${1}"
}

inst config "${HOME}/.config"

mkdir -p ~/.local/bin
inst bin "${HOME}/.local/bin"

git config -f "${HOME}/.config/git/config" user.name "Forrest Jacobs"
if ! git config --global user.email &> /dev/null; then
  git config -f "${HOME}/.config/git/config" user.email forrestjacobs@gmail.com
fi
git config -f "${HOME}/.config/git/config" init.defaultBranch main
git config -f "${HOME}/.config/git/config" pull.ff only
