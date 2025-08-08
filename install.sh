#!/usr/bin/env bash
set -e

restow () {
  mkdir -p "${2}"

  # Removes broken links
  find -L "${2}" -type l -exec rm -- {} +

  # Recreates directory structure
  find "${1}" -type d -exec bash -c '
    base_dir="$1"
    path="$2"
    mkdir -p "$base_dir/${path#*/}"
  ' find-bash "${2}" {} ';'

  # Creates softlinks
  find "${1}" -type f '!' -name .DS_Store -exec bash -c '
    base_dir="$1"
    path="$2"
    ln -sf "$(pwd)/${path}" "$base_dir/${path#*/}"
  ' find-bash "${2}" {} ';'
}

restow config "${HOME}/.config"
restow bin "${HOME}/.local/bin"
eval "$(./bin/init_shell bash)"

if ./bin/has brew; then
  brew bundle --file ./config/homebrew/Brewfile
else
  echo "homebrew is not installed; skipping 'brew bundle'"
fi

if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "run 'chsh_fish' to set up fish"
fi

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
