#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "Homebrew Autoupdate"
}

check() {
  if command -v launchctl &> /dev/null; then
    launchctl list | grep -q "com.github.domt4.homebrew-autoupdate"
  fi
}

fix() {
  dot_setup brew
  brew autoupdate start --cleanup --immediate
}
