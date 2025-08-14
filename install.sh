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
    if [[ "$path" =~ [/] ]]; then
      mkdir -p "$base_dir/${path#*/}"
    fi
  ' find-bash "${2}" {} ';'

  # Creates softlinks
  find "${1}" -type f '!' -name .DS_Store -exec bash -c '
    symlink="$1/${2#*/}"
    target="$(pwd)/${2}"
    if [ ! -L "$symlink" ]; then
      ln -s "$target" "$symlink"
    elif [ "$(readlink -f $symlink)" != "$target" ]; then
      echo "$symlink already exists and is pointing to something else; exiting"
      exit 1
    fi
  ' find-bash "${2}" {} ';'
}

pushd "$(dirname "${BASH_SOURCE:0}")" > /dev/null

echo 'Linking config files'
restow config "${HOME}/.config"
restow bin "${HOME}/.local/bin"

echo
echo 'Initializing shell'
eval "$(./bin/init_shell bash)"

echo
echo "Calling 'brew bundle'"
if has brew; then
  brew bundle --file ./config/homebrew/Brewfile
else
  echo "homebrew is not installed; skipping"
fi

echo
echo 'Configuring bash'
bashinitline='[ -f ~/.config/bash/bashrc ] && . ~/.config/bash/bashrc'
if ! grep -qxF "$bashinitline" "${HOME}/.bashrc"; then
  echo 'Adding bash config'
  echo "$bashinitline" >> "${HOME}/.bashrc"
fi

echo
echo 'Configuring git'
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

echo
echo 'Done!'

if [[ $(basename "$SHELL") != "fish" ]]; then
  echo "run 'chsh_fish' to set up fish"
fi

popd > /dev/null
