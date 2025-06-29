#!/usr/bin/env bash
set -e

if command -v lsb_release &> /dev/null && [[ $(lsb_release -sd) == "Debian GNU/Linux 12 (bookworm)" ]]; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get update --yes
  sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends fish patchutils stow
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

if [ -z "$SKIP_CHSH" ] && command -v fish &> /dev/null && [[ $(basename "$SHELL") != "fish" ]]; then
  fish_path=$(type -P fish)
  if ! grep -q -F "${fish_path}" /etc/shells; then
    echo "Adding ${fish_path} to /etc/shells"
    echo "${fish_path}" | sudo tee -a /etc/shells
  fi
  echo "Changing shell to ${fish_path}"
  sudo chsh -s "${fish_path}" $USER
fi

inst() {
  mkdir -p "${2}"
  # Removes broken links
  find -L "${2}" -type l -exec rm -- {} +
  stow --ignore "\.DS_Store" --no-folding -t "${2}" "${1}"
}

inst config "${HOME}/.config"
inst bin "${HOME}/.local/bin"

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
