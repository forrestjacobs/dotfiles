#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "gitconfig in XDG directory"
}

check() {
  [ ! -f "${HOME}/.gitconfig" ]
}

fix() {
  mv "${HOME}/.gitconfig" "${HOME}/.config/git"
}
