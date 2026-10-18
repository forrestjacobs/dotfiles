#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "homebrew"
}

check() {
  command -v brew &> /dev/null
}

fix() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  dot_reinstall
}
