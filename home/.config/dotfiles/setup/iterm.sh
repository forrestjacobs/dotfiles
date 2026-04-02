#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "iTerm2 preferences"
}

check() {
  if has defaults; then
    [[ $(defaults read com.googlecode.iterm2.plist PrefsCustomFolder) = "${HOME}/.config/dotfiles/iterm" ]]
    [[ $(defaults read com.googlecode.iterm2.plist LoadPrefsFromCustomFolder) = "1" ]]
  fi
}

fix() {
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.config/dotfiles/iterm"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}
