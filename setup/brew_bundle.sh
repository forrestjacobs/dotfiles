#!/usr/bin/env bash
set -euo pipefail

brewfile="${HOME}/.config/homebrew/Brewfile"

describe() {
  echo "Homebrew bundle"
}

check() {
  brew bundle check --file "${brewfile}" --no-upgrade
}

fix() {
  brew bundle --file "${brewfile}" --no-upgrade
}
