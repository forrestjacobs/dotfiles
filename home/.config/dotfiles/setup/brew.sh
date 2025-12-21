#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "homebrew"
}

check() {
  has brew
}

fix() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  dot_reinstall
}
