#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "iTerm2 preferences"
}

check() {
  if command -v defaults &> /dev/null && defaults read com.googlecode.iterm2.plist &> /dev/null; then
    [[ $(defaults read com.googlecode.iterm2.plist PrefsCustomFolder) = "${HOME}/.local/share/chezmoi/iterm" ]]
    [[ $(defaults read com.googlecode.iterm2.plist LoadPrefsFromCustomFolder) = "1" ]]
  fi
}

fix() {
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.local/share/chezmoi/iterm"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}
